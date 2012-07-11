//
//  APChild.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APChild.h"
#import "APPersistenceManager.h"
#import "APChildManager.h"

@interface APChild ()
@end

@implementation APChild
@synthesize name = _name;
@synthesize age = _age;
@synthesize interests = _interests;
@synthesize favorites = _favorites;

// General keys

// Child property keys
#define kChildIDKey            @"ChildIDKey"
#define kChildNameKey          @"ChildNameKey"
#define kChildAgeKey           @"ChildAgeKey"
#define kChildInterestsKey     @"ChildInterestsKey"
#define kChildFavoritesKey     @"ChildFavoritesKey"

- (id)init {
  self = [super init];
  if (self) {
    _favorites = [[NSMutableArray alloc] init];
  }
  return self;
}

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if (self) {
    _name       = [decoder decodeObjectForKey:kChildNameKey];
    _age        = [decoder decodeIntegerForKey:kChildAgeKey];
    _interests  = [decoder decodeObjectForKey:kChildInterestsKey];
    _favorites  = [decoder decodeObjectForKey:kChildFavoritesKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:kChildNameKey];
  [encoder encodeInteger:self.age forKey:kChildAgeKey];
  [encoder encodeObject:self.interests forKey:kChildInterestsKey];
  [encoder encodeObject:self.favorites forKey:kChildFavoritesKey];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"\nName: %@\nAge: %d", self.name, self.age];
}

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[APChild class]]) {
    APChild *target = (APChild *)object;
    if ([self.name isEqualToString:target.name]) {
      return true;
    }
  }
  return false;
}

#pragma mark - Custom methods

- (NSDictionary *)queryDictionary {
  NSDictionary *results = [[NSMutableDictionary alloc] init];
  [results setValue:self.name forKey:@"name"];
  [results setValue:self.interests forKey:@"interests"];
  [results setValue:[NSNumber numberWithInt:self.age] forKey:@"age"];
  return results;
}

- (void)setToCurrentChild {
  [[APChildManager sharedInstance] makeChildCurrentChild:self];
}

- (void)toggleFavoriteStatusForApp:(APApp *)app {
  // Add or remove from favorites depending on whether app is favored already
  if ([self favorsApp:app]) {
    [self removeFromFavorites:app];
  }else {
    [self addToFavorites:app];
  }
}

- (BOOL)favorsApp:(APApp *)app {
  return [self.favorites containsObject:app];
}

- (void)addToFavorites:(APApp *)app {
  if (self.favorites == nil) {
    self.favorites = [NSMutableArray array];
  }
  if (![self favorsApp:app]) {
    [self.favorites addObject:app];    
#ifdef DEBUG
    [[APChildManager sharedInstance] saveData];
#endif
  }
}

- (void)removeFromFavorites:(APApp *)app {
  if (self.favorites && [self favorsApp:app]) {
    [self.favorites removeObject:app];
#ifdef DEBUG
    [[APChildManager sharedInstance] saveData];
#endif
  }
}

#pragma mark - Debug

+ (void)populateChildren {
  APChild *one = [[APChildManager sharedInstance] createChildWithName:@"Draco"];
  one.age = 18;
  one.interests = [[NSArray alloc] initWithObjects:@"shit", @"poop", nil];
  APChild *two = [[APChildManager sharedInstance] createChildWithName:@"Sunny"];
  two.age = 3;
  two.interests = [[NSArray alloc] initWithObjects:@"hoha", @"dododood", nil];
}

+ (void)test {
  [APChild populateChildren];
  NSArray *children = [[APChildManager sharedInstance] children];
  for (APChild *child in children) {
    NSLog(@"%@", child);
  }
  
  // Make a child current
  APChild *currentChild = [children objectAtIndex:0];
  [currentChild setToCurrentChild];
  
  // Change current child
  currentChild.age = 20;
  
  // Make sure childmanager's current child is updated
  NSLog(@"APChildManager's current child:");
  NSLog(@"%@", currentChild);
  
  // Update another child locally
  APChild *another = [children objectAtIndex:1];
  another.name = @"Sunny Poop";
  
  // Make this child current
  [another setToCurrentChild];
  
  // Get current from manager and check for info
  NSLog(@"APChildManager's new child = %@", [[APChildManager sharedInstance] currentChild]);
}

@end
