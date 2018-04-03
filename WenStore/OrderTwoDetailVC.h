//
//  OrderTwoDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "orderModel.h"
@interface OrderTwoDetailVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *footerView;

@property (strong, nonatomic) IBOutlet UIView *bottomview;
@property (strong, nonatomic) IBOutlet UITableView *bigTableVIew;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIButton *sumbitBth;
@property (strong, nonatomic) IBOutlet UIButton *oneMoreBth;

@property (strong, nonatomic) IBOutlet UILabel *addressFile;
@property (strong, nonatomic) IBOutlet UILabel *phoneFile;
@property (strong, nonatomic) IBOutlet UILabel *nameFile;
@property (strong, nonatomic) IBOutlet UITextField *jiaoDateFile;
@property (strong, nonatomic) IBOutlet UITextField *peiDateFile;
@property (strong, nonatomic) IBOutlet UILabel *peiType;
@property (strong, nonatomic) IBOutlet UILabel *beizhuFile;
@property (strong, nonatomic) IBOutlet UILabel *idLab;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *yunLab;
@property (strong, nonatomic) IBOutlet UILabel *zongLab;
@property (strong, nonatomic) IBOutlet UILabel *xiadanName;
@property (strong, nonatomic) IBOutlet UILabel *storeName;
@property (strong, nonatomic) IBOutlet UILabel *storeId;
@property (strong, nonatomic) IBOutlet UIImageView *jiImgView;

@property (strong, nonatomic) IBOutlet UIView *topViewOne;
@property (strong, nonatomic) NSString *fanStr;
@property (strong, nonatomic) NSString *idStr;
@property (assign, nonatomic) NSInteger billState;
@property (assign, nonatomic) NSInteger tag;//点击的是哪个按钮
@property (strong, nonatomic) IBOutlet UIView *addressView;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UILabel *beiTitle;
@property (strong, nonatomic) IBOutlet UIView *beiView;
@property (strong, nonatomic) IBOutlet UIView *zhuanView;
@property (strong, nonatomic) IBOutlet UILabel *zongjiLab;
@property (strong, nonatomic) IBOutlet NSString *billStateStr;
@property (strong, nonatomic) IBOutlet UIImageView *oneImg;
@property (strong, nonatomic) IBOutlet UIImageView *twoImg;
@property (strong, nonatomic) IBOutlet UIImageView *threeImg;
@property (strong, nonatomic) IBOutlet UIImageView *fourImg;
@property (strong, nonatomic) IBOutlet UIImageView *fiveImg;
@property (strong, nonatomic) IBOutlet UIImageView *sixImg;
@property (strong, nonatomic) IBOutlet UIImageView *sevenImg;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIView *yunView;
@property (strong, nonatomic) IBOutlet UIView *allPriceView;
@property (strong, nonatomic) IBOutlet UIView *xiadanView;
@property (strong, nonatomic) IBOutlet UIView *menNameView;
@property (strong, nonatomic) IBOutlet UIView *menNumView;
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) IBOutlet UIView *peiView;

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
@property (strong, nonatomic) IBOutlet UILabel *sevenDateLab;
@property (strong, nonatomic) IBOutlet UILabel *sevenTimeLab;
@property (strong, nonatomic) orderModel *orderModel;
@property (strong, nonatomic) NSMutableDictionary *myDict;
@property (assign, nonatomic) BOOL isji;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;


@end
