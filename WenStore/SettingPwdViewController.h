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

@end
