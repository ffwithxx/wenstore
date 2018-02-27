//
//  AddPurchaseCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPurchaseModel.h"
@protocol purchasedelegate <NSObject>

@optional

-(void)procurementWithModel:(AddPurchaseModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end
@protocol inpuedelegate <NSObject>

@optional

-(void)procurementWithModel:(AddPurchaseModel *)model withTag:(NSInteger)tag ;

@end
//修改价格
@protocol changedelegate <NSObject>

@optional

-(void)changeWithModel:(AddPurchaseModel *)model ;

@end
@interface AddPurchaseCell : UITableViewCell
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

@property (strong, nonatomic)  UIButton *jijiaPlusBth;
@property (strong, nonatomic)  UIButton *jijiaMinBth;
@property (strong, nonatomic)  UIButton *orderPriceCountBth;
@property (strong, nonatomic)  UIButton *changePriceBth;
@property (strong, nonatomic)  UIView *oneFgView;
@property (strong, nonatomic)  UIView *twoFgView;
@property (strong, nonatomic)  UIView *threeFgView;
@property (strong, nonatomic)  UIView *bottomView;
- (void)showModelWith:(AddPurchaseModel *)model;
@property (weak,nonatomic) id<purchasedelegate > purchaseDelegate;
@property (weak,nonatomic) id<inpuedelegate >inputDelegate;
@property (weak,nonatomic) id<changedelegate > changeDelegate;

@end
