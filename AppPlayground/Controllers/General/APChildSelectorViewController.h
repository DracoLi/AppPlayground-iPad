//
//  APChildSelectorViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APChild.h"

@class APChildSelectorViewController;
@protocol APChildSelectorDelegate <NSObject>
- (void)childDidSelectForViewController:(APChildSelectorViewController *)view 
                                  child:(APChild *)child
                           shouldUpdate:(BOOL)shouldUpdate;
@end

@interface APChildSelectorViewController : UITableViewController

@property (strong, nonatomic) APChild *selectedChild;
@property (copy, nonatomic)   NSArray *children;
@property (weak, nonatomic)   id<APChildSelectorDelegate> delegate;

@end
