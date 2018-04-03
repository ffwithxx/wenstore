//
//  CallOrderFourDetailOneVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface CallOrderFourDetailOneVC : BaseViewController

@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UITableView *carTableView;
@property (strong, nonatomic) IBOutlet UIView *topview;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *sumOrderCount;
@property (strong, nonatomic) IBOutlet UIButton *addOrderBth;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;

@property (strong, nonatomic) NSArray *reasonsArr;
@end
