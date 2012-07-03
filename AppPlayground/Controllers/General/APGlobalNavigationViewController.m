//
//  APGlobalNavigationViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APGlobalNavigationViewController.h"
#import "APChildSelectorViewController.h"

@interface APGlobalNavigationViewController ()

@end

@implementation APGlobalNavigationViewController
@synthesize sidebarView = _sidebarView;
@synthesize contentView = _contentView;
@synthesize currentViewController = _currentViewController;
@synthesize childSelectorPopover = _childSelectorPopover;
@synthesize homeViewController = _homeViewController;
@synthesize recommendedViewController = _recommendedViewController;
@synthesize filtersViewController = _filtersViewController;
@synthesize wishListViewController = _wishListViewController;
@synthesize profileViewController = _profileViewController;
@synthesize aboutViewController = _aboutViewController;

#pragma Intialization

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
  self.childSelectorPopover = [[UIPopoverController alloc] initWithContentViewController:content];
  self.childSelectorPopover.popoverContentSize = CGSizeMake(350, 300);
  self.childSelectorPopover.delegate = self;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  // Release any retained subviews of the main view.
  // e.g. self.myOutlet = nil;
}

#pragma Actions

- (IBAction)changeChildClicked:(UIButton *)sender {
  NSLog(@"Change chlid clicked");
  [self.childSelectorPopover presentPopoverFromRect:sender.frame inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
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

#pragma Showing Views

- (void)showHomeView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showRecommendationsView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showFiltersView:(BOOL)shouldShow animated:(BOOL)animated {
  
}

- (void)showWishList:(BOOL)shouldShow animated:(BOOL)animated {
  
}

#pragma Popover delegate
- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController {
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return interfaceOrientation == UIInterfaceOrientationLandscapeLeft ||
    interfaceOrientation == UIInterfaceOrientationLandscapeRight;
}

@end
