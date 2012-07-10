//
//  APHomeAppSectionCellCell.m
//  AppPlayground
//
//  Created by Draco Li on 12-07-05.
//  Copyright (c) 2012 AppPlayground. All rights reserved.
//

#import "APHomeAppSectionCell.h"
#import "UIView+CustomView.h"

#define kAppsPerPage            3
#define kPaddingBetweenApps     40
#define kPaddingForFirstApp     30

@interface APHomeAppSectionCell ()
@property (strong, nonatomic) NSMutableArray *pageViews;
- (void)loadScrollViewForPage:(NSUInteger)page;
- (UIView *)makeViewForPage:(NSUInteger)page;
@end

@implementation APHomeAppSectionCell
@synthesize titleLabel = _titleLabel;
@synthesize pageLabel = _pageLabel;
@synthesize scrollView = _scrollView;
@synthesize apps = _apps;
@synthesize pageViews = _pageViews;
@synthesize delegate = _delegate;

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

- (void)bindAppSection:(APServerHomeSection *)appSection {
  self.apps = appSection.apps;
  
  // Set section title
  self.titleLabel.text = appSection.name;
  
  // Initialize our pages with null values so we can load lazily
  self.pageViews = [[NSMutableArray alloc] initWithCapacity:self.totalPages];
  for (unsigned i = 0; i < self.totalPages; i++) {
    [self.pageViews addObject:[NSNull null]];
  }
  
  // Initialize our scroll view's contentsize
  self.scrollView.contentSize = CGSizeMake(_scrollView.frame.size.width * self.totalPages, 
                                           _scrollView.frame.size.height);
  
  // Load the first page and the second page so no flickering
  [self loadScrollViewForPage:0];
  [self loadScrollViewForPage:1];
  
  // Make sure the first place is displayed
  [self scrollToPage:0 animated:NO];
}

- (NSUInteger)totalPages {
  float pages = (float)self.apps.count / kAppsPerPage;
  return ceil(pages);
}

- (void)scrollToPage:(NSUInteger)page animated:(BOOL)animated {
  NSAssert(page >= 0 && page < [self totalPages], @"Wrong scroll to page");
  
  // Load the target pages and the pages around it to prevent flicking
  [self loadScrollViewForPage:page - 1];
  [self loadScrollViewForPage:page];
  [self loadScrollViewForPage:page + 1];
  
  // Do the actual scrolling to the target page
  CGRect scrollTo = CGRectMake(0, 0, 1, 1);
  if (page > 0) {
    scrollTo.origin.x = self.scrollView.frame.size.width * page;
  }
  [self.scrollView scrollRectToVisible:scrollTo animated:animated];
}

#pragma mark - Private custom methods

- (void)loadScrollViewForPage:(NSUInteger)page {
  if (page >= self.totalPages) return;
  
  // Lazily create the scroll view's content if neccessary
  UIView *pageView = [self.pageViews objectAtIndex:page];
  if ((NSNull *)pageView == [NSNull null]) {
    pageView = [self makeViewForPage:page];
    [self.pageViews replaceObjectAtIndex:page withObject:pageView];
    NSLog(@"page %d loaded", page);
  }
  
  // Add the page view to the scroll view if not already
  if (pageView.superview == nil) {
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    pageView.frame = frame;
    [self.scrollView addSubview:pageView];
  }
}

- (UIView *)makeViewForPage:(NSUInteger)page {
  // Create our pageview with the right frame
  CGRect pageFrame = self.scrollView.frame;
  pageFrame.origin.x = pageFrame.size.width * page; 
  pageFrame.origin.y = 0;
  UIView *pageView = [[UIView alloc] initWithFrame:pageFrame];
  
  // Populate pageview with icon view
  int baseIndex = page * kAppsPerPage;
  int maxIndex = MIN(self.apps.count, page * kAppsPerPage + kAppsPerPage);
  APAppIconView *lastView = nil;
  for (unsigned i = baseIndex; i < maxIndex; i++) {
    APAppIconView *oneIcon = (APAppIconView *)[UIView 
                                               viewWithNibName:@"APAppIconView" 
                                               owner:self];
    oneIcon.delegate = self;
    
    // Adjust icon frame
    CGRect iconFrame = oneIcon.frame;
    iconFrame.origin.y = 0;
    if (lastView == nil) {
      iconFrame.origin.x = kPaddingForFirstApp;
    }else {
      iconFrame.origin.x = lastView.frame.origin.x + kPaddingBetweenApps + 
                           iconFrame.size.width;
    }
    
    // Set the final frame
    oneIcon.frame = iconFrame;
    lastView = oneIcon;
    
    // Bind data to icon view
    [oneIcon bindApp:[self.apps objectAtIndex:i]];
    
    // Add icon to pageview
    [pageView addSubview:oneIcon];
  }
  return pageView;
}

#pragma mark - UI Actions

- (void)appIconViewClicked:(APAppIconView *)view app:(APApp *)app {
  NSLog(@"App Clicked in cell: %@", app.name);
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(APHomeAppSectionAppSelected:app:)]) {
    [self.delegate APHomeAppSectionAppSelected:self app:app];
  }
}

- (void)appPriceButtonClicked:(APAppIconView *)view app:(APApp *)app {
  NSLog(@"App Price clicked in cell: %@", app.name);
  if (self.delegate &&
      [self.delegate respondsToSelector:@selector(APHomeAppSectionAppPriceClicked:app:)]) {
    [self.delegate APHomeAppSectionAppPriceClicked:self app:app];
  }
}

#pragma mark - ScrollView Delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
  // Switch the indicator when more than 50% of the previous/next page is visible
  CGFloat pageWidth = self.scrollView.frame.size.width;
  int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
  [self loadScrollViewForPage:page - 1];
  [self loadScrollViewForPage:page];
  [self loadScrollViewForPage:page + 1];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
  // Update page label
  int page = self.scrollView.contentOffset.x / self.scrollView.frame.size.width + 1;
  self.pageLabel.text = [NSString stringWithFormat:NSLocalizedString(@"Page %d", @"Page %d"), page];
}

@end
