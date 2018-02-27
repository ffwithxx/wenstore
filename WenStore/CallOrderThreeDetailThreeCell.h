//
//  CallOrderThreeDetailThreeCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@interface CallOrderThreeDetailThreeCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titlelAB;
@property (strong, nonatomic) IBOutlet UILabel *fahuoLab;
@property (strong, nonatomic) IBOutlet UILabel *shouhuoLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *resonView;
@property (strong, nonatomic) IBOutlet UILabel *resonOneLab;
@property (strong, nonatomic) IBOutlet UILabel *resonTwoLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
-(void)showModel:(EditModel *)model;
@end
