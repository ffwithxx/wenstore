//
//  DistributionTableVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/8.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface DistributionTableVC : BaseViewController
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *typeView;
@property (strong, nonatomic) IBOutlet UITextField *typeField;
@property (strong, nonatomic) IBOutlet UIImageView *typeAddImg;
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollview;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UITextField *nameField;

@property (strong, nonatomic) IBOutlet UIButton *subMitBth;

@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIView *beginView;
@property (strong, nonatomic) IBOutlet UIView *endView;
@property (strong, nonatomic) IBOutlet UIView *fourView;
@property (strong, nonatomic) IBOutlet UIView *dataView;
@property (strong, nonatomic) IBOutlet UITextField *dataField;
@end
