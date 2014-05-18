//
//  OMGUWBaseViewController.h
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UWStyle.h"
#import "UWScrollToTopView.h"

static NSString *BaseUrlRequest = @"https://www.googleapis.com/blogger/v3/blogs/";
static NSString *const APIKey = @"key";
static NSString *const APIKeyValue = @"AIzaSyDmI2Sj7fOIK9gu-k4UNV-QyeulJjII5qQ";
static NSString *const PostsKey = @"posts";
static NSString *const MaxResultsKey = @"maxResults";
static NSString *const PageTokenKey = @"pageToken";
static NSString *const NextPageTokenKey = @"nextPageToken";
static NSString *const CommentsKey = @"comments";

@interface OMGUWBaseViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *omgLabel;
@property (weak, nonatomic) IBOutlet UWScrollToTopView *scrollToTopView;
@property (weak, nonatomic) IBOutlet UITableView *contentView;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;

@property (nonatomic) BOOL isLoading;

// Implemented by subclasses
@property (nonatomic, strong) UIColor *themeColour;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *blogId;

- (void)getData;

@end
