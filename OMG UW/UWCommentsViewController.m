//
//  CommentsViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/26/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "UWCommentsViewController.h"
#import "AFNetworking.h"
#import "OMGUWSubmissionCell.h"
#import "OMGUWComment.h"
#import "OMGUWCommentCell.h"

#define DEFAULT_CELL_HEIGHT 50.0

@implementation UWCommentsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"OMGUWBaseViewController" bundle:nibBundleOrNil];
    if (self) {
        _comments = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self getData];
    

    [self.scrollToTopView rotate90Counterclockwise];
    [self.scrollToTopView setDelegate:self];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)getData
{
    [self setIsLoading:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *URLString = [[[[BaseUrlRequest stringByAppendingPathComponent:self.blog]
                            stringByAppendingPathComponent:PostsKey]
                           stringByAppendingPathComponent:self.submission.postId]
                           stringByAppendingPathComponent:CommentsKey];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"15", MaxResultsKey, APIKeyValue, APIKey, nil];
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data= (NSDictionary *)responseObject;
        NSArray *arrayOfItems = [data objectForKey:@"items"];
        
        NSUInteger count = 1;
        
        for (NSDictionary *info in arrayOfItems) {
            NSLog(@"INFO %@", info);
            OMGUWComment *comment = [[OMGUWComment alloc] initWithDictionaryInfo:info];
            if (comment.replyToId) {
                OMGUWComment *mainComment = [_comments objectForKey:comment.replyToId];
                
                unichar c = [@"a" characterAtIndex:0];
                
                for (int i = 0; i < [mainComment.replies count]; i++) {
                    c++;
                }
                
                NSString *commentNum = [NSString stringWithFormat:@"%@.%@",
                                        mainComment.commentNum,
                                        [NSString stringWithCharacters:&c length:1]];
                c++;
                [comment setCommentNum:commentNum];
                [mainComment.replies addObject:comment];
            } else {
                NSString *commentNum = [NSString stringWithFormat:@"%lu",
                                        (unsigned long)count];
                count++;
                [comment setCommentNum:commentNum];
                [_comments setValue:comment forKey:comment.commentId];
            }
        }
        
        [self.contentView reloadData];
        
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self setIsLoading:NO];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", error);
        [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        [self setIsLoading:NO];
    }];
}

- (void)refresh:(UIRefreshControl *)refreshControl
{
    [self getData];
    [self.contentView reloadData];
    [refreshControl endRefreshing];
}

#pragma mark - UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_comments count]) {
        [self getData];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat cellHeight = 0;
    
    if (indexPath.row == 0) {
        cellHeight = [UWStyle heightForSubmission:self.submission inFrame:self.contentView.frame];
    } else {
        NSArray *allKeys = [_comments allKeys];
        OMGUWComment *comment = [_comments objectForKey:[allKeys objectAtIndex:indexPath.row]];
        NSString *content;
        
        content = [NSString stringWithFormat:@"%@  %@", comment.commentNum, comment.content];
        
        NSMutableArray *replies = [[NSMutableArray alloc] init];
        
        for (OMGUWComment *reply in comment.replies) {
            NSString *replyText = [NSString stringWithFormat:@"%@  %@", reply.commentNum, reply.content];
            [replies addObject:replyText];
        }
        
        NSString *allReplies = [replies componentsJoinedByString:@"\n"];
        
        content = [content stringByAppendingString:[NSString stringWithFormat:@"%@\n%@", content, allReplies]];
        
        content = [UWStyle formatText:content];

        cellHeight = [UWStyle heightForCommentContent:content inFrame:self.contentView.frame];
    }
    
    cellHeight += 30;
    
    return cellHeight;
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if (indexPath.row == 0) {
        CellIdentifier = @"PostContent Cell";
    } else {
        CellIdentifier = @"Comments Cell";
    }
    
    OMGUWCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        if (indexPath.row == 0) {
            cell = [[OMGUWSubmissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        } else {
            cell = [[OMGUWCommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
    }
    
    if ([CellIdentifier isEqualToString:@"Comments Cell"]) {
        NSArray *allKeys = [_comments allKeys];
        OMGUWComment *comment = [_comments objectForKey:[allKeys objectAtIndex:indexPath.row]];
        [(OMGUWCommentCell *)cell setComment:comment];
        return cell;
    }
    
    [(OMGUWSubmissionCell *)cell setSubmission:self.submission];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_comments count];
}

#pragma mark - UWScrollToTopViewDelegate methods

- (void)scrollToTop
{
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromLeft;
    
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    [self dismissViewControllerAnimated:NO completion:^{}];
}

@end
