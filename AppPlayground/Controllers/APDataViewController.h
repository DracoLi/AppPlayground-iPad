//
//  APDataViewController.h
//  AppPlayground
//
//  Created by Draco Li on 12-06-25.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APDataViewController : UIViewController

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) id dataObject;

@end