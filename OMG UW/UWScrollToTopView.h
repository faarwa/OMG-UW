//
//  UWScrollToTopView.h
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol UWScrollToTopViewDelegate <NSObject>

@required
- (void)scrollToTop;

@end

@interface UWScrollToTopView : UIView

@property (nonatomic, strong) NSObject<UWScrollToTopViewDelegate> *delegate;

- (void)rotate90Counterclockwise;

@end
