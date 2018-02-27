//
//  ThreeDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@interface ThreeDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic)  UIView *fgView;

@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;


-(void)showModel:(EditModel *)model;
@end
