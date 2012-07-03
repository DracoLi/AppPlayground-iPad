//
//  APGlobalNavigationViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APChild.h"

@interface APGlobalNavigationViewController : UIViewController 
<UIPopoverControllerDelegate>

@property (nonatomic, strong) IBOutlet UIView *sidebarView;
@property (nonatomic, strong) IBOutlet UIView *contentView;
@property (nonatomic, weak) UIViewController *currentViewController;

// Viable views
@property (nonatomic, strong) UIPopoverController *childSelectorPopover;
@property (nonatomic, strong) UIViewController *homeViewController;
@property (nonatomic, strong) UIViewController *recommendedViewController;
@property (nonatomic, strong) UIViewController *filtersViewController;
@property (nonatomic, strong) UIViewController *wishListViewController;
@property (nonatomic, strong) UIViewController *profileViewController;
@property (nonatomic, strong) UIViewController *aboutViewController;

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

@end
