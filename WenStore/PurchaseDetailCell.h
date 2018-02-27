//
//  PurchaseDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddPurchaseModel.h"
@interface PurchaseDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *danweiLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *jijiaLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;

- (void)showWithModel:(AddPurchaseModel *)model;
@end
