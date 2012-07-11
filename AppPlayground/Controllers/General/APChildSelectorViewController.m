//
//  APChildSelectorViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APChildSelectorViewController.h"
#import "APChildCell.h"

@interface APChildSelectorViewController ()

@end

@implementation APChildSelectorViewController
@synthesize children = _children;
@synthesize selectedChild = _selectedChild;
@synthesize delegate = _delegate;

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.clearsSelectionOnViewWillAppear = NO;
  
  // Get data and current child
  self.children = [APChild children];
}

- (void)viewDidAppear:(BOOL)animated {
  
  // Initialize selected child and select the row if first initialization
  if (self.selectedChild == nil) {
    self.selectedChild = [APChild currentChild];
    NSUInteger targetRow = [self.children indexOfObject:self.selectedChild];
    [self.tableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:targetRow inSection:0]
                                animated:NO
                          scrollPosition:UITableViewScrollPositionNone];
  }
}

- (void)viewDidUnload
{
  [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  // Return the number of sections.
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // Return the number of rows in the section.
  return [self.children count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  APChildCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ChildIdentifier"];
  APChild *thisChild = [self.children objectAtIndex:indexPath.row];
  cell.textLabel.text = thisChild.name;
  return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  APChild *newChild = [self.children objectAtIndex:indexPath.row];
  
  // Notify delegate row is clicked and whether this is a different child
  if (self.delegate && [self.delegate 
                        respondsToSelector:@selector(childDidSelectForViewController:child:shouldUpdate:)]) {
    [self.delegate childDidSelectForViewController:self 
                                             child:newChild
                                      shouldUpdate:![newChild isEqual:self.selectedChild]];
  }
  self.selectedChild = newChild;
}

@end
