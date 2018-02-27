//
//  MainViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/9.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "MainViewController.h"


@interface MainViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UIScrollView *bigScrollview;
@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIImageView *oneViewImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UIView *twoView;
@property (strong, nonatomic) IBOutlet UIView *threeView;
@property (strong, nonatomic) IBOutlet UIView *fourView;
@property (strong, nonatomic) IBOutlet UIView *fiveView;
@property (strong, nonatomic) IBOutlet UILabel *CountLab;
@property (strong, nonatomic) IBOutlet UIScrollView *infoScrollview;
@property (strong, nonatomic) IBOutlet UIButton *detailBth;

@end
