//
//  StocktakCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StocktakModel.h"

@interface StocktakCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *oneLab;
@property (strong, nonatomic) IBOutlet UILabel *twoLab;
@property (strong, nonatomic) IBOutlet UILabel *threeLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UIView *detailVIew;

@property (strong, nonatomic) IBOutlet UIView *xiaView;
@property (strong, nonatomic) IBOutlet UIView *topView;

- (void)showModel:(StocktakModel *)model;
@end
