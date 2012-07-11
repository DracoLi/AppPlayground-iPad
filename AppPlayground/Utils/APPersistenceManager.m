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

+ (id)getObjectFromFileNamed:(NSString *)filename {
  
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *fullpath = [NSString stringWithFormat:@"%@/%@", 
                        documentsDirectory, filename];
  return [NSKeyedUnarchiver unarchiveObjectWithFile:fullpath];
}

+ (void)saveObject:(id)object toFile:(NSString *)filename {
  // Get file path
  NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, 
                                                       NSUserDomainMask, YES);
  NSString *documentsDirectory = [paths objectAtIndex:0];
  NSString *fullpath = [NSString stringWithFormat:@"%@/%@", 
                        documentsDirectory, filename];
  
  // write string to file
  NSData *data = [NSKeyedArchiver archivedDataWithRootObject:object];
  BOOL result = [data writeToFile:fullpath atomically:YES];
  
  if (result == NO) {
    NSLog(@"content have not saved successfully!!");
  }
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
