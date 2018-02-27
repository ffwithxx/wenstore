//
//  AddScrapVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface AddScrapVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) NSArray *reasonsArr;
@end
