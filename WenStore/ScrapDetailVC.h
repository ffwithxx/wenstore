//
//  ScrapDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface ScrapDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UITextField *tuihuoDateFile;
@property (strong, nonatomic) IBOutlet UILabel *beiLab;

@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;

@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;

@property (strong, nonatomic) IBOutlet UITableView *bigTableView;

@property (strong, nonatomic) NSMutableDictionary *datDict;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIButton *HeadImg;
@end
