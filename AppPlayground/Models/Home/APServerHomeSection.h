//
//  APServerHomeSection.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-08.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface APServerHomeSection : NSObject

@property (copy, nonatomic) NSString  *name;
@property (copy, nonatomic) NSArray   *apps;

#ifdef DEBUG
+ (NSArray *)sampleSections;
#endif
@end
