//
//  PurchaseDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface PurchaseDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UITextField *caigouFiled;
@property (strong, nonatomic) IBOutlet UITextField *remarkTextField;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLAB;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *hejiPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UILabel *jijiaLab;
@property (strong, nonatomic) NSString *typeStr;//1是编辑页面  2是列表

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
