//
//  ProcurementOrderDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "ProcurementOrderOnePagModel.h"
@interface ProcurementOrderDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UITableView *bigTableVIew;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIButton *sumbitBth;

@property (strong, nonatomic) IBOutlet UITextField *caigouDateFile;
@property (strong, nonatomic) IBOutlet UITextField *yujiaoDateFile;
@property (strong, nonatomic) IBOutlet UILabel *titleName;
@property (strong, nonatomic) IBOutlet UILabel *beizhuLab;
@property (strong, nonatomic) IBOutlet UILabel *beiTitle;
@property (strong, nonatomic) IBOutlet UIView *beiView;
@property (strong, nonatomic) IBOutlet UILabel *idLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *yunLab;
@property (strong, nonatomic) IBOutlet UILabel *zongLab;
@property (strong, nonatomic) IBOutlet UILabel *xiadanName;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *storeId;

@property (strong, nonatomic) IBOutlet UIView *bottomView;

@property (strong, nonatomic) IBOutlet UIView *topViewOne;
@property (strong, nonatomic) NSString *fanStr;
@property (strong, nonatomic) NSString *idStr;
@property (assign, nonatomic) NSInteger billState;

@property (strong, nonatomic) IBOutlet UIView *lineView;


@property (strong, nonatomic) IBOutlet UILabel *zongjiLab;
@property (strong, nonatomic) IBOutlet NSString *billStateStr;
@property (strong, nonatomic) IBOutlet UIImageView *oneImg;
@property (strong, nonatomic) IBOutlet UIImageView *twoImg;
@property (strong, nonatomic) IBOutlet UIImageView *threeImg;
@property (strong, nonatomic) IBOutlet UIImageView *fourImg;
@property (strong, nonatomic) IBOutlet UIImageView *fiveImg;
@property (strong, nonatomic) IBOutlet UIImageView *sixImg;
@property (strong, nonatomic) IBOutlet UILabel *threeTitleLab;

@property (strong, nonatomic) IBOutlet UILabel *oneTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *twoTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *fourTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *fiveTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *sixTitleLab;
@property (strong, nonatomic) IBOutlet UIView *yunView;
@property (strong, nonatomic) IBOutlet UIView *sumOneView;
@property (strong, nonatomic) IBOutlet UIView *orderIdView;
@property (strong, nonatomic) IBOutlet UIView *menshiNameView;
@property (strong, nonatomic) IBOutlet UIView *orderNumView;
@property (strong, nonatomic) IBOutlet UILabel *oneDateLab;
@property (strong, nonatomic) IBOutlet UILabel *oneTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *twoDateLab;
@property (strong, nonatomic) IBOutlet UILabel *twoTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *threeDateLab;
@property (strong, nonatomic) IBOutlet UILabel *threeTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *fourDateLab;
@property (strong, nonatomic) IBOutlet UILabel *fourTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *fiveDateLab;
@property (strong, nonatomic) IBOutlet UILabel *fiveTimeLab;
@property (strong, nonatomic) IBOutlet UILabel *sixDateLab;
@property (strong, nonatomic) IBOutlet UILabel *sixTimeLab;
@property (strong, nonatomic) ProcurementOrderOnePagModel *orderModel;
@property (assign, nonatomic) NSUInteger tagNum;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@end
