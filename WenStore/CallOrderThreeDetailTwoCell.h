//
//  CallOrderThreeDetailTwoCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"

@interface CallOrderThreeDetailTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titlelAB;
@property (strong, nonatomic) IBOutlet UILabel *fahuoLab;
@property (strong, nonatomic) IBOutlet UILabel *shouhuoLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
-(void)showModel:(EditModel *)model;
@property (strong, nonatomic) IBOutlet UILabel *cahyiLab;
@end
