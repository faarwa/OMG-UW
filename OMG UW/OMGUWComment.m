//
//  OMGUWComment.m
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWComment.h"

@implementation OMGUWComment

- (id)initWithDictionaryInfo:(NSDictionary *)info
{
    self = [super init];
    
    if (self) {
        [self setContent:[info objectForKey:@"content"]];
        [self parseSubmissionContent];
        [self setCommentId:[info objectForKey:@"id"]];
        
        NSString *dateAsString = [info objectForKey:@"published"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-ddTHH:mm:ss-Z"];
        NSDate *date = [df dateFromString:dateAsString];
        
        [self setDate:date];
        
        if ([info objectForKey:@"inReplyTo"]) {
            [self setReplyToId:[[info objectForKey:@"inReplyTo"] objectForKey:@"id"]];
        }
        
        self.replies = [[NSMutableArray alloc] init];
    }
    
    return self;
}

@end
