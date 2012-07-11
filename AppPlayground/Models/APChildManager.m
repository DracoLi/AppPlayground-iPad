//
//  APChildManager.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-11.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APChildManager.h"
#import "APPersistenceManager.h"

#define kChildrenListFileName  @"ChildrenList.plist"
#define kCurrentChildrenKey    @"CurrentChildKey"

@implementation APChildManager
@synthesize children = _children;
@synthesize currentChild = _currentChild;

- (void)addChild:(APChild *)child {
  if (self.children == nil) {
    self.children = [[NSMutableArray alloc] init];
  }
  if (![self.children containsObject:child]) {
    [self.children addObject:child];
  }
}

- (APChild *)createChildWithName:(NSString *)name {
  APChild *app = [[APChild alloc] init];
  app.name = name;
  [self addChild:app];
  return app;
}

- (APChild *)getChildWithName:(NSString *)name {
  APChild *result = nil;
  
  // Loop through children to find a child with the given name
  for (APChild *oneChild in self.children) {
    if ([oneChild isEqual:result]) {
      result = oneChild;
      break;
    }
  }
  return result;
}

- (void)removeChildWithName:(NSString *)name {
  APChild *target = [self getChildWithName:name];
  [self.children removeObject:target];
}

- (void)replaceChildNamed:(NSString *)name withChild:(APChild *)child {
  [self removeChildWithName:name];
  [self addChild:child];
}

- (void)saveData {
  // Save all children
  if (self.children) {
    [APPersistenceManager saveObject:self.children toFile:kChildrenListFileName];
  }
  
  // Save the currnet child
  if (self.currentChild) {
    [APPersistenceManager saveObjectToDefaults:self.currentChild key:kCurrentChildrenKey];
  }
}

- (void)makeChildCurrentChild:(APChild *)child {
  self.currentChild = child;
}

+ (APChildManager *)sharedInstance {
  static APChildManager *_singleton;
  static dispatch_once_t onceToken;
  dispatch_once(&onceToken, ^{
    // Create this child manager with children saved on file
    NSArray *results = (NSArray *)[APPersistenceManager getObjectFromFileNamed:kChildrenListFileName];
    if (results == nil)
      results = [NSArray array];
    _singleton = [[APChildManager alloc] init];
    _singleton.children = [[NSMutableArray alloc] initWithArray:results];
    
    // Get the current child
    _singleton.currentChild = [APPersistenceManager getDataFromDefaults:kCurrentChildrenKey];
  });
  return _singleton;
}

@end