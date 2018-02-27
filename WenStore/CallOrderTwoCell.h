//
//  CallOrderTwoCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"

@protocol maxHeiDelegate <NSObject>

@optional

-(void)getMaxHei:(CGFloat)maxHei withKey:(NSString *)key withIndex:(NSInteger)index;
@end

@protocol TanDelegate <NSObject>

@optional

-(void) getwithKey:(NSString *)key withIndex:(NSInteger)index withModel:(NewModel *)model withweizhi:(NSString *)weizhi ;
@end


@protocol orderCountDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price withStr:(NSString *)str ;

@end

@protocol remindDelegate <NSObject>

@optional

-(void) remindStr:(NSString *)remindStr with:(NewModel *)model ;

@end


typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);
typedef void(^btnxiaBlock)(CGFloat count, BOOL animated);
@interface CallOrderTwoCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *commodityImg;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *specificationsLab;
@property (strong, nonatomic)  UILabel *stockLab;
@property (strong, nonatomic)  UILabel *priceLab;
@property (strong, nonatomic)  UILabel *orderCountLab;
@property (strong, nonatomic)  UIButton *plusBth;
@property (strong, nonatomic)  UIButton *minusBth;
@property (strong, nonatomic)  UIButton *xiaBth;
@property (strong, nonatomic)  UIImageView *oneImg;
@property (strong, nonatomic)  UIImageView *xiaImg;
@property (strong, nonatomic)  UIImageView *twoImg;
@property (strong, nonatomic)  UIImageView *threeImg;
@property (strong, nonatomic)  UIImageView *fourImg;
@property (strong, nonatomic)  UIImageView *jiaImg;
@property (strong, nonatomic)  UIImageView *jianImg;
@property (strong, nonatomic)  UIView *fgView;
@property (strong, nonatomic)  UIView *bottomView;
@property (strong, nonatomic)  UIView *bigView;
@property (strong, nonatomic)  UIView *xiaView;
@property (strong, nonatomic)  UIButton *upButton;
@property (strong, nonatomic)  UIButton *orderButton;
@property (strong, nonatomic)  UIButton *remindButton;
@property(nonatomic,weak) id<maxHeiDelegate> delegate;
@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@property (strong, nonatomic) id<TanDelegate> TanDelegate;
@property (strong, nonatomic) id<remindDelegate> reminDelegate;
@property (nonatomic, strong)  UIImageView *upView;
@property (nonatomic, strong) NSDecimalNumber *numCount;
@property (nonatomic,copy) void(^getIpBlock)(NSInteger ipArr);
@property (nonatomic, strong) __block  btnPulsBlock block;
@property (nonatomic, strong) __block  btnxiaBlock xiablock;
- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict withKey:(NSString *)key withIndex:(NSInteger) currentIndex;


@end
