//
//  APDeviceSelectorViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APDeviceSelectorViewController.h"

@interface APDeviceSelectorViewController ()
- (void)adjustToggleButtonsForSelected:(TogglingImageView *)button;
@end

@implementation APDeviceSelectorViewController
@synthesize iphoneButton = _iphoneButton;
@synthesize ipadButton = _ipadButton;
@synthesize allButton = _allButton;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // Delegation
  self.ipadButton.delegate = self;
  self.iphoneButton.delegate = self;
  self.allButton.delegate = self;
  
  // By default iphone button is on
  [self.iphoneButton toggleOn];
  [self togglingImageViewSelected:nil];
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  [self setIphoneButton:nil];
  [self setIpadButton:nil];
}

- (NSString *)getSelectedDevice {
  if (self.allButton.isOn) {
    return @"All";
  }else if (self.ipadButton.isOn) {
    return @"iPad";
  }else if(self.iphoneButton.isOn) {
    return @"iPhone";
  }
  NSAssert(1 == 0, @"We should never get here");
  return @"unkown";
}

- (void)togglingImageViewSelected:(TogglingImageView *)theIcon {
  if (!theIcon.isOn) {
    [theIcon toggleOn];
  }else {
    [self adjustToggleButtonsForSelected:theIcon];
  }
  
  if (self.delegate && 
      [self.delegate respondsToSelector:@selector(apDeviceSelectorDeviceChanged:)]) {
    [self.delegate apDeviceSelectorDeviceChanged:[self getSelectedDevice]];
  }
}

- (void)adjustToggleButtonsForSelected:(TogglingImageView *)button {
  if (button == self.iphoneButton)
    [self.iphoneButton toggleOn];
  else 
    [self.iphoneButton toggleOff];
  
  if (button == self.ipadButton)
    [self.ipadButton toggleOn];
  else 
    [self.ipadButton toggleOff];
  
  if (button == self.allButton)
    [self.allButton toggleOn];
  else 
    [self.allButton toggleOff];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait ||
          interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
