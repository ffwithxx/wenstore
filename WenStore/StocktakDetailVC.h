//
//  StocktakDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface StocktakDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *sumCountNumLab;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITextField *dateTextFile;
@property (strong, nonatomic) IBOutlet UITextField *remarkFile;
@property (strong, nonatomic) IBOutlet UILabel *sumCountTwoLab;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (nonatomic, strong) NSString *typeStr;//2为编辑页面进入到提交

@end
