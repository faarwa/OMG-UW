//
//  OverheardViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OverheardViewController.h"

@implementation OverheardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = OH_TITLE;
        [self.tabBarItem setImage:[UIImage imageNamed:@"users-alt.png"]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIColor *)themeColour
{
    return [UWStyle ohOrangeColour];
}

- (NSString *)type
{
    return @"OVERHEARDs";
}

- (NSString *)key
{
    return @"OVERHEARD";
}

- (NSString *)blogId
{
    return @"2858838374466163108";
}

@end
