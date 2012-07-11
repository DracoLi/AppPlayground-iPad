//
//  APAppIconCell.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APAppIconView.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSNumber+Currency.h"
#import "NSString+EasyIcon.h"

@interface APAppIconView ()
@end

#define kAppIconPlaceHolderImage  @"appIcon-placeholder.png"

@implementation APAppIconView
@synthesize app = _app;
@synthesize delegate = _delegate;
@synthesize iconImageView = _iconImageView;
@synthesize appNameLabel = _appNameLabel;
@synthesize appPriceLabel = _appPriceLabel;
@synthesize ratingsView = _ratingsView;
@synthesize favButton = _favButton;
@synthesize categoryImageView = _categoryImageView;
@synthesize categoryLabel = _categoryLabel;

- (void)awakeFromNib {
  self.ratingsView.rating = 0;
  self.ratingsView.editable = NO;
  self.ratingsView.maxRating = 5;
}

- (void)bindApp:(APApp *)app {
  self.app = app;
  if (app) {
    self.appNameLabel.text = app.name;
    self.appPriceLabel.text = [app.price getPrice];
    self.categoryLabel.text = app.category;
    self.categoryImageView.image = [app.category getImageIcon];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:app.iconURLString]
                       placeholderImage:[UIImage imageNamed:kAppIconPlaceHolderImage]
                                success:nil 
                                failure:^(NSError *error) {
                                  NSLog(@"image loading error: %@", error.description);
                                }];
    self.ratingsView.rating = [app.generalRatings floatValue];
    self.favButton.selected = [app isFavoriteForCurrentChild];
  } else {
    [self clearAll];
  }
}

- (void)clearAll {
  self.appNameLabel.text = nil;
  self.appPriceLabel.text = nil;
  self.categoryLabel.text = nil;
  self.categoryImageView.image = nil;
  self.iconImageView.image = [UIImage imageNamed:kAppIconPlaceHolderImage];
  self.ratingsView.rating = 0;
  self.favButton.selected = NO;
}

- (IBAction)favButtonClicked:(UIButton *)sender {
  [self.app toggleFavoriteStatusForCurrentChild];
  self.favButton.selected = [self.app isFavoriteForCurrentChild];
}

- (IBAction)priceButtonClicked:(UIButton *)sender {
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(appPriceButtonClicked:app:)]) {
    [self.delegate appPriceButtonClicked:self app:self.app];
  }
}

#pragma mark - UIGestureRecognizer

- (IBAction)handleTap:(UITapGestureRecognizer *)sender {
  // Tell delegate an app is pressed and pass back the app
  if (self.delegate && 
      [self.delegate respondsToSelector:@selector(appIconViewClicked:app:)]) {
    [self.delegate appIconViewClicked:self app:self.app];
  }
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer 
       shouldReceiveTouch:(UITouch *)touch {
  if (self.favButton.superview != nil) {
    if ([touch.view isKindOfClass:[UIButton class]]) {
      return NO;
    }
  }
  return YES;
}

@end