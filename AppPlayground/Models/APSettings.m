//
//  APSettings.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-10.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APSettings.h"

@implementation APSettings

+ (NSString *)userCountryCode {
  NSLocale *locale = [NSLocale currentLocale];
  NSString *countryCode = [locale objectForKey:NSLocaleCountryCode];
  return countryCode;
}

@end
