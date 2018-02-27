//
//  AsideDetailVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface AsideDetailVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *footerView;
@property (strong, nonatomic) IBOutlet UITextField *bochuDate;
@property (strong, nonatomic) IBOutlet UITextField *storeField;

@property (strong, nonatomic) IBOutlet UITextField *remarkField;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceOne;

@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *k1mf107;
@property (strong, nonatomic) NSString *k1mf101;
@property (strong, nonatomic) NSArray *detpsArr;
@end
