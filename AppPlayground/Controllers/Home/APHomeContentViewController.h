//
//  APHomeContentViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-03.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <RestKit/RestKit.h>
#import "APHomeAppSectionCell.h"
#import "APDeviceSelectorViewController.h"

@interface APHomeContentViewController : UIViewController
<UITableViewDelegate, UITableViewDataSource, 
RKObjectLoaderDelegate, APHomeAppSectionCellDelegate,
APDeviceSelectorViewControllerDelegate>

@property (copy, nonatomic)   NSArray               *appSections;
@property (strong, nonatomic) UIPopoverController   *popover;
@property (strong, nonatomic) IBOutlet UITableView  *tableView;
@property (strong, nonatomic) IBOutlet UIButton     *deviceSelectorButton;

// Update the whole view to reflect new child
- (void)updateViewForCurrentChild;
- (IBAction)deviceSelectorClicked:(UIButton *)sender;

@end

