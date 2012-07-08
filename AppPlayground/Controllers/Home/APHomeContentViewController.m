//
//  APHomeContentViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APHomeContentViewController.h"
#import "SVPullToRefresh.h"
#import "Constants.h"
#import "APChild.h"
#import "APApp.h"
#import "APHomeAppSectionCell.h"

#define kAppSectionNameKey  @"section_name"
#define kAppSectionAppsKey  @"section_apps"

@interface APHomeContentViewController ()
- (void)currentChildChanged:(NSNotification *)notification;
@end

@implementation APHomeContentViewController
@synthesize tableView = _tableView;
@synthesize appsData = _appsData;

#pragma mark - View cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Register to receive notifications for current child
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(currentChildChanged) 
                                               name:kCurrentChildNotification
                                             object:nil];
  
  // TODO: customzie refresh view according to UI
  // self.tableView.pullToRefreshView.arrowColor = [UIColor whiteColor];
  
  // Initialize our tableview refresh
  __weak APHomeContentViewController *weakSelf = self;
  [self.tableView addPullToRefreshWithActionHandler:^{
    [weakSelf updateViewForCurrentChild];
  }];
  
  // Register our tableview with our custom app cells
  [self.tableView registerNib:[UINib nibWithNibName:@"APAppIconCell" bundle:nil]
       forCellReuseIdentifier:@"AppIconCellIdentifier"];
  
  // Populates our home view
  [self updateViewForCurrentChild];
}

- (void)viewDidUnload {
  [super viewDidUnload];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kCurrentChildNotification
                                                object:nil];
}

#pragma mark - Custom

- (void)currentChildChanged:(NSNotification *)notification {
  [self updateViewForCurrentChild];
}

- (void)updateViewForCurrentChild {
  
  APChild *currentChild = [APChild getCurrentChild];
  
  // Get new data for this child from server
  // UI updates are handled in the delegate that receives the apps
  NSString *resourcesPath = [@"/home" stringByAppendingQueryParameters:
                             [currentChild queryDictionary]];
  [[RKObjectManager sharedManager] 
   loadObjectsAtResourcePath:resourcesPath usingBlock:^(RKObjectLoader *loader) {
     loader.delegate = self;
  }];
  
  NSLog(@"update view for current child");
  self.appsData = [APApp getSampleApps];
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
  return self.appsData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  APHomeAppSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AppIconCellIdentifier"];
  [cell bindAppSection:[self.appsData objectAtIndex:indexPath.row]];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

#pragma mark - Server Response Delegate

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjectDictionary:(NSDictionary *)dictionary {
  
  // Store the new apps
  
  
  // TODO: Handle UI updates for new apps
  
  [self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
  
  NSLog(@"error getting home apps: %@", [error localizedDescription]);
  // TODO: Handle failure UI updates
}

#pragma mark - APHomeAppSectionCellDelegate

- (void)APHomeAppSectionAppSelected:(APHomeAppSectionCell *)cell app:(APApp *)app {
  NSLog(@"Home view got an app called %@", app.name);
}

#pragma mark - Others

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end