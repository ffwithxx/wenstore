//
//  UIView+Common.m
//  FirstLove
//
//  Created by qianfeng on 15/9/23.
//  Copyright (c) 2015年 fengli. All rights reserved.
//

#import "UIView+Common.h"


@implementation UIView (Postion)


/*
 获取屏幕宽
 
 */

CGFloat screenWidth() {

    return [[UIScreen mainScreen] bounds].size.width;

}


/*
 
 获取屏幕高
 
 */

CGFloat screenHeight() {
    
    return [[UIScreen mainScreen] bounds].size.height;
    
}

/**
 *  根据 frame 来返回宽
 *
 *  @param rect 视图的rect
 *
 *  @return 宽
 */

CGFloat width (CGRect rect){

    return CGRectGetWidth(rect);


}
/**
 *  根据 frame 来返回高
 *
 *  @param rect 视图的rect
 *
 *  @return 高
 */

CGFloat height (CGRect rect){
    
    return CGRectGetHeight(rect);
    
    
}


/**
 *  返回当前视图宽
 *
 *  @return 返回当前视图宽
 */

- (CGFloat)width {
    return self.frame.size.width;

}




/**
 *  返回当前视图高
 *
 *  @return 返回当前视图高
 */
- (CGFloat)height {

    return self.frame.size.height;
}

CGFloat maxX (UIView *view) {
    return CGRectGetMaxX(view.frame);

}
CGFloat midX (UIView *view) {
    return CGRectGetMidX(view.frame);
    
}

CGFloat minX(UIView *view) {
    return CGRectGetMinX(view.frame);
    
}

CGFloat maxY (UIView *view) {
    return CGRectGetMaxY(view.frame);
    
}
CGFloat midY(UIView *view) {
    return CGRectGetMidY(view.frame);
    
}

CGFloat minY(UIView *view) {
    return CGRectGetMinY(view.frame);
    
}

@end

@implementation UIView (Common)

@end
