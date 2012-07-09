//
//  TogglingImageView.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 Draken Solutions. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TogglingImageView;

@protocol TogglingImageViewDelegate <NSObject>
- (void)togglingImageViewSelected:(TogglingImageView *)theIcon;
@end

@interface TogglingImageView : UIImageView
  
@property BOOL isOn;
@property (weak, nonatomic) id<TogglingImageViewDelegate> delegate;

- (void)toggleOn;
- (void)toggleOff;

@end