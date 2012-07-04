//
//  NSNumber+Currency.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSNumber (Currency)

- (NSString *)getPrice;
- (NSString *)getPriceFromLocaleString:(NSString *)localString;

@end
