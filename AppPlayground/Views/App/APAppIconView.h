//
//  APAppIconCell.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APApp.h"
#import "RateView.h"

@class APAppIconView;
@protocol APAppIconViewDelegate <NSObject>
@optional
- (void)appIconViewClicked:(APAppIconView *)view app:(APApp *)app;
- (void)appPriceButtonClicked:(APAppIconView *)view app:(APApp *)app;
@end

@interface APAppIconView : UIView
<UIGestureRecognizerDelegate>

@property (strong, nonatomic) APApp *app;
@property (weak, nonatomic) id<APAppIconViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *appNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appPriceLabel;
@property (strong, nonatomic) IBOutlet RateView *ratingsView;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

// Display an app for the cell
- (void)bindApp:(APApp *)app;

// Clear all info for the cell
- (void)clearAll;

- (IBAction)favButtonClicked:(UIButton *)sender;

- (IBAction)priceButtonClicked:(UIButton *)sender;

- (IBAction)handleTap:(UITapGestureRecognizer *)sender;

@end