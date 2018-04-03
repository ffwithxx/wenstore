//
//  PurchaseOnePageVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface PurchaseOnePageVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIView *lineView;

@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;

@end
