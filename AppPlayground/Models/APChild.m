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
@synthesize name = _name;
@synthesize age = _age;
@synthesize interests = _interests;
@synthesize favorites = _favorites;

// General keys
#define kChildrenListFileName  @"ChildrenList.plist"
#define kCurrentChildrenKey    @"CurrentChildKey"

// Child property keys
#define kChildIDKey            @"ChildIDKey"
#define kChildNameKey          @"ChildNameKey"
#define kChildAgeKey           @"ChildAgeKey"
#define kChildInterestsKey     @"ChildInterestsKey"
#define kChildFavoritesKey     @"ChildFavoritesKey"

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

- (void)save {
  [APChild saveChild:self];
}

- (void)setToCurrentChild {
  [APChild setCurrentChild:self];
}

- (void)toggleFavoriteStatusForApp:(APApp *)app {
  // Add or remove from favorites depending on whether app is favored already
  if ([self favorsApp:app]) {
    [self removeFromFavorites:app];
  }else {
    NSLog(@"favorite before %d", self.favorites.count);
    [self addToFavorites:app];
    NSLog(@"favorite after %d", self.favorites.count);
  }
  [self save];
}

- (BOOL)favorsApp:(APApp *)app {
  return [self.favorites containsObject:app];
}

- (void)addToFavorites:(APApp *)app {
  if (![self favorsApp:app]) {
    if (self.favorites == nil) {
      self.favorites = [NSMutableArray array];
    }
    [self.favorites addObject:app];
    [self save];
  }
}

- (void)removeFromFavorites:(APApp *)app {
  if (self.favorites && [self favorsApp:app]) {
    [self.favorites removeObject:app];
    [self save];
  }
}

#pragma mark - Class methods

+ (NSArray *)children {
  NSArray *results = (NSArray *)[APPersistenceManager getObjectFromFileNamed:kChildrenListFileName];
  if (results == nil) {
    results = [NSArray array];
  }
  return results;
}

+ (void)setChildren:(NSArray *)children {
  if (children) {
    [APPersistenceManager saveObject:children toFile:kChildrenListFileName];
  }
}

+ (void)saveChild:(APChild *)child {
  // Get all current children
  NSMutableArray *children = [[APChild children] mutableCopy];
  if (children == nil) {
    children = [NSMutableArray array];
  }
  
  // Check if this child is an existing child or a new one and handle it
  int existingIndex = [children indexOfObject:child];
  if (existingIndex == NSNotFound) {
    [children addObject:child];
  }else {
    [children replaceObjectAtIndex:existingIndex withObject:child];
  }
  
  // Save changes to global children file
  [APChild setChildren:children];
  
  // Save changes to default if this is the temp chlid
  APChild *current = [APChild currentChild];
  if ([child isEqual:current]) {
    [APChild setCurrentChild:child];
  }
}

+ (APChild *)currentChild {
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
  [one save];
  APChild *two = [[APChild alloc] init];
  two.name = @"Sunny";
  two.age = 3;
  two.interests = [[NSArray alloc] initWithObjects:@"hoha", @"dododood", nil];
  [two save];
}

+ (void)test {
  [APChild populateChildren];
  NSArray *children = [APChild children];
  [APChild setCurrentChild:[children objectAtIndex:0]];
  APChild *tobesaved = [children objectAtIndex:0];
  APChild *current = [APChild currentChild];
  NSAssert([tobesaved isEqual:current], @"must be equal child");
  for (APChild *one in [APChild children]) {
    NSLog(@"%@", one);
  }
}

@end
