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
#import "APServerHomeSection.h"

#define kAppSectionNameKey  @"section_name"
#define kAppSectionAppsKey  @"section_apps"

@interface APHomeContentViewController ()
- (void)currentChildChanged:(NSNotification *)notification;
- (void)printCurrentSections;
@end

@implementation APHomeContentViewController
@synthesize tableView = _tableView;
@synthesize appSections = _appSections;
@synthesize deviceSelectorButton = _deviceSelectorButton;
@synthesize popover = _popover;

#pragma mark - View cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Register to receive notifications for current child
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(currentChildChanged) 
                                               name:kCurrentChildNotification
                                             object:nil];
  
  // Initilize our device selector
  APDeviceSelectorViewController *deviceSelector = 
    [[UIStoryboard storyboardWithName:@"NavigationStoryboard" bundle:nil] 
     instantiateViewControllerWithIdentifier:@"DeviceSelectorViewIdentifier"];
  self.popover = [[UIPopoverController alloc] 
             initWithContentViewController:deviceSelector];
  deviceSelector.delegate = self;
  
  // TODO: customzie refresh view according to UI
  // self.tableView.pullToRefreshView.arrowColor = [UIColor whiteColor];
  
  // Initialize our tableview refresh
  __weak APHomeContentViewController *weakSelf = self;
  [self.tableView addPullToRefreshWithActionHandler:^{
    [weakSelf updateViewForCurrentChild];
  }];
  
  // Register our tableview with our custom app cells
  [self.tableView registerNib:[UINib nibWithNibName:@"APHomeAppSectionCell" bundle:nil]
       forCellReuseIdentifier:@"APHomeAppSectionCellIdentifier"];
  
  // Populates our home view
  [self updateViewForCurrentChild];
}

- (void)viewDidUnload {
  [self setDeviceSelectorButton:nil];
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
  
  // APChild *currentChild = [APChild getCurrentChild];
  
  // Get new data for this child from server
  // UI updates are handled in the delegate that receives the apps
//  NSString *resourcesPath = [@"/home" stringByAppendingQueryParameters:
//                             [currentChild queryDictionary]];
//  [[RKObjectManager sharedManager] 
//   loadObjectsAtResourcePath:resourcesPath usingBlock:^(RKObjectLoader *loader) {
//     loader.targetObject = nil;
//     loader.delegate = self;
//  }];
  
  NSLog(@"update view for current child");
  self.appSections = [APServerHomeSection sampleSections];
  
  // Stop refreshing
  [self.tableView.pullToRefreshView stopAnimating];
  
  [self.tableView reloadData];
}

- (IBAction)deviceSelectorClicked:(UIButton *)sender {
  [self.popover presentPopoverFromRect:sender.frame inView:self.view 
              permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)printCurrentSections {
  for (APServerHomeSection *section in self.appSections) {
    NSLog(@"section name: %@", section.name);
    NSLog(@"section apps: %@", section.apps);
    NSLog(@"-------------");
  }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
  return self.appSections.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  APHomeAppSectionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"APHomeAppSectionCellIdentifier"];
  if (cell.delegate == nil) 
    cell.delegate = self;
  [cell bindAppSection:[self.appSections objectAtIndex:indexPath.row]];
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
  
}

#pragma mark - Server Response Delegate

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
  
  // Handle errors retreiving from the server
  // TODO: alert user of error through UI
  NSError *error;
  NSDictionary *responseDic = [response parsedBody:&error];
  if (error) {
    NSLog(@"Error loading response: %@", [error localizedDescription]);
  }
  if ([responseDic valueForKey:@"success"] == false) {
    NSLog(@"Error retreiving from server: %@", [responseDic valueForKey:@"message"]);
  }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)object {
  self.appSections = object;
  [self.tableView reloadData];
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didFailWithError:(NSError *)error {
  // TODO: Alert user of error through UI
  NSLog(@"Error: %@", [error description]);
}

#pragma mark - APHomeAppSectionCellDelegate

- (void)APHomeAppSectionAppSelected:(APHomeAppSectionCell *)cell app:(APApp *)app {
  NSLog(@"User selected an app called %@", app.name);
}

- (void)APHomeAppSectionAppPriceClicked:(APHomeAppSectionCell *)cell app:(APApp *)app {
  NSLog(@"User selected the price of app '%@'", app.name);
}

#pragma mark - APDeviceSelectorDelegate

- (void)apDeviceSelectorDeviceChanged:(NSString *)device {
  [self.deviceSelectorButton setTitle:device forState:UIControlStateNormal];
}

#pragma mark - Others

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end