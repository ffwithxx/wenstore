//
//  ProcurementOrderVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface ProcurementOrderVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *leftTableView; 
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UITableView *carTableView;
@property (strong, nonatomic) IBOutlet UIView *bigView;

@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UIButton *addOrderBth;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UIImageView *SearchImg;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
