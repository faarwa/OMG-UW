//
//  OMGUWContent.h
//  OMG UW
//
//  Created by Farwa Naqi on 3/15/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OMGUWContent : NSObject

@property (strong, nonatomic) NSString *content;
@property (strong, nonatomic) NSDate *date;

- (void)parseSubmissionContent;
- (NSString *)stripHtmlFromString:(NSString *)str;

@end
