//
//  APDeviceSelectorViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APDeviceSelectorViewController : UIViewController

@property (copy, nonatomic) NSString *selectedDevice;

- (IBAction)deviceSelected:(UIButton *)sender;

@end