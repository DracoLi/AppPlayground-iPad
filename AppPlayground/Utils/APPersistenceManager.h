//
//  APFileManager.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APPersistenceManager : NSObject

/// File persistence ///

+ (NSString *)getPathForFileNamed:(NSString *)filename;

+ (id)getObjectFromFileNamed:(NSString *)filename;

+ (void)saveObject:(id)object toFile:(NSString *)filename;

/// User defaults persistence ///

// Save an NSObject that conforms to NSCoding into user defaults
+ (void)saveObjectToDefaults:(id)object key:(NSString *)key;

// Get data from user defaults (can be non-objects)
+ (id)getDataFromDefaults:(NSString *)key;

@end