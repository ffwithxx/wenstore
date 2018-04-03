//
//  ProcurementDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface ProcurementDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UITextField *caigouDate;
@property (strong, nonatomic) IBOutlet UITextField *yujiaoDate;
@property (strong, nonatomic) IBOutlet UITextField *beiFile;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceOneLab;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *k1mf107;
@property (strong, nonatomic) NSString *k1mf101;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
