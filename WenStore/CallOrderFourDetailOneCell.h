//
//  CallOrderFourDetailOneCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@protocol ChoiceresonTanDelegate <NSObject>

@optional

-(void) choiceResonTan:(NSString *)typeStr withModel:(EditModel *)model;

@end


@protocol onedelegate <NSObject>

@optional

-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end

@protocol inputdelegate <NSObject>

@optional

-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag ;

@end
@protocol resonTanDelegate <NSObject>

@optional

-(void) resonTan:(NSString *)typeStr withModel:(EditModel *)model;

@end





typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);
@interface CallOrderFourDetailOneCell : UITableViewCell
@property (strong, nonatomic)  UIImageView *headImg;
@property (strong, nonatomic)  UILabel *nameLab;
@property (strong, nonatomic)  UILabel *guigeLab;
@property (strong, nonatomic)  UILabel *priceLab;
@property (strong, nonatomic)  UIImageView *jianImg;
@property (strong, nonatomic)  UILabel *orderNumLab;
@property (strong, nonatomic)  UIImageView *jiaImg;
@property (strong, nonatomic)  UIButton *jiaBth;
@property (strong, nonatomic)  UIButton *minuBth;
@property (strong, nonatomic)  UIView *lineOneView;
@property (strong, nonatomic)  UIView *lastView;
@property (strong, nonatomic)  UIView *bigView;
@property (strong, nonatomic)  UIView *resonView;
@property (strong, nonatomic)  UIButton *resonButton;
@property (strong, nonatomic)  UIImageView *addOneImg;
@property (strong, nonatomic)  UITextField *resonTextFile;
@property (strong, nonatomic)  UIView *fgTwoView;
@property (strong, nonatomic)  UIView *resonSmView;
@property (strong, nonatomic)  UIImageView *addTwoImg;
@property (strong, nonatomic)  UITextField *resonSmTextFile;
@property (strong, nonatomic)  UIView *fgThreeView;
@property (strong, nonatomic)  UIView *aView;
@property (strong, nonatomic)  UIButton *resonSMbTH;
@property (strong, nonatomic)  UIView *imgSrvView;
@property (nonatomic, assign) NSDecimalNumber *numCount;
@property (weak,nonatomic) id<onedelegate > oneDelegate;
@property (weak,nonatomic) id<inputdelegate > inputDelegate;
@property (strong, nonatomic) id<resonTanDelegate> resonDelegate;
@property (strong, nonatomic) id<ChoiceresonTanDelegate> resonOneDelegate;
@property (strong, nonatomic)  UIButton *orderButton;
- (void)showModel:(EditModel *)model;

@end
