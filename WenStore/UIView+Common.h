//
//  UIView+Common.h
//  FirstLove
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 fengli. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Postion)
/**
 * 获取屏幕的宽
 *
 *  
 */
CGFloat screenWidth() ;

/*
 
 获取屏幕高
 
 */

CGFloat screenHeight();


/**
 *  返回当前视图宽
 *
 *  @return 返回当前视图宽
 */


/**
 *  返回当前视图高
 *
 *  @return 返回当前视图高
 */
- (CGFloat)height;
- (CGFloat)width;

/**
 *  根据 frame 来返回宽
 *
 *  @param rect 视图的rect
 *
 *  @return 宽
 */

CGFloat width (CGRect rect);


/**
 *  根据 frame 来返回高
 *
 *  @param rect 视图的rect
 *
 *  @return 高
 */

CGFloat height (CGRect rect);


CGFloat maxX (UIView *view);
CGFloat midX (UIView *view);
CGFloat minX(UIView *view);

CGFloat maxY (UIView *view);
CGFloat midY (UIView *view);
CGFloat minY(UIView *view);

@end

@interface UIView (Common)

@end
