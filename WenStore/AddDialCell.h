//
//  AddDialCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "DialModel.h"
@protocol orderCountDelegate <NSObject>

@optional

-(void) getdialOrderCount:(NSDecimalNumber *)count withModel:(DialModel *)model;

@end
@protocol TanDelegate <NSObject>

@optional

-(void)scrapwithModel:(DialModel *)model ;
@end


@interface AddDialCell : UITableViewCell
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

@property (nonatomic, assign) NSDecimalNumber *numCount;
@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@property (strong, nonatomic)  UIButton *orderButton;

@property (strong, nonatomic) id<TanDelegate> TanDelegate;
- (void)showModel:(DialModel *)model;

@end
