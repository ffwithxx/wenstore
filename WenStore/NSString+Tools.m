//
//  NSString+Tools.m
//  Miao
//
//  Created by 指南猫 on 15/12/1.
//  Copyright © 2015年 ZNM. All rights reserved.
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize {
    
    if (self == nil) {
        
        return CGSizeZero;
    }
    
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{ NSFontAttributeName : font } context:nil].size;
}

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andLineSpacing:(CGFloat)lineSpacing {
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    paragraphStyle.lineSpacing = lineSpacing;
    CGSize size = [@"缩进" sizeWithFont:font andMaxSize:CGSizeMake(50.0, 50.0)];
    paragraphStyle.firstLineHeadIndent = size.width;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:self attributes:@{NSFontAttributeName : font, NSParagraphStyleAttributeName : paragraphStyle}];
    
    return attributedString;
}

- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andLineSpacing:(CGFloat)lineSpacing {
    
    if (self == nil) {
        
        return CGSizeZero;
    }
    NSMutableAttributedString *attributedString = [self attributedStringWithFont:font andMaxSize:maxSize andLineSpacing:lineSpacing];
    return [attributedString boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin context:nil].size;
}

@end
