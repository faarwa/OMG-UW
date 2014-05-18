//
//  OMGUWSubmissionCell.m
//  OMG UW
//
//  Created by Farwa Naqi on 3/15/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWSubmissionCell.h"
#import "UWStyle.h"

@implementation OMGUWSubmissionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSubmission:(OMGUWSubmission *)submission
{
    _submission = submission;
    [self.textLabel setNumberOfLines:0];
    [self.textLabel setTextAlignment:NSTextAlignmentLeft];
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setFont:[UWStyle cellFont]];
    
    NSString *text = [self.submission.title stringByAppendingString:[NSString stringWithFormat:@"\n%@", self.submission.content]];
    
    NSAttributedString *attributedContent = [UWStyle formatCellContentWithText:text forSubmission:self.submission];
    [self.textLabel setAttributedText:attributedContent];
}

@end
