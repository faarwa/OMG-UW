//
//  OMGUWBaseViewController.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWBaseViewController.h"

@implementation OMGUWBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.
    
    [self.omgLabel setTextColor:self.themeColour];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Subclass methods

- (void)getData
{
    
}

@end
