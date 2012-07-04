//
//  APAppIconCell.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APAppIconCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "NSNumber+Currency.h"
#import "NSString+EasyIcon.h"
#import "APFavorites.h"

@implementation APAppIconCell
@synthesize app = _app;
@synthesize iconImageView = _iconImageView;
@synthesize appNameLabel = _appNameLabel;
@synthesize appPriceLabel = _appPriceLabel;
@synthesize ratingsView = _ratingsView;
@synthesize favButton = _favButton;
@synthesize categoryImageView = _categoryImageView;
@synthesize categoryLabel = _categoryLabel;

#define PlaceHolderImage  @"appIcon-placeholder.png"

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self clearAll];
  }
  
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

- (void)bindApp:(APApp *)app {
  if (app) {
    self.appNameLabel.text = app.name;
    self.appPriceLabel.text = [app.price getPrice];
    self.categoryLabel.text = app.category;
    self.categoryImageView.image = [app.category getImageIcon];
    [self.iconImageView setImageWithURL:[NSURL URLWithString:app.iconURLString]
                       placeholderImage:[UIImage imageNamed:PlaceHolderImage]
                                success:nil 
                                failure:^(NSError *error) {
                                  NSLog(@"image loading error: %@", error.description);
                                }];
    self.ratingsView.rating = [app.generalRatings floatValue];
    self.favButton.selected = [app isFavorited];
  } else {
    [self clearAll];
  }
}

- (void)clearAll {
  self.appNameLabel.text = nil;
  self.appPriceLabel.text = nil;
  self.categoryLabel.text = nil;
  self.categoryImageView.image = nil;
  self.iconImageView.image = [UIImage imageNamed:PlaceHolderImage];
  self.ratingsView.rating = 0;
  self.favButton.selected = NO;
}

- (IBAction)favButtonClicked:(UIButton *)sender {
  [APFavorites toggleFavoriteStatus:self.app];
}

@end