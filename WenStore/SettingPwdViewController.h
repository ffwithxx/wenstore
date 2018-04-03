//
//  SettingPwdViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface SettingPwdViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *oldPwd;
@property (strong, nonatomic) IBOutlet UITextField *nowPwd;
@property (strong, nonatomic) IBOutlet UITextField *againPwd;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *rightIMG;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *saveBth;
@property (strong, nonatomic) IBOutlet UIView *bigView;

@end
