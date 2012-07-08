//
//  TogglingImageView.m
//  SoundBoard
//
//  Created by Draco Li on 10-11-03.
//  Copyright 2010 Queen's University. All rights reserved.
//

#import "TogglingImageView.h"


@implementation TogglingImageView

@synthesize delegate = _delegate;
@synthesize isOn = _isOn;;

#pragma mark -
#pragma mark Touch handling

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
  if (!self.isOn) {
    self.highlighted = YES;
  }
}

/*
 - (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
 UITouch *theTouch = [touches anyObject];
 CGPoint location = [theTouch locationInView:theTouch.view];
 CGSize thisSize = self.frame.size;
 
 if (location.x < 0 || location.x > thisSize.width ||
 location.y < 0 || location.y > thisSize.height) {
 
 if (isOn) {
 self.highlighted = YES;
 }else {
 self.highlighted = NO;
 }
 }
 }
 */

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
  if (self.isOn) {
		self.highlighted = NO;
		self.isOn = NO;
	}
  if (self.delegate && 
      [self.delegate respondsToSelector:@selector(togglingImageViewSelected:)]) {
		[self.delegate togglingImageViewSelected:self];
	}
}

- (void)toggleOn {
	self.highlighted = YES;
	self.isOn = YES;
}

- (void)toggleOff {
	self.highlighted = NO;
	self.isOn = NO;
}

@end