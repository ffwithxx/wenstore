//
//  ProcurementDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AddProcurementModel.h"
@interface ProcurementDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *danweiLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *jijialAB;
- (void)showModel:(AddProcurementModel *)model;
@end
