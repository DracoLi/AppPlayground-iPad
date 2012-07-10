//
//  UIView+CustomViews.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-08.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CustomView)

// Loads a view from a nib file
+ (UIView *)viewWithNibName:(NSString *)nibName owner:(NSObject *)owner;

@end
