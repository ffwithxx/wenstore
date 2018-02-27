//
//  AddStocktakVCCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StocktakModel.h"

@protocol cancleDelegate <NSObject>

@optional

- (void)cancle:(StocktakModel *)model;

@end

@protocol stockDelegate <NSObject>

@optional

- (void)stockWithModel:(StocktakModel *)model withTag:(NSInteger)tag with:(NSDecimalNumber *)count;

@end

@protocol inputDelegate <NSObject>

@optional

- (void)stockWithModel:(StocktakModel *)model withTag:(NSInteger)tag;

@end


@interface AddStocktakVCCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *oneLab;
@property (strong, nonatomic) IBOutlet UILabel *twoLab;
@property (strong, nonatomic) IBOutlet UILabel *threeLab;
@property (strong, nonatomic) IBOutlet UILabel *guiGeLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *detailView;
@property (strong, nonatomic) IBOutlet UIView *xiaView;


@property (strong, nonatomic) UIImageView *maxPlusImg;
@property (strong, nonatomic) UIImageView *maxMinImg;
@property (strong, nonatomic) UIButton *maxPlusBth;
@property (strong, nonatomic) UIButton *maxMinbth;
@property (strong, nonatomic) UILabel *maxcountLab;
@property (strong, nonatomic) UIButton *maxcountBth;

@property (strong, nonatomic) UIImageView *middlePlusImg;
@property (strong, nonatomic) UIImageView *middleMinImg;
@property (strong, nonatomic) UIButton *middlePlusBth;
@property (strong, nonatomic) UIButton *middleMinbth;
@property (strong, nonatomic) UILabel *middlecountLab;
@property (strong, nonatomic) UIButton *middlecountBth;

@property (strong, nonatomic) UIImageView *minPlusImg;
@property (strong, nonatomic) UIImageView *minMinImg;
@property (strong, nonatomic) UIButton *minPlusBth;
@property (strong, nonatomic) UIButton *minMinbth;

@property (strong, nonatomic) UILabel *mincountLab;
@property (strong, nonatomic) UIButton *mincountBth;
@property (strong, nonatomic) IBOutlet UIButton *cancleBth;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) id<cancleDelegate> cancleDelegate;
@property (strong, nonatomic) id<stockDelegate > stockDelegate;
@property (strong, nonatomic) id<inputDelegate > inputDelegate;
- (void)showModel:(StocktakModel *)model withType:(NSString *)typeStr;
@end
