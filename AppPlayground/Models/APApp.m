//
//  APApp.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APApp.h"
#import <RestKit/RestKit.h>
#import "APChild.h"
#import "APChildManager.h"

@implementation APApp
@synthesize appID = _appID;
@synthesize name = _name;
@synthesize category = _category;
@synthesize iconURLString = _iconURLString;
@synthesize price = _price;
@synthesize generalRatings = _generalRatings;
@synthesize country = _country;

// App property keys
#define kAppIDKey                @"AppIDKey"
#define kAppNameKey              @"AppNameKey"
#define kAppCategoryKey          @"AppCategoryKey"
#define kAppIconURLKey           @"AppIconURLKey"
#define kAppPriceKey             @"AppPriceKey"
#define kAppGeneralRatingKey     @"AppGeneralRatingKey"
#define kAppCountryKey           @"AppCountryKey"

- (id)initWithCoder:(NSCoder *)decoder {
  self = [super init];
  if(self) {
    _appID            = [decoder decodeObjectForKey:kAppIDKey];
    _name             = [decoder decodeObjectForKey:kAppNameKey];
    _category         = [decoder decodeObjectForKey:kAppCategoryKey];
    _iconURLString    = [decoder decodeObjectForKey:kAppIconURLKey];
    _price            = [decoder decodeObjectForKey:kAppPriceKey];
    _generalRatings   = [decoder decodeObjectForKey:kAppGeneralRatingKey];
    _country          = [decoder decodeObjectForKey:kAppCountryKey];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)encoder {
  [encoder encodeObject:self.appID forKey:kAppIDKey];
  [encoder encodeObject:self.name forKey:kAppNameKey];
  [encoder encodeObject:self.category forKey:kAppCategoryKey];
  [encoder encodeObject:self.iconURLString forKey:kAppIconURLKey];
  [encoder encodeObject:self.price forKey:kAppPriceKey];
  [encoder encodeObject:self.generalRatings forKey:kAppGeneralRatingKey];
  [encoder encodeObject:self.country forKey:kAppCountryKey];
}

- (NSString *)description {
  return [NSString stringWithFormat:@"Name: %@\rCountry: %@\rCategory: %@\rPrice: %.2f\rRatings:", 
          self.name, self.country, self.category, [self.price floatValue], 
          [self.generalRatings floatValue]];
}

- (BOOL)isEqual:(id)object {
  if ([object isKindOfClass:[APApp class]]) {
    APApp *target = (APApp *)object;
    if ([self.appID isEqualToNumber:target.appID]) {
      return true;
    }
  }
  return false;
}

#pragma mark - Custom methods

- (BOOL)isFavoriteForCurrentChild {
  return [[[APChildManager sharedInstance] currentChild] favorsApp:self];
}

- (void)addToFavoritesForCurrentChild {
  [[[APChildManager sharedInstance] currentChild] addToFavorites:self];
}

- (void)removeFromFavoritesForCurrentChild {
  [[[APChildManager sharedInstance] currentChild] removeFromFavorites:self];
}

- (void)toggleFavoriteStatusForCurrentChild {
  [[[APChildManager sharedInstance] currentChild] toggleFavoriteStatusForApp:self];
}

#pragma mark - Debug methods
#ifdef DEBUG
+ (NSArray *)sampleApps {
  // Get our array of sample dictionary apps
  NSString *path = [[NSBundle mainBundle] pathForResource:@"sample-apps" 
                                                   ofType:@"plist"];
  NSArray *appsData = [[NSArray alloc] initWithContentsOfFile:path];
  return [APApp parseAppsDictionary:appsData];
}

+ (NSArray *)parseAppsDictionary:(NSArray *)appsData {
  NSMutableArray *apps = [[NSMutableArray alloc] init];
  RKObjectMappingProvider *provider = [[RKObjectManager sharedManager] mappingProvider];
  RKObjectMapping *appMapping = (RKObjectMapping *)[provider objectMappingForKeyPath:@"apps"];
  for (NSDictionary *appData in appsData) {
    APApp *app = [[APApp alloc] init];    
    RKObjectMappingOperation *op = [RKObjectMappingOperation 
                                    mappingOperationFromObject:appData 
                                    toObject:app  withMapping:appMapping];
    [op performMapping:nil];
    [apps addObject:app];
  }
  return apps;
}
#endif

@end