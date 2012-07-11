//
//  APChild.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APApp.h"

@interface APChild : NSObject <NSCoding>

@property (copy, nonatomic)   NSString          *name;
@property (copy, nonatomic)   NSArray           *interests;
@property (assign, nonatomic) NSUInteger        age;
@property (strong, nonatomic) NSMutableArray    *favorites;

// Returns the child information we pass for queries on the server
- (NSDictionary *)queryDictionary;

// Make this child the current one used by the app
- (void)setToCurrentChild;

// Toggle the favorite status of an app
- (void)toggleFavoriteStatusForApp:(APApp *)app;

// Quick way to determine if an app is favorited for this child
- (BOOL)favorsApp:(APApp *)app;

// These setters make sure we don't add same apps into favorites
- (void)addToFavorites:(APApp *)app;
- (void)removeFromFavorites:(APApp *)app;

#ifdef DEBUG
+ (void)populateChildren;
+ (void)test;
#endif

@end
