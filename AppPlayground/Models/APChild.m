//
//  APChild.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APChild.h"
#import "APPersistenceManager.h"

@interface APChild ()
@end

@implementation APChild
@synthesize childID = _childID;
@synthesize name = _name;
@synthesize age = _age;
@synthesize interests = _interests;

// General keys
#define kChildrenListKey       @"ChildrenListKey"
#define kCurrentChildrenKey    @"CurrentChildKey"

// Child property keys
#define kChildIDKey            @"ChildIDKey"
#define kChildNameKey          @"ChildNameKey"
#define kChildAgeKey           @"ChildAgeKey"
#define kChildInterestsKey     @"ChildInterestsKey"


- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if(self) {
    _childID    = [decoder decodeIntegerForKey:kChildIDKey];
    _name       = [decoder decodeObjectForKey:kChildNameKey];
    _age        = [decoder decodeIntegerForKey:kChildAgeKey];
    _interests  = [decoder decodeObjectForKey:kChildInterestsKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeInteger:self.childID forKey:kChildIDKey];
  [encoder encodeObject:self.name forKey:kChildNameKey];
  [encoder encodeInteger:self.age forKey:kChildAgeKey];
  [encoder encodeObject:self.interests forKey:kChildInterestsKey];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"\nID: %d\nName: %@\nAge: %d", 
   self.childID, self.name, self.age];
}

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[APChild class]]) {
    APChild *target = (APChild *)object;
    if (self.childID == target.childID &&
        [self.name isEqualToString:target.name] &&
        self.age == target.age) {
      return true;
    }
  }
  return false;
}

- (NSDictionary *)queryDictionary {
  return [[NSDictionary alloc] initWithObjectsAndKeys: 
          self.name, @"name", 
          self.interests, @"interests", 
          self.age , @"age", 
          nil];
}

#pragma mark - Class methods

+ (NSArray *)getChildren {
  return [APPersistenceManager getDataFromDefaults:kChildrenListKey];
}

+ (void)addChild:(APChild *)child {
  NSMutableArray *children = [[APChild getChildren] mutableCopy];
  if (!children) children = [NSMutableArray array];
  child.childID = children.count;
  [children addObject:child];
  [APChild setChildren:children];
}

+ (void)setChildren:(NSArray *)children {
  [APPersistenceManager saveObjectToDefaults:children key:kChildrenListKey];
}

+ (void)updateChildren:(APChild *)child {
  // Get all children
  NSMutableArray *children = [[APChild getChildren] mutableCopy];
  
  // Determine which child to update
  __block APChild *childToRemove = nil;
  [children enumerateObjectsUsingBlock:^(id obj, NSUInteger index, BOOL *stop) {
    APChild *oneChild = (APChild *)obj;
    if (oneChild.childID == child.childID) {
      childToRemove = oneChild;
      *stop = YES;
      return;
    }
  }];
  
  // Remove old child and add new one
  [children removeObject:childToRemove];
  [children addObject:child];
  
  [APChild setChildren:children];
}

+ (APChild *)getCurrentChild {
  return [APPersistenceManager getDataFromDefaults:kCurrentChildrenKey];
}

+ (void)setCurrentChild:(APChild *)child {
  [APPersistenceManager saveObjectToDefaults:child key:kCurrentChildrenKey];
}

#pragma mark - Debug

+ (void)populateChildren {
  [APChild setChildren:[NSArray array]];
  APChild *one = [[APChild alloc] init];
  one.name = @"Draco";
  one.age = 18;
  one.interests = [[NSArray alloc] initWithObjects:@"shit", @"poop", nil];
  [APChild addChild:one];
  APChild *two = [[APChild alloc] init];
  two.name = @"Sunny";
  two.age = 3;
  two.interests = [[NSArray alloc] initWithObjects:@"hoha", @"dododood", nil];
  [APChild addChild:two];
}

+ (void)test {
  [APChild populateChildren];
  NSArray *children = [APChild getChildren];
  [APChild setCurrentChild:[children objectAtIndex:0]];
  APChild *tobesaved = [children objectAtIndex:0];
  APChild *current = [APChild getCurrentChild];
  NSAssert([tobesaved isEqual:current], @"must be equal child");
  APChild *dra = [[APChild alloc] init];
  dra.name = @"new";
  dra.age = 10;
  [APChild addChild:dra];
  [APChild addChild:dra];
  [APChild addChild:dra];
  children = [APChild getChildren];
  for (APChild *one in children) {
    NSLog(@"%@", one);
  }
}

@end
