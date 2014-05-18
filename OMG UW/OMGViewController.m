//
//  OMGViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGViewController.h"

@implementation OMGViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = OMG_TITLE;
        [self.tabBarItem setImage:[UIImage imageNamed:@"edit.png"]];
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
    return [UWStyle omgBlueColour];
}

- (NSString *)type
{
    return @"OMG";
}

- (NSString *)key
{
    return @"OMG";
}

- (NSString *)blogId
{
    return @"7392661970363847635";
}

@end
