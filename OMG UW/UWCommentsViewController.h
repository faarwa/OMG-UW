//
//  CommentsViewController.h
//  OMG UW
//
//  Created by Farwa Naqi on 2/26/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OMGUWSubmission.h"
#import "OMGUWBaseViewController.h"
#import "UWScrollToTopView.h"

@interface UWCommentsViewController : OMGUWBaseViewController <UWScrollToTopViewDelegate>
{
    @private
    NSMutableDictionary *_comments;
}

@property (nonatomic, strong) NSString *blog;
@property (nonatomic, strong) OMGUWSubmission *submission;

@end
