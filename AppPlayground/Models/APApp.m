//
//  APApp.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APApp.h"
#import "APFavorites.h"

@implementation APApp
@synthesize name = _name;
@synthesize category = _category;
@synthesize iconURLString = _iconURLString;
@synthesize price = _price;
@synthesize generalRatings = _generalRatings;

// App property keys
#define kAppNameKey              @"AppNameKey"
#define kAppCategoryKey          @"AppCategoryKey"
#define kAppIconURLKey           @"AppIconURLKey"
#define kAppPriceKey             @"AppPriceKey"
#define kAppGeneralRatingKey     @"AppGeneralRatingKey"

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if(self) {
    _name             = [decoder decodeObjectForKey:kAppNameKey];
    _category         = [decoder decodeObjectForKey:kAppCategoryKey];
    _iconURLString    = [decoder decodeObjectForKey:kAppIconURLKey];
    _generalRatings   = [decoder decodeObjectForKey:kAppGeneralRatingKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:kAppNameKey];
  [encoder encodeObject:self.category forKey:kAppCategoryKey];
  [encoder encodeObject:self.iconURLString forKey:kAppIconURLKey];
  [encoder encodeObject:self.generalRatings forKey:kAppGeneralRatingKey];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"One App\nName: %@\nCategory: %@\nPrice: %f.2", 
          self.name, self.category, [self.price floatValue]];
}

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[APApp class]]) {
    APApp *target = (APApp *)object;
    if ([self.name isEqualToString:target.name]) {
      
      // If app name equals then rest should too or else something is wrong here.
      NSAssert( ![self.category isEqualToString:target.category] ||
                ![self.price isEqualToNumber:target.price] ||
                ![self.generalRatings isEqualToNumber:target.generalRatings], 
               @"Something's wrong here");
      return true;
    }
  }
  return false;
}

#pragma mark - Custom methods

- (BOOL)isFavorited {
  return [APFavorites isAppFavorited:self];
}

@end