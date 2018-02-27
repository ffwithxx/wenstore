//
//  DealtViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface DealtViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollerView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UILabel *oneViewTitle;
@property (strong, nonatomic) IBOutlet UILabel *oneViewNumLab;
@property (strong, nonatomic) IBOutlet UILabel *oneViewTime;
@property (strong, nonatomic) IBOutlet UILabel *oneViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *oneViewMore;

@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UILabel *twoViewTitle;
@property (strong, nonatomic) IBOutlet UILabel *twoViewNumLab;
@property (strong, nonatomic) IBOutlet UILabel *twoViewTime;
@property (strong, nonatomic) IBOutlet UILabel *twoViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *twoViewMore;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UILabel *threeViewTitle;
@property (strong, nonatomic) IBOutlet UILabel *threeViewNumLab;
@property (strong, nonatomic) IBOutlet UILabel *threeViewTime;
@property (strong, nonatomic) IBOutlet UILabel *threeViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *threeViewMore;
@property (strong, nonatomic) IBOutlet UIView *fourView;
@property (strong, nonatomic) IBOutlet UILabel *fourViewTitle;
@property (strong, nonatomic) IBOutlet UILabel *fourViewNumLab;
@property (strong, nonatomic) IBOutlet UILabel *fourViewTime;
@property (strong, nonatomic) IBOutlet UILabel *fourViewDetail;
@property (strong, nonatomic) IBOutlet UILabel *fourViewMore;
@property (strong, nonatomic) IBOutlet UIView *bigView;

@property (strong, nonatomic) IBOutlet UITableView *bigtableView;
@property (strong, nonatomic)NSMutableDictionary *dataDict;

@end
