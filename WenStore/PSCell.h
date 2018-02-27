//
//  PSCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSModel.h"
@interface PSCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *commodityImg;//商品图片
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *specificationsLab;//规格
@property (strong, nonatomic)  UILabel *priceLab;//单价
@property (strong, nonatomic)  UIView *jishuView;//计数
@property (strong, nonatomic)  UIView *jijiaView;//计价
@property (strong, nonatomic)  UILabel *numLab;//计数
@property (strong, nonatomic)  UILabel *jipriceNum;//计价
@property (strong, nonatomic)  UILabel *orderCountLab;//计数数量
@property (strong, nonatomic)  UIButton *orderButton;//计数数量bth
@property (strong, nonatomic)  UIButton *plusBth;
@property (strong, nonatomic)  UIButton *minusBth;
@property (strong, nonatomic)  UIImageView *jiaImg;
@property (strong, nonatomic)  UIImageView *jianImg;


@property (strong, nonatomic)  UILabel *orderPriceCountLab;//计价数量
@property (strong, nonatomic)  UIImageView *jijiaPlusImg;
@property (strong, nonatomic)  UIImageView *jijiaMinImg;

@property (strong, nonatomic)  UIView *oneFgView;
@property (strong, nonatomic)  UIView *twoFgView;
@property (strong, nonatomic)  UIView *threeFgView;
@property (strong, nonatomic)  UIView *bottomView;

- (void)showModel:(PSModel *)model;
@end
