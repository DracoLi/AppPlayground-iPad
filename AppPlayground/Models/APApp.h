//
//  APApp.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APApp : NSObject <NSCoding>

@property (copy, nonatomic)   NSNumber *appID;
@property (copy, nonatomic)   NSString *name;
@property (copy, nonatomic)   NSString *category;
@property (copy, nonatomic)   NSString *iconURLString;
@property (copy, nonatomic)   NSNumber *price;
@property (copy, nonatomic)   NSNumber *generalRatings;
@property (copy, nonatomic)   NSString *country;

- (BOOL)isFavorited;

#ifdef DEBUG
+ (NSArray *)sampleApps;
+ (NSArray *)parseAppsDictionary:(NSArray *)appsData;
#endif

@end