//
//  ScrapDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddScrapModel.h"

@interface ScrapDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic)  UIView *fgView;

@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;


-(void)showModel:(AddScrapModel *)model;


@end
