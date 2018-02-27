//
//  CallOrderFourDetailTwoCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"

@interface CallOrderFourDetailTwoCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *tuihuiNumLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheNumLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UILabel *resonTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *resonLad;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UILabel *resonShuoMingLab;
@property (strong, nonatomic) IBOutlet UILabel *resonSMtitleLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *jiheLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
-(void)showModel:(EditModel *)model;

@end
