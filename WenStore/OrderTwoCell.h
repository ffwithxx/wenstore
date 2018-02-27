//
//  OrderTwoCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withCount:(NSDecimalNumber *)count withModel:(orderModel *)model;

@end


@interface OrderTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UILabel *jiaoDate;
@property (strong, nonatomic) IBOutlet UILabel *otherLab;
@property (strong, nonatomic) IBOutlet UILabel *peiDate;
@property (strong, nonatomic) IBOutlet UIImageView *jiImg;
@property (strong, nonatomic) IBOutlet UILabel *yunpPrice;
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIView *fgview;
@property (strong, nonatomic) IBOutlet UIView *orderNumView;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *oneMoreBth;

@property (nonatomic,weak)id <orderDelegete> orderDelegate;

- (void)showModel:(orderModel *)model withDict:(NSMutableDictionary *)dict;
@end
