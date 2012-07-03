//
//  APChildSelectorViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-02.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APChild.h"

@interface APChildSelectorViewController : UITableViewController

@property (nonatomic, strong) APChild *selectedChild;
@property (nonatomic, strong) NSArray *children;

@end
