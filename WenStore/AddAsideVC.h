//
//  AddAsideVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface AddAsideVC : BaseViewController
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSArray *detpsArr;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@end
