//
//  APModelController.h
//  AppPlayground
//
//  Created by Draco Li on 12-06-25.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@class APDataViewController;

@interface APModelController : NSObject <UIPageViewControllerDataSource>

- (APDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(APDataViewController *)viewController;

@end
