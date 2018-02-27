//
//  CallOrderFourDetailTwoVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface CallOrderFourDetailTwoVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *typeStr;//1为点击整面，2位点击核定
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@end
