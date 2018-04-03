//
//  PSvc.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface PSvc : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (nonatomic,strong) NSString *idStr;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (nonatomic,strong) NSDictionary *dataDict;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
