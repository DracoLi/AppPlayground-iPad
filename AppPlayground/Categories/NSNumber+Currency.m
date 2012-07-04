//
//  NSNumber+Currency.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "NSNumber+Currency.h"

@implementation NSNumber (Currency)

- (NSString *)getPrice {
  return [self getPriceFromLocaleString:
          [[NSLocale preferredLanguages] objectAtIndex:0]];
}

- (NSString *)getPriceFromLocaleString:(NSString *)localString {
  NSNumberFormatter *numFormatter = [[NSNumberFormatter alloc] init];
  [numFormatter setFormatterBehavior:NSNumberFormatterBehaviorDefault];
  [numFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
  [numFormatter setLocale:[[NSLocale alloc] 
                           initWithLocaleIdentifier:localString]];
  return [numFormatter stringFromNumber:self];
}

@end
