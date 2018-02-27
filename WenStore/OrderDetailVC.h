//
//  OrderDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface OrderDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *topview;
@property (strong, nonatomic) IBOutlet UITableView *bigTableVIew;
@property (strong, nonatomic) IBOutlet UIView *addressOne;
@property (strong, nonatomic) IBOutlet UIView *addressTwo;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *mobileLab;
@property (strong, nonatomic) IBOutlet UILabel *addressLab;
@property (strong, nonatomic) IBOutlet UITextField *jiaoField;
@property (strong, nonatomic) IBOutlet UITextField *peiField;
@property (strong, nonatomic) IBOutlet UITextField *peiTypeField;
@property (strong, nonatomic) IBOutlet UITextField *noticeField;
@property (strong, nonatomic) IBOutlet UIImageView *picImg;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *peiTypeView;

@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIButton *fourBth;
@property (strong, nonatomic) IBOutlet UIView *beiView;
@property (strong, nonatomic) IBOutlet UIView *updateImgVIew;

@property (strong, nonatomic) IBOutlet UIView *yunView;
@property (strong, nonatomic) IBOutlet UIView *allPriceView;
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UIView *peiView;

@property (strong, nonatomic) IBOutlet UIView *phoneView;
@property (strong, nonatomic) NSMutableDictionary *datadict;
@property (strong, nonatomic) NSMutableDictionary *zongdict;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *buyOrdedrCount;
@property (strong, nonatomic) IBOutlet UILabel *buyPriceLab;
@property (strong, nonatomic) IBOutlet UILabel *yunPrice;
@property (strong, nonatomic) IBOutlet UITextField *nameFile;
@property (strong, nonatomic) IBOutlet UITextField *phoneFile;
@property (strong, nonatomic)NSString *k1mf800;
@property (strong, nonatomic)NSString *typeStr;
@property (strong, nonatomic)NSString *idStr;
@property (strong, nonatomic) IBOutlet UITextView *addressFile;
@property (strong, nonatomic) IBOutlet UIImageView *pushImg;
@property (strong, nonatomic) IBOutlet UIView *fgView;
@property (strong, nonatomic) IBOutlet UIView *xiaView;
@property (strong, nonatomic) IBOutlet UILabel *zongjiOneLab;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollView;
@property (strong, nonatomic) IBOutlet UIButton *HeadImg;

@property (strong, nonatomic) NSArray *adreessArr;
@property (strong, nonatomic) NSArray *phoneArr;
@property (strong, nonatomic) NSArray *nameArr;
@property (strong, nonatomic) IBOutlet UIView *AddressView;
@end
