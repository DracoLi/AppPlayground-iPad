//
//  APHomeContentViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "APChild.h"

@interface APHomeContentViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, RKObjectLoaderDelegate>

@property (strong, nonatomic) APChild           *currentChild;
@property (strong, nonatomic) UITableView       *tableView;

// Update the whole view to reflect new child
- (void)updateViewForCurrentChild;

@end

