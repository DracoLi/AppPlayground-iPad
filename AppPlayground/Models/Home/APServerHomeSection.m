//
//  APServerHomeSection.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-08.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APServerHomeSection.h"
#import <RestKit/RestKit.h>
#import "APApp.h"

@implementation APServerHomeSection
@synthesize name = _name;
@synthesize apps = _apps;

#ifdef DEBUG
+ (NSArray *)sampleSections {
  // Get our array of sample dictionary sectinoms
  NSString *path = [[NSBundle mainBundle] pathForResource:@"home-sample-data" 
                                                   ofType:@"plist"];
  NSArray *sectionsData = [[NSArray alloc] initWithContentsOfFile:path];
  
  NSMutableArray *sections = [[NSMutableArray alloc] init];
  RKObjectMappingProvider *provider = [[RKObjectManager sharedManager] mappingProvider];
  RKObjectMapping *homeMapping = (RKObjectMapping *)[provider objectMappingForKeyPath:@"home_data"];
  for (NSDictionary *sectionData in sectionsData) {
    APServerHomeSection *section = [[APServerHomeSection alloc] init];    
    RKObjectMappingOperation *op = [RKObjectMappingOperation 
                                    mappingOperationFromObject:sectionData 
                                    toObject:section  withMapping:homeMapping];
    [op performMapping:nil];
    [sections addObject:section];
  }
  return sections;
}
#endif

@end
