//
//  BaseViewController.h
//  Blossoms
//
//  Created by chenghong_mac on 15/11/25.
//  Copyright © 2015年 FL. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "LYMessageToast.h"

@interface BaseViewController : UIViewController

@property (nonatomic)NSMutableArray *dataArray;
@property (nonatomic,strong) UIView *loadingView;
@property (nonatomic, strong) UIButton *blackButton;
- (void)setNavTitle;
- (void)creatTitleText:(NSString *)text;
- (void)getUserInfoByDictionory:(NSDictionary *)dic;
- (void)isxiugaiMiMa;
/**
 *  自动弹出警告框  1.5s消失
 */
- (void)Alert:(NSString *)AlertStr;
/**
 *  创建背景滚动视图
 *
 *  @param picArray    图片数组
 *  @param imgScroView 滚动视图 (全局变量)
 */
-(void)creatUI:(NSArray *)picArray imgScroView:(UIScrollView *)imgScroView buttonTag:(NSInteger)buttonTag;

/**
 *  背景滚动视图的点击事件
 */
- (void)hidden:(UIButton *)button;

- (void)bigImage;
-(void)blackButtonClick;
- (void)pushNewViewController:(UIViewController *)newViewController;
/**
 *  控制抽屉可否打开左侧页面
 *
 *  @param enable YES 打开抽屉  NO 关闭抽屉
 */
- (void)enableOpenLeftDrawer:(BOOL)enable;
- (void)show ;
- (void)dismiss;
@end
