
#import <UIKit/UIKit.h>

@class TogglingImageView;

@protocol TogglingImageViewDelegate <NSObject>
- (void)togglingImageViewSelected:(TogglingImageView *)theIcon;
@end

@interface TogglingImageView : UIImageView
  
@property BOOL isOn;
@property (nonatomic, assign) id<TogglingImageViewDelegate> delegate;

- (void)toggleOn;
- (void)toggleOff;

@end