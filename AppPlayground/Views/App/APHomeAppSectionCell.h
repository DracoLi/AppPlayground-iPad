//
//  APHomeAppSectionCellCell.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-05.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppIconView.h"

@interface APHomeAppSectionCell : UITableViewCell
<UIScrollViewDelegate, APAppIconViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (strong, nonatomic) NSArray *apps;

- (void)bindApps:(NSArray *)apps;

- (NSUInteger)totalPages;

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated;

@end