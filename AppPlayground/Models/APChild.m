//
//  APChild.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APChild.h"
#import "APFileManager.h"

@interface APChild ()
- (BOOL)saveChild;
@end

@implementation APChild
@synthesize childID = _childID;
@synthesize name = _name;
@synthesize age = _age;
@synthesize interests = _interests;

// General keys
#define ChildrenListKey       @"ChildrenListKey"
#define CurrentChildrenKey    @"CurrentChildKey"

// Child property keys
#define ChildIDKey            @"ChildIDKey"
#define ChildNameKey          @"ChildNameKey"
#define ChildAgeKey           @"ChildAgeKey"
#define ChildInterestsKey     @"ChildInterestsKey"

- (BOOL)saveChild {
  return YES;
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if(self) {
    _childID    = [decoder decodeIntegerForKey:ChildIDKey];
    _name       = [decoder decodeObjectForKey:ChildNameKey];
    _age        = [decoder decodeIntegerForKey:ChildAgeKey];
    _interests  = [decoder decodeObjectForKey:ChildInterestsKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeInteger:self.childID forKey:ChildIDKey];
  [encoder encodeObject:self.name forKey:ChildNameKey];
  [encoder encodeInteger:self.age forKey:ChildAgeKey];
  [encoder encodeObject:self.interests forKey:ChildInterestsKey];
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

#pragma mark - Class methods

+ (NSArray *)getChildren {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *resultsData = [defaults objectForKey:ChildrenListKey];
  NSArray *results = [NSArray array];
  if (resultsData != nil) {
    NSArray *savedArray = [NSKeyedUnarchiver unarchiveObjectWithData:resultsData];
    if (savedArray != nil) 
      results = savedArray;
  }
  return results;
}

+ (void)addChild:(APChild *)child {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSMutableArray *children = [[APChild getChildren] mutableCopy];
  if (!children) children = [NSMutableArray array];
  child.childID = children.count;
  [children addObject:child];
  [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:children] forKey:ChildrenListKey];
  [defaults synchronize];
}

+ (void)setChildren:(NSArray *)children {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:children] forKey:ChildrenListKey];
  [defaults synchronize];
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
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *resultsData = [defaults objectForKey:CurrentChildrenKey];
  APChild *result = nil;
  if (resultsData != nil) {
    result = [NSKeyedUnarchiver unarchiveObjectWithData:resultsData];
  }
  return result;
}

+ (void)setCurrentChild:(APChild *)child {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:child] 
               forKey:CurrentChildrenKey];
  [defaults synchronize];
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
  [APChild setCurrentChild:[children objectAtIndex:1]];
  APChild *tobesaved = [children objectAtIndex:1];
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
