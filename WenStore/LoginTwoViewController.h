//
//  LoginTwoViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface LoginTwoViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *mobileText;
@property (strong, nonatomic) IBOutlet UITextField *pwdText;
@property (strong, nonatomic) IBOutlet UIButton *loginBth;
@property (strong, nonatomic) IBOutlet UILabel *tishiLab;
@property (strong, nonatomic) IBOutlet UILabel *pawTitleLab;

@property (strong, nonatomic) IBOutlet UIView *oneView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@end
