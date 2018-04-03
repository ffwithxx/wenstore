//
//  PayViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface PayViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *priceLab;

@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UIImageView *oneImg;

@property (strong, nonatomic) IBOutlet UIImageView *twoImg;
@property (strong, nonatomic) IBOutlet UIImageView *threeImg;
@property (strong, nonatomic) NSString *fanStr;
@property (strong, nonatomic) NSString *k1mf100;
@property (strong, nonatomic) NSDecimalNumber *sumPrice;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;



@end
