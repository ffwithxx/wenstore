//
//  AsideDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsideModel.h"

@interface AsideDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *danweiLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
- (void)showModel:(AsideModel *)model;

@end
