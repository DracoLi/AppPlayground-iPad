//
//  APChild.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APChild : NSObject <NSCoding>

@property (assign, nonatomic) NSUInteger childID;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSArray *interests;
@property (assign, nonatomic) NSUInteger age;

// Returns the child information we pass for queries on the server
- (NSDictionary *)queryDictionary;


+ (NSArray *)getChildren;

+ (APChild *)getCurrentChild;

+ (void)setChildren:(NSArray *)children;

+ (void)setCurrentChild:(APChild *)child;

+ (void)addChild:(APChild *)child;

+ (void)updateChildren:(APChild *)child;

#ifdef DEBUG
+ (void)populateChildren;

+ (void)test;
#endif

@end
