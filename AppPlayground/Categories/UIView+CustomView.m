//
//  UIView+CustomViews.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-08.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "UIView+CustomView.h"

@implementation UIView (CustomView)

+ (UIView *)viewWithNibName:(NSString *)nibName owner:(NSObject *)owner {
  UINib *customView = [UINib nibWithNibName:nibName bundle:nil];
  return [[customView instantiateWithOwner:owner options:nil] objectAtIndex:0];
}

@end
