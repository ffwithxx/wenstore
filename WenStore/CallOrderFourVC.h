//
//  CallOrderFourVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface CallOrderFourVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;

@property (strong, nonatomic) IBOutlet UIView *noDataView;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong,nonatomic)  NSArray *reasonsArr;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIView *oneView;

@end
