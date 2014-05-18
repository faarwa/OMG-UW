//
//  MCViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "MCViewController.h"

@implementation MCViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = MC_TITLE;
        [self.tabBarItem setImage:[UIImage imageNamed:@"chat-active.png"]];
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
    return [UWStyle mcPurpleColour];
}

- (NSString *)type
{
    return @"MCs";
}

- (NSString *)key
{
    return @"MISSED CONNECTION";
}

- (NSString *)blogId
{
    return @"3402766312264227078";
}

@end
