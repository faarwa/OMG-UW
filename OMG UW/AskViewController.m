//
//  AskViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "AskViewController.h"

@implementation AskViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = ASK_TITLE;
        [self.tabBarItem setImage:[UIImage imageNamed:@"help.png"]];
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
    return [UWStyle askGreenColour];
}

- (NSString *)type
{
    return @"ASK";
}

- (NSString *)key
{
    return @"QUESTION";
}

- (NSString *)blogId
{
    return @"8890256589225535002";
}

@end
