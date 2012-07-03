//
//  APFileManager.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface APFileManager : NSObject

+ (NSString *)getPathForFileNamed:(NSString *)filename;
+ (NSString *)contentFromFileNamed:(NSString *)filename;
+ (void)writeToFileNamed:(NSString *)filename content:(NSString *)content;

@end
