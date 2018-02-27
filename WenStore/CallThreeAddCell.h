//
//  CallThreeAddCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@protocol orderCountDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price withModel:(EditModel *)oneModel;;

@end
@protocol TanDelegate <NSObject>

@optional

-(void) getwithKey:(NSString *)key withIndex:(NSInteger)index withModel:(EditModel *)model withweizhi:(NSString *)weizhi ;
@end

typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);
@interface CallThreeAddCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *commodityImg;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *specificationsLab;
@property (strong, nonatomic)  UILabel *stockLab;
@property (strong, nonatomic)  UILabel *priceLab;
@property (strong, nonatomic)  UILabel *orderCountLab;
@property (strong, nonatomic)  UIButton *plusBth;
@property (strong, nonatomic)  UIButton *minusBth;
//@property (strong, nonatomic)  UIButton *xiaBth;
//@property (strong, nonatomic)  UIImageView *oneImg;
//@property (strong, nonatomic)  UIImageView *xiaImg;
//@property (strong, nonatomic)  UIImageView *twoImg;
//@property (strong, nonatomic)  UIImageView *threeImg;
//@property (strong, nonatomic)  UIImageView *fourImg;
@property (strong, nonatomic)  UIImageView *jiaImg;
@property (strong, nonatomic)  UIImageView *jianImg;
@property (strong, nonatomic)  UIView *fgView;
@property (strong, nonatomic)  UIView *bottomView;
@property (nonatomic, assign) NSDecimalNumber *numCount;
@property (strong, nonatomic)  UIButton *orderButton;
@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@property (nonatomic,copy) void(^getIpBlock)(NSInteger ipArr);
@property (nonatomic, strong) __block  btnPulsBlock block;
@property (strong, nonatomic) id<TanDelegate> TanDelegate;

- (void)showModel:(EditModel *)model;

@end
