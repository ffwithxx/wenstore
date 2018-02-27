//
//  AddScrapCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddScrapModel.h"
@protocol orderCountDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withModel:(AddScrapModel *)model;;

@end
@protocol TanDelegate <NSObject>

@optional

-(void)scrapwithModel:(AddScrapModel *)model ;
@end

@protocol resonTanDelegate <NSObject>

@optional

-(void) resonTan:(NSString *)typeStr withModel:(AddScrapModel *)model;

@end

@protocol ChoiceresonTanDelegate <NSObject>

@optional

-(void) choiceResonTan:(NSString *)typeStr withModel:(AddScrapModel *)model;

@end

@interface AddScrapCell : UITableViewCell
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
@property (strong, nonatomic) id<TanDelegate> TanDelegate;
@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@property (strong, nonatomic) id<resonTanDelegate> resonDelegate;
@property (strong, nonatomic)  UIButton *orderButton;
@property (strong, nonatomic) id<ChoiceresonTanDelegate> resonOneDelegate;
- (void)showModel:(AddScrapModel *)model;

@end
