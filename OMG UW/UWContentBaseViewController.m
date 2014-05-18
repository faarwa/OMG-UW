//
//  UWContentBaseViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "UWContentBaseViewController.h"
#import "AFNetworking.h"
#import "OMGUWSubmission.h"
#import "OMGUWSubmissionCell.h"
#import "UWCommentsViewController.h"

#define DEFAULT_CELL_HEIGHT 50.0f

@implementation UWContentBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"OMGUWBaseViewController" bundle:nibBundleOrNil];
    if (self) {
        _nextPageToken = @"";
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:refreshControl];
    
    [self.scrollToTopView setDelegate:self];
    
    _contentSubmissions = [[NSMutableArray alloc] init];
    [self getData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Retrieve data

- (void)getData
{
    [self setIsLoading:YES];
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *URLString = [[BaseUrlRequest stringByAppendingPathComponent:self.blogId] stringByAppendingPathComponent:PostsKey];
    
    NSMutableDictionary *parameters = [[NSMutableDictionary alloc] initWithObjectsAndKeys:@"15", MaxResultsKey, APIKeyValue, APIKey, nil];
    
    if (![_nextPageToken isEqualToString:@""]) {
        [parameters setValue:_nextPageToken forKey:PageTokenKey];
    }
    
    [manager GET:URLString parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSDictionary *data= (NSDictionary *)responseObject;
        NSArray *arrayOfItems = [data objectForKey:@"items"];
        
        _nextPageToken = [data objectForKey:NextPageTokenKey];
        
        for (NSDictionary *info in arrayOfItems) {
            NSLog(@"INFO %@", info);
            OMGUWSubmission *submission = [[OMGUWSubmission alloc] initWithDictionaryInfo:info];
            [submission setType:self.key];
            [_contentSubmissions addObject:submission];
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
    if (indexPath.row == [_contentSubmissions count]) {
        [self getData];
        
        return;
    }
    
    CATransition *transition = [CATransition animation];
    transition.duration = 0.35;
    transition.timingFunction =
    [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromRight;
    
    UIView *containerView = self.view.window;
    [containerView.layer addAnimation:transition forKey:nil];
    
    UWCommentsViewController *commentsvc = [[UWCommentsViewController alloc] init];
    [commentsvc setSubmission:[_contentSubmissions objectAtIndex:indexPath.row]];
    [commentsvc setBlog:self.blogId];
    
    [self presentViewController:commentsvc animated:NO completion:nil];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == [_contentSubmissions count]) {
        return DEFAULT_CELL_HEIGHT;
    }
    
    CGFloat cellHeight = [UWStyle heightForSubmission:[_contentSubmissions objectAtIndex:indexPath.row] inFrame:self.contentView.frame];
    
    cellHeight += 100;
    
    return cellHeight;
}

#pragma mark - UITableViewDataSource methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier;
    if (indexPath.row == [_contentSubmissions count]) {
        CellIdentifier = @"Load More Cell";
    } else {
        CellIdentifier = @"Content Cell";
    }
    
    OMGUWSubmissionCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[OMGUWSubmissionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if ([CellIdentifier isEqualToString:@"Content Cell"]) {
        OMGUWSubmission *submission = [_contentSubmissions objectAtIndex:indexPath.row];
        [cell setSubmission:submission];
        return cell;
    }
    
    if (!self.isLoading) {
        [cell.textLabel setText:@"Load More"];
    }

    [cell.textLabel setFont:[UWStyle boldedCellFont]];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_contentSubmissions count]+1;
}

#pragma mark - UWScrollToTopViewDelegate methods

- (void)scrollToTop
{
    [self.contentView scrollRectToVisible:CGRectMake(0, 0, 1, 1) animated:YES];
}

@end
