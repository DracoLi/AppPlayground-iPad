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
#import "APChildManager.h"
#import "APSettings.h"
#import "APApp.h"
#import "APServerHomeSection.h"

#define kAppSectionNameKey  @"section_name"
#define kAppSectionAppsKey  @"section_apps"

@interface APHomeContentViewController ()
- (void)currentChildChanged:(NSNotification *)notification;
- (void)printCurrentSections;
- (NSDictionary *)parametersForServer;
@end

@implementation APHomeContentViewController
@synthesize tableView = _tableView;
@synthesize appSections = _appSections;
@synthesize deviceSelectorButton = _deviceSelectorButton;
@synthesize devicePopover = _devicePopover;

#pragma mark - View cycle

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Register to receive notifications for current child
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(currentChildChanged:) 
                                               name:kCurrentChildNotification
                                             object:nil];
  
  // Initilize our device selector
  APDeviceSelectorViewController *deviceSelector = 
    [[UIStoryboard storyboardWithName:@"NavigationStoryboard" bundle:nil] 
     instantiateViewControllerWithIdentifier:@"DeviceSelectorViewIdentifier"];
  self.devicePopover = [[UIPopoverController alloc] 
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
  [self clearAndUpdateViewForCurrentChild];
}

- (void)viewDidUnload {
  [super viewDidUnload];
  [self setDeviceSelectorButton:nil];
  [self setTableView:nil];
}

- (void)dealloc {
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:kCurrentChildNotification
                                                object:nil];
}

#pragma mark - Custom

- (void)currentChildChanged:(NSNotification *)notification {
  [self clearAndUpdateViewForCurrentChild];
}

- (void)clearAndUpdateViewForCurrentChild {
  self.appSections = nil;
  [self.tableView reloadData];
  [self updateViewForCurrentChild];
}

- (void)updateViewForCurrentChild {
  // Get new data for this child from server
  // UI updates are handled in the delegate that receives the apps
  NSString *resourcesPath = [@"/home" stringByAppendingQueryParameters:
                             [self parametersForServer]];
  [[RKObjectManager sharedManager] 
   loadObjectsAtResourcePath:resourcesPath usingBlock:^(RKObjectLoader *loader) {
     NSLog(@"fetch url = %@", loader.URL.description);
     loader.targetObject = nil;
     loader.delegate = self;
  }];
  
//  NSLog(@"update view for current child");
//  self.appSections = [APServerHomeSection sampleSections];
//  
//  // Stop refreshing
//  [self.tableView.pullToRefreshView stopAnimating];
//  
//  [self.tableView reloadData];
}

- (IBAction)deviceSelectorClicked:(UIButton *)sender {
  [self.devicePopover presentPopoverFromRect:sender.frame inView:self.view 
                    permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
}

- (void)printCurrentSections {
  for (APServerHomeSection *section in self.appSections) {
    NSLog(@"section name: %@", section.name);
    NSLog(@"section apps: %@", section.apps);
    NSLog(@"-------------");
  }
}

- (NSDictionary *)parametersForServer {
  NSMutableDictionary *serverParms = [[[APChildManager sharedInstance].currentChild queryDictionary] mutableCopy];
  [serverParms setValue:[[APSettings userCountryCode] lowercaseString] 
                 forKey:@"country"];
  APDeviceSelectorViewController *deviceController = (APDeviceSelectorViewController *)
                                                     [self.devicePopover contentViewController];
  [serverParms setValue:[[deviceController getSelectedDevice] lowercaseString] 
                 forKey:@"device"];
  return serverParms;
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

#pragma mark - Server Response Delegate

- (void)request:(RKRequest *)request didLoadResponse:(RKResponse *)response {
  
  // Handle errors retreiving from the server
  // TODO: alert user of error through UI
  NSError *error;
  NSDictionary *responseDic = [response parsedBody:&error];
  if (error) {
    NSLog(@"Error loading response: %@", [error localizedDescription]);
  }else if ([responseDic valueForKey:@"success"] == false) {
    NSLog(@"Error retreiving from server: %@", [responseDic valueForKey:@"message"]);
  }
}

- (void)objectLoader:(RKObjectLoader *)objectLoader didLoadObjects:(NSArray *)object {
  self.appSections = object;
  [self.tableView.pullToRefreshView stopAnimating];
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
  BOOL deviceChanged = ![device isEqualToString:self.deviceSelectorButton.titleLabel.text];
  if (deviceChanged) {
    // Update device button
    [self.deviceSelectorButton setTitle:device forState:UIControlStateNormal];
    
    // Clear the table before updating
    [self clearAndUpdateViewForCurrentChild];
  }
  [self.devicePopover dismissPopoverAnimated:YES];
}

#pragma mark - Others

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

@end