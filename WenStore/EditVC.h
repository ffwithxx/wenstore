//
//  EditVC.h
//  WenStore
//
//  Created by 冯丽 on 17/9/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface EditVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *tanView;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UIView *topview;
@property (strong, nonatomic) IBOutlet UITableView *carTableView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *bottonView;
@property (strong, nonatomic) IBOutlet UILabel *forecastLab;
@property (strong, nonatomic) IBOutlet UIButton *forecastBth;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UIButton *addOrderBth;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *countStr;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;

@property (strong, nonatomic) IBOutlet UILabel *searchTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *searchLab;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@end
