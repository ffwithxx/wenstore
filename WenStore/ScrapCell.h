//
//  ScrapCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScrapModel.h"

@interface ScrapCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titlelAB;

@property (strong, nonatomic) IBOutlet UILabel *baofeiLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *oneFgView;
@property (strong, nonatomic) IBOutlet UILabel *resonOneTitle;
@property (strong, nonatomic) IBOutlet UILabel *resonOneLab;
@property (strong, nonatomic) IBOutlet UILabel *resonTwoTitle;
@property (strong, nonatomic) IBOutlet UILabel *resonTwoLab;
-(void)showModel:(ScrapModel *)model;

@end
