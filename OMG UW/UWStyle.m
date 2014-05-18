//
//  UWStyle.m
//  OMG UW
//
//  Created by Farwa Naqi on 2/21/2014.
//  Copyright (c) 2014 Farwa Naqi. All rights reserved.
//

#import "UWStyle.h"
#import "OMGUWComment.h"

@implementation UWStyle

#pragma mark - Colours

+ (UIColor *)omgBlueColour
{
    return [UIColor colorWithRed:33/255.0f green:117/255.0f blue:187/255.0f alpha:1];
}

+ (UIColor *)mcPurpleColour
{
    return [UIColor colorWithRed:103/255.0f green:42/255.0f blue:142/255.0f alpha:1];
}

+ (UIColor *)ohOrangeColour
{
    return [UIColor colorWithRed:245/255.0f green:147/255.0f blue:41/255.0f alpha:1];
}

+ (UIColor *)askGreenColour
{
    return [UIColor colorWithRed:2/255.0f green:118/255.0f blue:61/255.0f alpha:1];
}

#pragma mark - Fonts

+ (UIFont *)cellFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:14.0f];
}

+ (UIFont *)headerFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:31.0f];
}

+ (UIFont *)smallerCellFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Light" size:13.0f];
}

+ (UIFont *)boldedCellFont
{
    return [UIFont fontWithName:@"HelveticaNeue-Bold" size:14.0f];
}

+ (UIFont *)smallerItalicizedCellFont
{
    return [UIFont fontWithName:@"HelveticaNeue-LightItalic" size:13.0f];
}

#pragma mark - Cell styling

+ (NSString *)formatText:(NSString *)text
{
    text = [text stringByReplacingOccurrencesOfString:@"&nbsp;" withString:@""];
    text = [text stringByReplacingOccurrencesOfString:@"&apos;" withString:@"'"];
    text = [text stringByReplacingOccurrencesOfString:@"&#39;" withString:@"'"];
    text = [text stringByReplacingOccurrencesOfString:@"&gt;" withString:@">"];
    text = [text stringByReplacingOccurrencesOfString:@"&lt;" withString:@"<"];
    text = [text stringByReplacingOccurrencesOfString:@"&quot;" withString:@"\""];
    text = [text stringByReplacingOccurrencesOfString:@"&lt;3" withString:@"<3"];
    
    return text;
}

+ (NSAttributedString *)formatCellContentWithText:(NSString *)text forSubmission:(OMGUWSubmission *)submission
{
    // Initialize
    NSRange modsNote = [text rangeOfString:@"MOD's NOTE:"];
    text = [self formatText:text];
    NSMutableAttributedString *cellText = [[NSMutableAttributedString alloc] initWithString:text];
    
    // Add attributes
    if (![submission isKindOfClass:[OMGUWComment class]]) {
        [cellText addAttribute:NSForegroundColorAttributeName
                         value:[UIColor grayColor]
                         range:NSMakeRange(0, submission.title.length+1)];
        [cellText addAttribute:NSFontAttributeName
                         value:[self smallerCellFont]
                         range:NSMakeRange(0, submission.title.length+1)];
        
        NSRange typeRange = [text rangeOfString:submission.type];

        [cellText addAttribute:NSFontAttributeName
                         value:[self boldedCellFont]
                         range:NSMakeRange(typeRange.location, typeRange.length+1)];

    }
    // Italicize MOD's note if there is one
    if (modsNote.location != NSNotFound) {
        [cellText addAttribute:NSFontAttributeName
                         value:[self smallerItalicizedCellFont]
                         range:NSMakeRange(modsNote.location, text.length-modsNote.location)];
    }
    
    return cellText;
}

+ (CGFloat)heightForSubmission:(OMGUWSubmission *)submission inFrame:(CGRect)frame
{
    CGFloat height;
    
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);
    UILabel *tempLabel = [[UILabel alloc] init];
    
    NSString *text = [submission.title stringByAppendingString:[NSString stringWithFormat:@"\n%@", submission.content]];
    [tempLabel setAttributedText:[self formatCellContentWithText:text forSubmission:submission]];
    CGRect labelRect = [tempLabel.text boundingRectWithSize:maxSize
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:tempLabel.font}
                                                    context:nil];
    
    height = labelRect.size.height;
    
    return height;
}

+ (CGFloat)heightForCommentContent:(NSString *)content inFrame:(CGRect)frame
{
    UILabel *tempLabel = [[UILabel alloc] init];
 
    CGSize maxSize = CGSizeMake(frame.size.width, MAXFLOAT);

    [tempLabel setText:content];
    CGRect labelRect = [tempLabel.text boundingRectWithSize:maxSize
                                                    options:NSStringDrawingUsesLineFragmentOrigin
                                                 attributes:@{NSFontAttributeName:tempLabel.font}
                                                    context:nil];
    
    CGFloat height = labelRect.size.height;
    
    return height;

}

@end
