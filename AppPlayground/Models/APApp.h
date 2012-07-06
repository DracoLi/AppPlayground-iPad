//
//  APApp.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APApp : NSObject <NSCoding>

@property (copy, nonatomic)   NSString *name;
@property (copy, nonatomic)   NSString *category;
@property (copy, nonatomic)   NSString *iconURLString;
@property (strong, nonatomic) NSNumber *price;
@property (strong, nonatomic) NSNumber *generalRatings;

- (BOOL)isFavorited;

@end