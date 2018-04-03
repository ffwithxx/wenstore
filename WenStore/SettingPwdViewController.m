//
//  SettingPwdViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "SettingPwdViewController.h"
#import "BGControl.h"
#import "AFClient.h"

@interface SettingPwdViewController ()

@end

@implementation SettingPwdViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    self.oldPwd.secureTextEntry = YES;
    self.nowPwd.secureTextEntry = YES;
     self.againPwd.secureTextEntry = YES;
    // Do any additional setup after loading the view.
}
- (void)isIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        self.leftImg.frame = CGRectMake(15, 52, 24, 16);
        self.rightIMG.frame = CGRectMake(kScreenSize.width-75, 53, 20, 13);
        self.saveBth.frame = CGRectMake(kScreenSize.width-55, 34, 40, 50);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if ([BGControl isNULLOfString:self.oldPwd.text]) {
            [self Alert:@"请输入原先密码！"];
        }else if ([BGControl isNULLOfString:self.nowPwd.text]) {
              [self Alert:@"请输入新密码！"];
        }else if ([BGControl isNULLOfString:self.againPwd.text]) {
            [self Alert:@"请再次输入新密码！"];
        }else{
            
           // account
            NSString *storeid = [[NSUserDefaults standardUserDefaults] valueForKey:@"storeId"];
            NSString *account = [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
            NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:self.oldPwd.text,@"auth003",self.nowPwd.text,@"newAuth003",storeid,@"storeid",account,@"auth001", nil];
            [self show];
            [[AFClient shareInstance] UpdatePasswordwithUrl:@"App/Setting/UpdatePassword" withDict:dict progressBlock:^(NSProgress *progress) {
                
            } success:^(id responseBody) {
                if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                    [self Alert:@"密码修改成功"];
                    [self.navigationController popViewControllerAnimated:YES];
                }else{
                    [self Alert:@"密码修改失败"];
                    
                }
                [self dismiss];
            } failure:^(NSError *error) {
                 [self dismiss];
                 [self Alert:@"密码修改失败"];
            }];
            
        }
    }
}
//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.oldPwd resignFirstResponder];
    [self.nowPwd resignFirstResponder];
    [self.againPwd resignFirstResponder];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
