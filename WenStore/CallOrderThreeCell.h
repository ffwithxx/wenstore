//
//  CallOrderThreeCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"
@protocol orderThreeDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withModel:(orderModel *)model;

@end

@interface CallOrderThreeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *peiLab;
@property (strong, nonatomic) IBOutlet UIImageView *jiImg;
@property (strong, nonatomic) IBOutlet UILabel *yunPrice;
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *jiheBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;

@property (strong, nonatomic) IBOutlet UILabel *jiaohuoLab;
-(void)showModel:(orderModel *)model;
@property (nonatomic,weak)id <orderThreeDelegete> orderthreeDelegate;
@end
