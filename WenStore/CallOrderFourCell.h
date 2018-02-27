//
//  CallOrderFourCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "orderModel.h"
@protocol orderFourDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withModel:(orderModel *)model;

@end
@interface CallOrderFourCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIButton *submitBth;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *hedingBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;

@property (strong, nonatomic) IBOutlet UILabel *tuihuiDate;
-(void)showModel:(orderModel *)model;
@property (nonatomic,weak)id <orderFourDelegete> orderFourDelegate;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@end
