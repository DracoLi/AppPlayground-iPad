//
//  RateView.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@class RateView;

@protocol RateViewDelegate
- (void)rateView:(RateView *)rateView ratingDidChange:(float)rating;
@end

@interface RateView : UIView

@property (strong, nonatomic) UIImage *notSelectedImage;
@property (strong, nonatomic) UIImage *halfSelectedImage;
@property (strong, nonatomic) UIImage *fullSelectedImage;
@property (assign, nonatomic) float rating;
@property (assign, nonatomic) BOOL editable;
@property (strong, nonatomic) NSMutableArray * imageViews;
@property (assign, nonatomic) int maxRating;
@property (assign, nonatomic) int midMargin;
@property (assign, nonatomic) int leftMargin;
@property (assign, nonatomic) CGSize minImageSize;
@property (weak, nonatomic) id <RateViewDelegate> delegate;

@end
