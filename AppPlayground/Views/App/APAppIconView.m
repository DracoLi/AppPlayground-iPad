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
#import "APFavorites.h"

@interface APAppIconView ()
- (void)handleTap:(UITapGestureRecognizer *)sender;
- (void)loadSubviews;
@end

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

#define PlaceHolderImage  @"appIcon-placeholder.png"

- (id)init {
  self = [super init];
  if (self) {
    [self loadSubviews];
  }
  return self;
}

- (id)initWithDelegate:(id<APAppIconViewDelegate>)delegate {
  self = [super init];
  if (self) {
    _delegate = delegate;
    [self loadSubviews];
  }
  return self;
}

- (void)loadSubviews {
  // Set up all subviews
  self.iconImageView = [[UIImageView alloc] 
                        initWithFrame:CGRectMake(9, 13, 83, 74)];
  self.appNameLabel = [[UILabel alloc] 
                       initWithFrame:CGRectMake(111, 9, 107, 21)];
  self.appPriceLabel = [[UILabel alloc] 
                        initWithFrame:CGRectMake(140, 31, 73, 21)];
  self.ratingsView = [[RateView alloc] initWithFrame:CGRectMake(111, 57, 100, 31)];
  self.favButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
  self.favButton.frame = CGRectMake(3, 3, 32, 37);
  UILabel *favLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, 11, 43, 21)];
  favLabel.text = @"Fav It!";
  self.categoryImageView = [[UIImageView alloc] initWithFrame:
                            CGRectMake(6, 7, 35, 30)];
  UILabel *categoryLabel = [[UILabel alloc] 
                            initWithFrame:CGRectMake(52, 10, 42, 21)];
  
  // Add all subviews
  [self addSubview:self.iconImageView];
  [self addSubview:self.appNameLabel];
  [self addSubview:self.appPriceLabel];
  [self addSubview:self.ratingsView];
  [self addSubview:self.favButton];
  [self addSubview:self.categoryImageView];
  [self addSubview:favLabel];
  [self addSubview:categoryLabel];
  
  // Add tap recognizer to the view
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(viewTapped)];
  tap.numberOfTapsRequired = 1;
  tap.numberOfTouchesRequired = 1;
  [self addSubview:tap.view];
  [self sendSubviewToBack:tap.view]; 
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

- (void)handleTap:(UITapGestureRecognizer *)sender {
  // Tell delegate an app is pressed and pass back the app
  if (self.delegate && 
      [self.delegate respondsToSelector:@selector(appIconViewClicked:app:)]) {
    [self.delegate appIconViewClicked:self app:self.app];
  }
}

@end