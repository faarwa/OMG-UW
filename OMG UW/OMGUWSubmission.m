//
//  OMGUWSubmission.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWSubmission.h"

@implementation OMGUWSubmission

- (id)initWithDictionaryInfo:(NSDictionary *)info
{
    self = [super init];
    
    if (self) {
        self = [[OMGUWSubmission alloc] init];
        
        [self setPostId:[info objectForKey:@"id"]];
        [self setContent:[info objectForKey:@"content"]];
        [self parseSubmissionContent];
        [self setLink:[NSURL URLWithString:[info objectForKey:@"url"]]];
        [self setTitle:[info objectForKey:@"title"]];
        
        NSString *dateAsString = [info objectForKey:@"published"];
        NSDateFormatter *df = [[NSDateFormatter alloc] init];
        [df setDateFormat:@"YYYY-MM-ddTHH:mm:ss-Z"];
        NSDate *date = [df dateFromString:dateAsString];
        
        [self setDate:date];
    }
    
    return self;
}

@end
