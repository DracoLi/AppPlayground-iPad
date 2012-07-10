//
//  APAppDelegate.m
//  AppPlayground
//
//  Created by Draco Li on 12-06-25.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APAppDelegate.h"
#import <RestKit/RestKit.h>
#import <Parse/Parse.h>
#import "Flurry.h"
#import "Constants.h"
#import "APApp.h"
#import "APFavorites.h"
#import "APServerHomeSection.h"

@interface APAppDelegate ()
- (void)initializeRestKit;
@end

@implementation APAppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application 
didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
  // Set up Parse
  [Parse setApplicationId:@"zGpyB8K1a5lPFg3iY01c0eD3gK6ZYOYCvrliOd8k"
                clientKey:@"dnHn6NxLSiL589Wfs6iDnveuHIW5kIttKz81Fvpl"];
  
  // Set up Flurry
  [Flurry setDebugLogEnabled:(DEBUG && NO)];
  [Flurry startSession:@"Z2VVTNDDKGJDCMYZH368"];
  
  // Initialize RestKit
  [self initializeRestKit];
  
  return YES;
}

- (void)initializeRestKit {
  
  // Create the object manager
  RKObjectManager *objectManager = [RKObjectManager 
                                    managerWithBaseURLString:kServerBaseURLString];
  objectManager.client.baseURL = objectManager.baseURL;
  
  // Enable automatic network activity indicator management
  objectManager.client.requestQueue.showsNetworkActivityIndicatorWhenBusy = YES;
  
  // Setup our object mappings
  RKObjectMapping *appMapping = [RKObjectMapping mappingForClass:[APApp class]];
  [appMapping mapKeyPath:@"name" toAttribute:@"name"];
  [appMapping mapKeyPath:@"category" toAttribute:@"category"];
  [appMapping mapKeyPath:@"pic_icon60" toAttribute:@"iconURLString"];
  [appMapping mapKeyPath:@"amount" toAttribute:@"price"];
  [appMapping mapKeyPath:@"total_average_rating" toAttribute:@"generalRatings"];
  [objectManager.mappingProvider setObjectMapping:appMapping forKeyPath:@"apps"];
  
  RKObjectMapping *sectionData = [RKObjectMapping mappingForClass:[APServerHomeSection class]];
  [sectionData mapKeyPath:@"name" toAttribute:@"name"];
  [sectionData mapRelationship:@"apps" withMapping:appMapping];
  [objectManager.mappingProvider setObjectMapping:sectionData forKeyPath:@"home_data"];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
