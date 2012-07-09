//
//  APDeviceSelectorViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TogglingImageView.h"

@protocol APDeviceSelectorViewControllerDelegate <NSObject>
- (void)apDeviceSelectorDeviceChanged:(NSString *)device;
@end

@interface APDeviceSelectorViewController : UIViewController
<TogglingImageViewDelegate>

@property (strong, nonatomic) IBOutlet TogglingImageView *iphoneButton;
@property (strong, nonatomic) IBOutlet TogglingImageView *ipadButton;
@property (strong, nonatomic) IBOutlet TogglingImageView *allButton;
@property (weak, nonatomic) id<APDeviceSelectorViewControllerDelegate> delegate;

- (NSString *)getSelectedDevice;
@end