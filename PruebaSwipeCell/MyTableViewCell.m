//
//  MyTableViewCell.m
//  PruebaSwipeCell
//
//  Created by Pablo on 29/6/15.
//  Copyright (c) 2015 Bioshook. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell

CGPoint originalCenterSr;
BOOL deleteOnDragReleaseSr;

- (void)awakeFromNib {
    // Initialization code
    
    // add a pan recognizer
    UIGestureRecognizer* recognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePan:)];
    recognizer.delegate = self;
    [_viewFrame addGestureRecognizer:recognizer];
}

#pragma mark - horizontal pan gesture methods
-(BOOL)gestureRecognizerShouldBegin:(UIPanGestureRecognizer *)gestureRecognizer {
    CGPoint translation = [gestureRecognizer locationInView:[self superview]];
    CGPoint velocity = [gestureRecognizer velocityInView:[self superview]];
    
    // Check for horizontal gesture
    if (fabs(translation.x) < (self.frame.size.width - 60.f) && velocity.x > 0) {
        return YES;
    }

    return NO;
}

-(void)handlePan:(UIPanGestureRecognizer *)recognizer {
    // 1
    if (recognizer.state == UIGestureRecognizerStateBegan) {
        // if the gesture has just started, record the current centre location
        originalCenterSr = _viewFrame.center;
    }
    
    // 2
    if (recognizer.state == UIGestureRecognizerStateChanged) {
        // translate the center
        CGPoint translation = [recognizer translationInView:_viewFrame];
        _viewFrame.center = CGPointMake(originalCenterSr.x + translation.x, originalCenterSr.y);
        // determine whether the item has been dragged far enough to initiate a delete / complete
        deleteOnDragReleaseSr = _viewFrame.frame.origin.x > self.frame.size.width / 2;
    }
    
    // 3
    if (recognizer.state == UIGestureRecognizerStateEnded) {
        // the frame this cell would have had before being dragged
        CGRect originalFrame = CGRectMake(8, 0,
                                          _viewFrame.bounds.size.width, _viewFrame.bounds.size.height);
        if (deleteOnDragReleaseSr) {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _viewFrame.frame = CGRectMake(self.frame.size.width, 0, self.frame.size.width, self.frame.size.height);
                                 if ([self.delegate respondsToSelector:@selector(cellSwiper:)]) {
                                     [self.delegate cellSwiper:_indexPath];
                                 }
                             }
             ];
            
        } else {
            // if the item is not being deleted, snap back to the original location
            [UIView animateWithDuration:0.2
                             animations:^{
                                 _viewFrame.frame = originalFrame;
                             }
             ];
        }
    }
}

@end
