//
//  APApp.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APApp.h"

@implementation APApp
@synthesize name = _name;
@synthesize category = _category;
@synthesize iconURLString = _iconURLString;
@synthesize price = _price;
@synthesize generalRatings = _generalRatings;

// App property keys
#define AppNameKey              @"AppNameKey"
#define AppCategoryKey          @"AppCategoryKey"
#define AppIconURLKey           @"AppIconURLKey"
#define AppPriceKey             @"AppPriceKey"
#define AppGeneralRatingKey     @"AppGeneralRatingKey"

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if(self) {
    _name             = [decoder decodeObjectForKey:AppNameKey];
    _category         = [decoder decodeObjectForKey:AppCategoryKey];
    _iconURLString    = [decoder decodeObjectForKey:AppIconURLKey];
    _generalRatings   = [decoder decodeObjectForKey:AppGeneralRatingKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.name forKey:AppNameKey];
  [encoder encodeObject:self.category forKey:AppCategoryKey];
  [encoder encodeObject:self.iconURLString forKey:AppIconURLKey];
  [encoder encodeObject:self.generalRatings forKey:AppGeneralRatingKey];
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

@end
