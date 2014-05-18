//
//  UWStyle.h
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OMGUWSubmission.h"
#import "OMGUWComment.h"

#define OMG_TITLE @"OMG"
#define MC_TITLE @"MCs"
#define OH_TITLE @"OVERHEARDs"
#define ASK_TITLE @"ASK"

@interface UWStyle : NSObject

// Colors
+ (UIColor *)omgBlueColour;
+ (UIColor *)mcPurpleColour;
+ (UIColor *)ohOrangeColour;
+ (UIColor *)askGreenColour;

// Fonts
+ (UIFont *)cellFont;
+ (UIFont *)headerFont;
+ (UIFont *)smallerCellFont;
+ (UIFont *)boldedCellFont;
+ (UIFont *)smallerItalicizedCellFont;

// Cell styling
+ (NSString *)formatText:(NSString *)text;
+ (NSMutableAttributedString *)formatCellContentWithText:(NSString *)text forSubmission:(OMGUWSubmission *)submission;
+ (CGFloat)heightForSubmission:(OMGUWSubmission *)submission inFrame:(CGRect)frame;
+ (CGFloat)heightForCommentContent:(NSString *)content inFrame:(CGRect)frame;

@end
