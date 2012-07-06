//
//  NSString+EasyIcon.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "NSString+EasyIcon.h"

@implementation NSString (EasyIcon)

- (UIImage *)getImageIcon {
  NSString *imagePath = [NSString stringWithFormat:@"%@_icon.png", self];
  return [UIImage imageNamed:imagePath];
}

@end
