//
//  APGlobalNavigationViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APChild.h"
#import "APChildSelectorViewController.h"

@interface APGlobalNavigationViewController : UIViewController 
<UIPopoverControllerDelegate, APChildSelectorDelegate>

// General Properties
@property (strong, nonatomic) IBOutlet UIView *sidebarView;
@property (strong, nonatomic) IBOutlet UIView *contentView;
@property (strong, nonatomic) UIViewController *currentViewController;

// Sidebar views
@property (strong, nonatomic) IBOutlet UIButton *childButton;
@property (strong, nonatomic) UIPopoverController *childSelectorPopover;

// Content views
@property (strong, nonatomic) UIViewController *homeViewController;
@property (strong, nonatomic) UIViewController *recommendedViewController;
@property (strong, nonatomic) UIViewController *filtersViewController;
@property (strong, nonatomic) UIViewController *wishListViewController;
@property (strong, nonatomic) UIViewController *profileViewController;
@property (strong, nonatomic) UIViewController *aboutViewController;

//////// Methods ///////

// Actions
- (IBAction)changeChildClicked:(UIButton *)sender;
- (IBAction)homeButtonClicked:(UIButton *)sender;
- (IBAction)recommendedButtonClicked:(UIButton *)sender;
- (IBAction)filtersButtonClicked:(UIButton *)sender;
- (IBAction)wishListButtonClicked:(UIButton *)sender;

// Showing Views
- (void)showHomeView:(BOOL)shouldShow animated:(BOOL)animated;
- (void)showRecommendationsView:(BOOL)shouldShow animated:(BOOL)animated;
- (void)showFiltersView:(BOOL)shouldShow animated:(BOOL)animated;
- (void)showWishList:(BOOL)shouldShow animated:(BOOL)animated;

// Sidebar utils
- (void)updateCurrentChild:(APChild *)child;

@end
