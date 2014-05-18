//
//  OMGUWSubmission.h
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMGUWContent.h"

@interface OMGUWSubmission : OMGUWContent

- (id)initWithDictionaryInfo:(NSDictionary *)info;

@property (strong, nonatomic) NSString *type;
@property (strong, nonatomic) NSURL *link;
@property (strong, nonatomic) NSString *postId;
@property (strong, nonatomic) NSString *title;

@end
