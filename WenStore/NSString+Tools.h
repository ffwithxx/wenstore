//
//  NSString+Tools.h
//  Miao
//
//  Created by 指南猫 on 15/12/1.
//  Copyright © 2015年 ZNM. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (Tools)

/**
 *  计算文字所占的尺寸
 *
 *  @param font    文字的字体
 *  @param maxSize 文字最大所占的矩形
 *
 *  @return 文字的尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize;

/**
 *  计算富文本所占的尺寸
 *
 *  @param font        文字的字体
 *  @param maxSize     文字最大所占的矩形
 *  @param lineSpacing 行距
 *  @param headIndent  段首间距
 *
 *  @return 文字的尺寸大小
 */
- (CGSize)sizeWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andLineSpacing:(CGFloat)lineSpacing;

- (NSMutableAttributedString *)attributedStringWithFont:(UIFont *)font andMaxSize:(CGSize)maxSize andLineSpacing:(CGFloat)lineSpacing;

@end
