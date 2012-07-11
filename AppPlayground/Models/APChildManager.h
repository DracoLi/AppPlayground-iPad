//
//  APChildManager.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-11.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APChild.h"

@interface APChildManager : NSObject

@property (strong, nonatomic) NSMutableArray  *children;
@property (strong, nonatomic) APChild         *currentChild;

- (void)addChild:(APChild *)child;

// Main way to create a child and add it to children list
- (APChild *)createChildWithName:(NSString *)name;

- (APChild *)getChildWithName:(NSString *)name;

- (void)removeChildWithName:(NSString *)name;

- (void)replaceChildNamed:(NSString *)name withChild:(APChild *)child;

- (void)makeChildCurrentChild:(APChild *)child;

- (void)saveData;

+ (APChildManager *)sharedInstance;
@end
