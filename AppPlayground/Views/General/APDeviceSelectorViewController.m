//
//  APDeviceSelectorViewController.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-07.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APDeviceSelectorViewController.h"

@interface APDeviceSelectorViewController ()

@end

@implementation APDeviceSelectorViewController
@synthesize selectedDevice = _selectedDevice;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (IBAction)deviceSelected:(UIButton *)sender {
  if ([sender.titleLabel.text isEqualToString:@"iPhone"]) {
    self.selectedDevice = @"iphone";
  } else if ([sender.titleLabel.text isEqualToString:@"iPad"]) {
    self.selectedDevice = @"ipad";
  }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait ||
            interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown);
}

@end
