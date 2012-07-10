//
//  APDeviceSelectorViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol APDeviceSelectorViewControllerDelegate <NSObject>
- (void)apDeviceSelectorDeviceChanged:(NSString *)device;
@end

@interface APDeviceSelectorViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *iphoneButton;
@property (strong, nonatomic) IBOutlet UIButton *ipadButton;
@property (strong, nonatomic) IBOutlet UIButton *allButton;
@property (weak, nonatomic) id<APDeviceSelectorViewControllerDelegate> delegate;

- (NSString *)getSelectedDevice;
- (IBAction)deviceButtonsClicked:(UIButton *)button;

@end