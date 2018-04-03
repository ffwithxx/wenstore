//
//  PSDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface PSDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITextField *caigouDate;

@property (strong, nonatomic) IBOutlet UITextField *remarkField;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UIView *bottomLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceOne;

@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *k1mf107;
@property (strong, nonatomic) NSString *k1mf101;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
