//
//  APFavorites.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APApp.h"

@interface APFavorites : NSObject

+ (void)addToFavorites:(APApp *)app;

+ (void)removeFromFavorites:(APApp *)app;

+ (NSArray *)getAllFavorites;

+ (BOOL)isAppFavorited:(APApp *)app;

// Toggle the app's current favorite status.
// Returns the status after the toggle
+ (BOOL)toggleFavoriteStatus:(APApp *)app;

@end
