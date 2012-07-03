//
//  APChild.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APChild : NSObject <NSCoding>

@property (nonatomic) NSUInteger childID;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSArray *interests;
@property (nonatomic) NSUInteger age;

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
