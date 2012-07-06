//
//  APHomeTableData.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-05.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APApp.h"

@interface APHomeTableData : NSObject

@property (strong, nonatomic) NSDictionary *rawData;

- (NSUInteger)sections;

- (NSUInteger)rowsForSection:(NSUInteger)section;

- (NSString *)nameForSection:(NSUInteger)section;

- (APApp *)appForIndexPath:(NSIndexPath *)path;

@end
