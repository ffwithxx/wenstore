//
//  CallOrderThreeDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/12/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "orderModel.h"

@interface CallOrderThreeDetailVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIImageView *oneImgView;
@property (strong, nonatomic) IBOutlet UIImageView *twoImgView;
@property (strong, nonatomic) IBOutlet UIImageView *threeImgView;
@property (strong, nonatomic) IBOutlet UIImageView *fourImgView;
@property (strong, nonatomic) IBOutlet UILabel *oneTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *oneDateLab;
@property (strong, nonatomic) IBOutlet UILabel *oneTimeLab;

@property (strong, nonatomic) IBOutlet UILabel *twoTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *twoDateLab;
@property (strong, nonatomic) IBOutlet UILabel *twoTimeLab;

@property (strong, nonatomic) IBOutlet UILabel *threeTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *threeDateLab;
@property (strong, nonatomic) IBOutlet UILabel *threeTimeLab;

@property (strong, nonatomic) IBOutlet UILabel *fourTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *fourDateLab;
@property (strong, nonatomic) IBOutlet UILabel *fourTimeLab;
@property (strong, nonatomic) IBOutlet UITextField *peiTextFile;
@property (strong, nonatomic) IBOutlet UITextField *shouDateFile;
@property (strong, nonatomic) IBOutlet UILabel *beiLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *xiadanLab;
@property (strong, nonatomic) IBOutlet UILabel *menshiNameLab;
@property (strong, nonatomic) IBOutlet UILabel *menshiNumLab;
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) orderModel *orderModel;
@property (strong,nonatomic) NSDictionary *dataDict;
@property (strong,nonatomic) NSString *tagStr;
@property (assign,nonatomic) int billstate;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UILabel *beiTitle;
@property (strong, nonatomic) IBOutlet UIView *beiView;
@property (strong, nonatomic) IBOutlet UILabel *xiadanIdLab;
@property (strong, nonatomic) IBOutlet UIView *ZZview;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIView *TwoView;

@end
