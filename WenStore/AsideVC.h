//
//  AsideVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "AsideModel.h"
@interface AsideVC : BaseViewController
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (nonatomic,strong) NSString *idStr;
@property (nonatomic,strong) NSDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;

@end