//
//  OrderTwoVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderTwoVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) NSString *fanStr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIView *nodataView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@end
