//
//  APServerAppResults.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-08.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APApp.h"

@interface APServerAppResults : NSObject

@property (nonatomic)         BOOL success;
@property (copy, nonatomic)   NSString *message;
@property (copy, nonatomic)   NSArray *apps;
@end
