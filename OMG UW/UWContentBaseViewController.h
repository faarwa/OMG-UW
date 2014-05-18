//
//  UWContentBaseViewController.h
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMGUWBaseViewController.h"

@interface UWContentBaseViewController : OMGUWBaseViewController <UITableViewDelegate, UITableViewDataSource, UWScrollToTopViewDelegate>
{
@private
    NSMutableArray *_contentSubmissions;
    NSString *_previousPageToken;
    NSString *_nextPageToken;
}

// Implemented by subclasses
@property (nonatomic, strong) UIColor *themeColour;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *blogId;

@end
