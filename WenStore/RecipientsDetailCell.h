//
//  RecipientsDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/2.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipientsModel.h"
@interface RecipientsDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
- (void)showModel:(RecipientsModel *)model;
@end
