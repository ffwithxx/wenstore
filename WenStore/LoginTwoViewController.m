//
//  LoginTwoViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "LoginTwoViewController.h"
#import "LoginoneViewController.h"
#import "AFClient.h"
#import "BGControl.h"

@interface LoginTwoViewController ()<UITextFieldDelegate> {
  NSMutableArray *postArr;
}

@end

@implementation LoginTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
     postArr = [NSMutableArray new];
    [self first];
    // Do any additional setup after loading the view.
}

-(void)first {
    self.mobileText.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    self.pwdText.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    self.pwdText.secureTextEntry = YES;
    self.loginBth.clipsToBounds = YES;
    //    self.loginBth.layer.borderColor = [kTabBarColor CGColor];
    self.loginBth.layer.cornerRadius = 25.f;
    CGFloat Y =  self.pawTitleLab.frame.origin.y;
    self.tishiLab.frame = CGRectMake(20, CGRectGetMaxY(self.oneView.frame)+Y, kScreenSize.width-40, 25);
    [self.bigView addSubview:self.tishiLab];
    self.loginBth.frame = CGRectMake(20, CGRectGetMaxY(self.oneView.frame)+(self.oneView.frame.size.height/2), kScreenSize.width - 40, 50);
    self.mobileText.returnKeyType =UIReturnKeyDone;
    self.pwdText.returnKeyType =UIReturnKeyDone;
    self.mobileText.delegate = self;
    self.pwdText.delegate = self;
}

- (IBAction)buttonClick:(UIButton *)sender {
    if(sender.tag == 201) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginoneViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginoneViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else if (sender.tag == 202) {
    
        if ([BGControl isNULLOfString:self.mobileText.text] ) {
            [self Alert:@"请输入账号"];
            return;
        }
        if ([BGControl isNULLOfString:self.pwdText.text] ) {
            [self Alert:@"请输入密码"];
            return;
        }
        
        
        [self setData];

    }
    
}

- (void)setData {
   // [self show];
//    [[AFClient shareInstance] LoginByCustId:@"c021" withAccount:@"001" withPassword:@"001" withStoreId:@"001" withArr:postArr  progressBlock:^(NSProgress *progress) {
//
//    } success:^(id responseBody) {
//
//        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
//            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
//            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
//                [self dismiss];
//                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"token"]] forKey:@"token"];
//                [[NSUserDefaults standardUserDefaults] setValue:self.mobileText.text forKey:@"account"];
//                [[NSUserDefaults standardUserDefaults] setValue:self.pwdText.text forKey:@"password"];
//                NSError *error;
//                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[responseBody valueForKey:@"data"] options:0 error:&error];
//                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
//
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"Main" object:nil];
//                
//            }else {
//                [self dismiss];
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
//                if ([[userResponseDict valueForKey:@"code"] intValue]== 1) {
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                    }];
//                    [alertController addAction:cancelAction];
//                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
//                        [self setData];
//                        ;
//                    }];
//                    [alertController addAction:confirmAction];
//
//                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
//                    NSArray *options = [userResponseDict valueForKey:@"options" ];
//                    for (int i = 0; i < options.count; i++) {
//                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                            [postArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
//                            [self setData];
//                            
//                            ;
//                        }];
//                        [alertController addAction:home1Action];
//                    }
//                    //取消style:UIAlertActionStyleDefault
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
//                }
//                //添加取消到UIAlertController中
//
//                [self presentViewController:alertController animated:YES completion:nil];
//                
//
//            }
//        }else {
//            NSString *str = [responseBody valueForKey:@"errors"][0];
//            self.tishiLab.text = str;
//
//        }
//        [self dismiss];
//    } failure:^(NSError *error) {
//        [self dismiss];
//    }];
//
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  [self.mobileText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.mobileText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
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
