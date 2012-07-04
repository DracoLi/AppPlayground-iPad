//
//  APHomeContentViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APHomeContentViewController.h"
#import "Constants.h"
#import "APChild.h"

@interface APHomeContentViewController ()
- (void)currentChildChanged:(NSNotification *)notification;
@end

@implementation APHomeContentViewController
@synthesize tableView = _tableView;
@synthesize currentChild = _currentChild;
@synthesize appData = _appData;

#pragma mark - View cycle

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	
  // Register to receive notifications for current child
  [[NSNotificationCenter defaultCenter] addObserver:self 
                                           selector:@selector(currentChildChanged) 
                                               name:kCurrentChildNotification
                                             object:nil];
  
  // This method populates our whole homeview
  [self updateViewForCurrentChild];
}

- (void)viewDidUnload
{
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
  
  // TODO: Get new data for this child from server
  
  
  // TODO: Update UI to reflect new child
  
  // Update table
  [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  
}

#pragma mark - Others

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


@end
