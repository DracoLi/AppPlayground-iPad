//
//  APHomeAppSectionCellCell.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-05.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APHomeAppSectionCell.h"

#define kAppsPerPage    4

@interface APHomeAppSectionCell ()
@property (strong, nonatomic) NSMutableArray *pageViews;
- (void)loadScrollViewForPage:(NSUInteger)page;
@end

@implementation APHomeAppSectionCell
@synthesize titleLabel = _titleLabel;
@synthesize pageLabel = _pageLabel;
@synthesize scrollView = _scrollView;
@synthesize apps = _apps;
@synthesize pageViews = _pageViews;

#pragma mark - View lifecycle

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

- (void)awakeFromNib {
  self.scrollView.scrollsToTop = NO;
}

#pragma mark - Custom methods

- (void)bindApps:(NSArray *)apps {
  self.apps = apps;
  
  // Initialize our pages with null values so we can load lazily
  NSMutableArray *pages = [[NSMutableArray alloc] initWithCapacity:self.totalPages];
  for (unsigned i = 0; i < self.totalPages; i++) {
    [self.pageViews addObject:[NSNull null]];
  }
  self.pageViews = pages;
    
  // Load the first page and the second page so no flickering
  [self loadScrollViewForPage:0];
  [self loadScrollViewForPage:1];
  
  [self scrollToPage:0 animated:NO];
}

- (NSUInteger)totalPages {
  return ceil([self.apps count] / kAppsPerPage);
}

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated {
  
}

- (void)loadScrollViewForPage:(NSUInteger)page {
  
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  
}

@end
