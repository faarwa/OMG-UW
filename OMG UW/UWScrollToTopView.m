//
//  UWScrollToTopView.m
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "UWScrollToTopView.h"

#define X_PADDING 8
#define X_INNER_PADDING 12
#define Y_PADDING 8
#define Y_INNER_PADDING 10
#define Y_PADDING_TOP 10
#define Y_INNER_PADDING_TOP 14

@implementation UWScrollToTopView

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)setDelegate:(NSObject<UWScrollToTopViewDelegate> *)delegate
{
    _delegate = delegate;
    UITapGestureRecognizer *tapgc = [[UITapGestureRecognizer alloc] initWithTarget:self.delegate action:@selector(scrollToTop)];
    [self addGestureRecognizer:tapgc];
}

- (void)rotate90Counterclockwise
{
    CGAffineTransform transform = CGAffineTransformMakeRotation(-M_PI_2);
    self.transform = transform;
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, 2.0);
    
    // Set color of line to black
    CGColorSpaceRef colorspace = CGColorSpaceCreateDeviceRGB();
    CGFloat components[] = {0.41, 0.41, 0.41, 1.0};
    CGColorRef color = CGColorCreate(colorspace, components);
    CGContextSetStrokeColorWithColor(context, color);
    
    // Create up arrow
    CGContextMoveToPoint(context, X_PADDING, self.bounds.size.height-Y_PADDING);
    CGContextAddLineToPoint(context, self.bounds.size.width/2, Y_PADDING_TOP);
    CGContextMoveToPoint(context, self.bounds.size.width/2, Y_PADDING_TOP);
    CGContextAddLineToPoint(context, self.bounds.size.width-X_PADDING, self.bounds.size.height-Y_PADDING);
    
    CGContextStrokePath(context);
    CGColorSpaceRelease(colorspace);
    CGColorRelease(color);
}

@end
