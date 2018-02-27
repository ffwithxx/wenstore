//
//  ThreeDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface ThreeDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *headView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UITextField *jisohuoDateFile;
@property (strong, nonatomic) IBOutlet UITextField *peisongDateFile;
@property (strong, nonatomic) IBOutlet UILabel *beiLab;

@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *yunLab;
@property (strong, nonatomic) IBOutlet UIView *sumPriceLab;

@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIImageView *headImgView;
@property (strong, nonatomic) NSMutableDictionary *datDict;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIButton *HeadImg;
@end
