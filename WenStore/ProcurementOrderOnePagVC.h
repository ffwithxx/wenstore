//
//  ProcurementOrderOnePagVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface ProcurementOrderOnePagVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) NSString *fanStr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIView *nodataView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *noDataView;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UILabel *rightLab;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
