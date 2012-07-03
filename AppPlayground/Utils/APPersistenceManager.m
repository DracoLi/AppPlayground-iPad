//
//  APFileManager.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APPersistenceManager.h"

@implementation APPersistenceManager

#pragma mark - File Persistence

+ (NSString *)getPathForFileNamed:(NSString *)filename {
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *fullpath = [NSString stringWithFormat:@"%@/%@", 
                        documentsDirectory, filename];
  return fullpath;
}

+ (NSString *)contentFromFileNamed:(NSString *)filename {
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *fullpath = [NSString stringWithFormat:@"%@/%@", 
                        documentsDirectory, filename];
  NSString *content = [[NSString alloc] initWithContentsOfFile:fullpath
                                                  usedEncoding:nil
                                                         error:nil];
  if (content == nil) content = @"";
  return content;
}

+ (void)writeToFileNamed:(NSString *)filename content:(NSString *)content {
  
  // Get file path
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *fullpath = [NSString stringWithFormat:@"%@/%@", 
                        documentsDirectory, filename];
  
  // write to file
  BOOL results = [content writeToFile:fullpath 
                           atomically:NO 
                             encoding:NSStringEncodingConversionAllowLossy 
                                error:nil]; 
  
  NSAssert(results == YES, @"File must save successfully");
}

#pragma mark - User Defaults Persistence

+ (void)saveObjectToDefaults:(id)object key:(NSString *)key {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  [defaults setObject:[NSKeyedArchiver archivedDataWithRootObject:object] forKey:key];
  [defaults synchronize];
}

+ (id)getDataFromDefaults:(NSString *)key {
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  NSData *resultsData = [defaults objectForKey:key];
  
  // Decode object if its type NSData
  if (resultsData != nil && [resultsData isKindOfClass:[NSData class]]) {
    return [NSKeyedUnarchiver unarchiveObjectWithData:resultsData];
  }
  return resultsData;
}

@end
