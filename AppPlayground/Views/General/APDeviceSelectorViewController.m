//
//  APDeviceSelectorViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APDeviceSelectorViewController.h"

@interface APDeviceSelectorViewController ()
- (void)adjustToggleButtonsForSelected:(UIButton *)button;
@end

@implementation APDeviceSelectorViewController
@synthesize iphoneButton = _iphoneButton;
@synthesize ipadButton = _ipadButton;
@synthesize allButton = _allButton;
@synthesize delegate = _delegate;

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // By default iphone button is on
  self.iphoneButton.selected = true;
}

- (void)viewDidUnload
{
  [super viewDidUnload];
  
  [self setIphoneButton:nil];
  [self setIpadButton:nil];
}

- (NSString *)getSelectedDevice {
  if (self.allButton.selected) {
    return @"All";
  }else if (self.ipadButton.selected) {
    return @"iPad";
  }else if(self.iphoneButton.selected) {
    return @"iPhone";
  }
  NSAssert(1 == 0, @"We should never get here");
  return @"unknown";
}

- (IBAction)deviceButtonsClicked:(UIButton *)button {
  [self adjustToggleButtonsForSelected:button];
  
  if (self.delegate && 
      [self.delegate respondsToSelector:@selector(apDeviceSelectorDeviceChanged:)]) {
    [self.delegate apDeviceSelectorDeviceChanged:[self getSelectedDevice]];
  }
}

- (void)adjustToggleButtonsForSelected:(UIButton *)button {
  self.iphoneButton.selected = button == self.iphoneButton;
  self.ipadButton.selected = button == self.ipadButton;
  self.allButton.selected = button == self.allButton;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
  return (interfaceOrientation == UIInterfaceOrientationPortrait ||
          interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
