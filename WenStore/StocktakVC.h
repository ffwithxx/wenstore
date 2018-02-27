//
//  StocktakVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface StocktakVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong,nonatomic)  NSString *idStr;
@property (nonatomic,strong)  NSDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;

@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@end
