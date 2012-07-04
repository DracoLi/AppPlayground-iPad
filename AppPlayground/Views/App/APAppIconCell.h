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

@interface APAppIconCell : UITableViewCell

@property (strong, nonatomic) APApp *app;
@property (strong, nonatomic) IBOutlet UIImageView *iconImageView;
@property (strong, nonatomic) IBOutlet UILabel *appNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *appPriceLabel;
@property (strong, nonatomic) IBOutlet RateView *ratingsView;
@property (strong, nonatomic) IBOutlet UIButton *favButton;
@property (strong, nonatomic) IBOutlet UIImageView *categoryImageView;
@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

- (void)bindApp:(APApp *)app;
- (void)clearAll;
- (IBAction)favButtonClicked:(UIButton *)sender;

@end