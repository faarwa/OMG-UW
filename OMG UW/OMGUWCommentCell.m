//
//  OMGUWCommentCell.m
//  OMG UW
//
//  Created by Farwa Naqi on 3/15/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWCommentCell.h"
#import "UWStyle.h"

@implementation OMGUWCommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return self;
}

- (void)setComment:(OMGUWComment *)comment
{
    _comment = comment;
    [self.textLabel setNumberOfLines:0];
    [self.textLabel setTextAlignment:NSTextAlignmentLeft];
    [self.textLabel setLineBreakMode:NSLineBreakByWordWrapping];
    [self.textLabel setFont:[UWStyle cellFont]];
    
    NSString *content;
    
    content = [NSString stringWithFormat:@"%@  %@", self.comment.commentNum, self.comment.content];
    
    NSMutableArray *replies = [[NSMutableArray alloc] init];
    
    for (OMGUWComment *reply in comment.replies) {
        NSString *replyText = [NSString stringWithFormat:@"%@  %@", reply.commentNum, reply.content];
        [replies addObject:replyText];
    }
    
    if ([replies count] > 0) {
        NSString *allReplies = [replies componentsJoinedByString:@"\n"];
        
        content = [content stringByAppendingString:[NSString stringWithFormat:@"%@\n%@", content, allReplies]];
    }
    
    content = [UWStyle formatText:content];
    
    [self.textLabel setText:content];
}

@end
