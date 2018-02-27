//
//  CallOrderThreeDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/12/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@interface CallOrderThreeDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *peisongLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLAB;
@property (strong, nonatomic) IBOutlet UILabel *shouhuoLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheResonLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheLab;
@property (strong, nonatomic) IBOutlet UIView *lineView;

- (void)showModel:(EditModel *)model with:(int)billState withTagStr:(NSString *)tagStr;
@end
