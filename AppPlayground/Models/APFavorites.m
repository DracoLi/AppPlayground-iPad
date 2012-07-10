//
//  APFavorites.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APFavorites.h"
#import "APPersistenceManager.h"

@implementation APFavorites

// General keys
#define FavoritesListKey  @"FavoritesListKey"

+ (void)addToFavorites:(APApp *)app {
  
  // Return if already a favorite
  if ([APFavorites isAppFavorited:app])  {
    return;
  }
  
  // Add to storage
  NSMutableArray *favorites = [[NSMutableArray alloc] 
                               initWithArray:[APFavorites getAllFavorites]];
  [favorites addObject:app];
  [APPersistenceManager saveObjectToDefaults:favorites key:FavoritesListKey];
}

+ (void)removeFromFavorites:(APApp *)app {
  NSMutableArray *favorites = [[NSMutableArray alloc] 
                               initWithArray:[APFavorites getAllFavorites]];
  [favorites removeObject:app];
  [APPersistenceManager saveObjectToDefaults:favorites key:FavoritesListKey];
}

+ (NSArray *)getAllFavorites {
  NSArray *allFavorites = [APPersistenceManager getDataFromDefaults:FavoritesListKey];
  if (allFavorites == nil) {
    allFavorites = [[NSArray alloc] init];
  }
  return allFavorites;
}

+ (BOOL)isAppFavorited:(APApp *)app {
  NSArray *favorites = [APFavorites getAllFavorites];
  return [favorites containsObject:app];
}

+ (BOOL)toggleFavoriteStatus:(APApp *)app {
  BOOL isFavorited = [APFavorites isAppFavorited:app];
  if (isFavorited) {
    [APFavorites removeFromFavorites:app];
  } else {
    [APFavorites addToFavorites:app];
  }
  return !isFavorited;
}

+ (void)clearAppFavorites {
  [APPersistenceManager saveObjectToDefaults:nil key:FavoritesListKey];
}

@end