//
//  RecipientsCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/2.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RecipientsModel.h"
@interface RecipientsCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titlelAB;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
-(void)showModel:(RecipientsModel *)model;
@end
