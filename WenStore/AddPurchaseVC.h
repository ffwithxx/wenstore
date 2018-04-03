//
//  AddPurchaseVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface AddPurchaseVC : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;


@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UIImageView *SearchImg;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) NSDictionary *dataDict;
@property (strong, nonatomic) NSString *idStr;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
