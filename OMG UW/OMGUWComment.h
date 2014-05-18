//
//  OMGUWComment.h
//  OMG UW
//
//  Created by Farwa Naqi on 2014-03-15.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMGUWContent.h"

@interface OMGUWComment : OMGUWContent

- (id)initWithDictionaryInfo:(NSDictionary *)info;

@property (strong, nonatomic) NSMutableArray *replies;
@property (strong, nonatomic) NSString *commentId;
@property (strong, nonatomic) NSString *replyToId;
@property (strong, nonatomic) NSString *commentNum;

@end
