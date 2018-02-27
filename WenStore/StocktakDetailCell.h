//
//  StocktakDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StocktakModel.h"

@interface StocktakDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *guiGeLab;
@property (strong, nonatomic) IBOutlet UILabel *countNum;
- (void)showModel:(StocktakModel *)model;

@end
