//
//  APHomeAppSectionCellCell.h
//  AppPlayground
//
//  Created by Draco Li on 12-07-05.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "APAppIconView.h"
#import "APApp.h"

@class APHomeAppSectionCell;
@protocol APHomeAppSectionCellDelegate <NSObject>
- (void)APHomeAppSectionAppSelected:(APHomeAppSectionCell *)cell app:(APApp *)app;
@end

@interface APHomeAppSectionCell : UITableViewCell
<UIScrollViewDelegate, APAppIconViewDelegate>

@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *pageLabel;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollView;
@property (copy, nonatomic) NSArray *apps;
@property (weak, nonatomic) id<APHomeAppSectionCellDelegate> delegate;

- (void)bindAppSection:(NSDictionary *)appSection;

- (NSUInteger)totalPages;

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated;

@end