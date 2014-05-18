//
//  OMGUWContent.m
//  OMG UW
//
//  Created by Farwa Naqi on 3/15/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "OMGUWContent.h"

@implementation OMGUWContent

- (void)parseSubmissionContent
{
    NSString *str = self.content;
    
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"<br />" withString:@"\n"];
    str = [self stripHtmlFromString:str];
    
    [self setContent:str];
}

- (NSString *)stripHtmlFromString:(NSString *)str
{
    NSRange r;
    while ((r = [str rangeOfString:@"<[^>]+>" options:NSRegularExpressionSearch]).location != NSNotFound)
        str = [str stringByReplacingCharactersInRange:r withString:@""];
    return str;
}

@end
