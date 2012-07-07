//
//  APGlobalNavigationViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APGlobalNavigationViewController.h"
#import "Constants.h"

@interface APGlobalNavigationViewController ()

@end

@implementation APGlobalNavigationViewController
@synthesize sidebarView = _sidebarView;
@synthesize contentView = _contentView;
@synthesize currentViewController = _currentViewController;
@synthesize childButton = _childButton;
@synthesize childSelectorPopover = _childSelectorPopover;
@synthesize homeViewController = _homeViewController;
@synthesize recommendedViewController = _recommendedViewController;
@synthesize filtersViewController = _filtersViewController;
@synthesize wishListViewController = _wishListViewController;
@synthesize profileViewController = _profileViewController;
@synthesize aboutViewController = _aboutViewController;

#pragma mark - Intialization

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
  
  // Set up child selector popover
  APChildSelectorViewController *content = [self.storyboard 
                                            instantiateViewControllerWithIdentifier:@"ChildSelectorView"];
  content.delegate = self;
  self.childSelectorPopover = [[UIPopoverController alloc] initWithContentViewController:content];
  self.childSelectorPopover.delegate = self;
  
  // Update current child
  [self updateCurrentChild:[APChild getCurrentChild]];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  [self setChildButton:nil];
  [self setSidebarView:nil];
  [self setContentView:nil];
}

#pragma mark - Actions

- (IBAction)changeChildClicked:(UIButton *)sender {
  [self.childSelectorPopover presentPopoverFromRect:sender.frame 
                                             inView:self.view 
                           permittedArrowDirections:UIPopoverArrowDirectionAny 
                                           animated:YES];
}

- (IBAction)homeButtonClicked:(UIButton *)sender {
  NSLog(@"home button clicked");
  [self showHomeView:YES animated:YES];
}

- (IBAction)recommendedButtonClicked:(UIButton *)sender {
  NSLog(@"recommended button clicked");
  [self showRecommendationsView:YES animated:YES];
}

- (IBAction)filtersButtonClicked:(UIButton *)sender {
  NSLog(@"filters button clicked");
  [self showFiltersView:YES animated:YES];
}

- (IBAction)wishListButtonClicked:(UIButton *)sender {
  NSLog(@"wishlist button clicked");
  [self showWishList:YES animated:YES];
}

#pragma mark - Showing Views

- (void)showHomeView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showRecommendationsView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showFiltersView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showWishList:(BOOL)shouldShow animated:(BOOL)animated {
  
}

#pragma mark - Sidebar utils

- (void)updateCurrentChild:(APChild *)child {
  
  // Update button title
  [self.childButton setTitle:child.name forState:UIControlStateNormal];
  
  // Update global child
  [APChild setCurrentChild:child];
  
  // Post notification that child is changed
  [[NSNotificationCenter defaultCenter] postNotificationName:kCurrentChildNotification
                                                      object:self];
}

#pragma mark - Popover delegate

- (void)childDidSelectForViewController:(APChildSelectorViewController *)view 
                                  child:(APChild *)child
                           shouldUpdate:(BOOL)shouldUpdate {
  [self.childSelectorPopover dismissPopoverAnimated:YES];
  
  // Update current view to reflect new child
  if (shouldUpdate) {
    [self updateCurrentChild:child];
  }
}

#pragma mark - Others

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
  interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

@end
