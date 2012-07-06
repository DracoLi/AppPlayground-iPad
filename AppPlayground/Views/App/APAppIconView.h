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
@end

@interface APAppIconView : UIView

@property (strong, nonatomic) APApp *app;
@property (weak, nonatomic) id<APAppIconViewDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *appNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appPriceLabel;
@property (strong, nonatomic) IBOutlet RateView *ratingsView;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

- (id)initWithDelegate:(id<APAppIconViewDelegate>)delegate;

- (void)bindApp:(APApp *)app;

- (void)clearAll;

- (IBAction)favButtonClicked:(UIButton *)sender;

@end