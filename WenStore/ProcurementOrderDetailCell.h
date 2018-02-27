//
//  ProcurementOrderDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProcurementModel.h"
@interface ProcurementOrderDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *danweiLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *jijiaLab;
-(void)showModel:(AddProcurementModel *)model;
@end
