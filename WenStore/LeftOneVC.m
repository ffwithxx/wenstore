//
//  LeftOneVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "LeftOneVC.h"
#import "AppDelegate.h"
#import "MemberInfoViewController.h"
#import "MainViewController.h"
#import "MemberInfoTwoVC.h"
#import "BGControl.h"
#import "AFClient.h"
#import "SettingPwdViewController.h"
// 取得AppDelegate单利
#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])

@interface LeftOneVC ()<UIAlertViewDelegate>{
    NSDictionary *loginDict;
    NSMutableArray *postArr;
    NSString *isPasswordChangable;
}

@end

@implementation LeftOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    isPasswordChangable = [[NSUserDefaults standardUserDefaults]valueForKey:@"isPasswordChangable"];
    postArr = [NSMutableArray array];
   loginDict = [BGControl dictionaryWithJsonString:jsonString];
    NSDictionary *usesrDict = [loginDict valueForKey:@"user"];
    self.adminLab.text = [usesrDict valueForKey:@"userId"];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonClick:(UIButton *)sender {
  UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
   
        MemberInfoViewController *infoVC = [storyboard instantiateViewControllerWithIdentifier:@"MemberInfoViewController"];
         MemberInfoTwoVC *infoTwo = [storyboard instantiateViewControllerWithIdentifier:@"MemberInfoTwoVC"];
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
     
        [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
    if (sender.tag == 201) {
        NSString *loginType = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginType"];
        if ([loginType isEqualToString:@"admin"]) {
             [tempAppDelegate.mainNavigationController pushViewController:infoTwo animated:NO];
        }
       
//         [tempAppDelegate.mainNavigationController pushViewController:infoTwo animated:NO];
    }else if (sender.tag == 202) {
        if ([isPasswordChangable isEqualToString:@"1"]) {
            //修改密码
            SettingPwdViewController *PwdVC = [storyboard instantiateViewControllerWithIdentifier:@"SettingPwdViewController"];
            AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
            [tempAppDelegate.LeftSlideVC closeLeftView];//关闭左侧抽屉
            [tempAppDelegate.mainNavigationController pushViewController:PwdVC animated:NO];
            
        }else{
           [self Alert:@"没有修改密码权限!"];
            
        }
   
    }else if (sender.tag == 203) {
    //版本更新
    }else if (sender.tag == 204) {
    //代办事项
    }else if (sender.tag == 205) {
    //中文简体
    }else if (sender.tag == 206) {
    //退出登录-
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"您正在进行退出登录操作，是否继续此操作" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        alert.delegate = self;
        [alert show];
       //
    }
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
       [self loginOut];
    }
}
-(void)loginOut{
    [[AFClient shareInstance] loginOutwith:postArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                  [[NSUserDefaults standardUserDefaults] setObject:@"" forKey:@"cook"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"tLogin" object:nil];
            }else{
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self loginOut];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self loginOut];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                }
                //添加取消到UIAlertController中
                
                [self presentViewController:alertController animated:YES completion:nil];
  
            }
        }else {
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
        }
    } failure:^(NSError *error) {
        
    }];

}
- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
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
