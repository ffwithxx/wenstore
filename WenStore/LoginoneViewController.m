//
//  LoginoneViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/8.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "LoginoneViewController.h"
#import "IP.h"
#import "LoginTwoViewController.h"
#import "BGControl.h"
#import "AFClient.h"

@interface LoginoneViewController ()<UITextFieldDelegate> {
    IP *ipView;
    NSMutableArray *postArr;
    NSString *ipStr;
    BOOL isShow;
    BOOL isSecrets;
}

@end

@implementation LoginoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isShow = YES;
    isSecrets = YES;
    
    postArr = [NSMutableArray new];
    self.loginBth.frame = CGRectMake(20, CGRectGetMaxY(self.tishiLab.frame)+20, kScreenSize.width-40, 50);
    [self first];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
//    [super viewWillAppear:animated];
//
//    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
//    self.navigationController.navigationBar.hidden = NO;
    
}
- (IBAction)click:(UIButton *)sender {
    NSLog(@"123");
}

-(void)first {
    self.admindText.keyboardType = UIKeyboardTypeASCIICapable;
    self.pwdText.keyboardType = UIKeyboardTypeASCIICapable;
    self.kehuNum.keyboardType = UIKeyboardTypeASCIICapable;
    self.menshiNum.keyboardType = UIKeyboardTypeASCIICapable;
    self.loginBth.clipsToBounds = YES;
    //    self.loginBth.layer.borderColor = [kTabBarColor CGColor];
    self.loginBth.layer.cornerRadius = 25.f;
    
    CGFloat Y =  self.pawTitleLab.frame.origin.y;
    self.tishiLab.frame = CGRectMake(20, CGRectGetMaxY(self.fourView.frame)+Y, kScreenSize.width-40, 25);
    [self.bigView addSubview:self.tishiLab];
    self.loginBth.frame = CGRectMake(20, CGRectGetMaxY(self.fourView.frame)+(self.fourView.frame.size.height/4), kScreenSize.width - 40, 50);
    self.admindText.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    self.pwdText.text=[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    self.kehuNum.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"appcustid"];
    self.menshiNum.text =[[NSUserDefaults standardUserDefaults] valueForKey:@"storeId"];

    self.pwdText.secureTextEntry = YES;
    self.admindText.returnKeyType =UIReturnKeyDone;
     self.pwdText.returnKeyType =UIReturnKeyDone;
     self.kehuNum.returnKeyType =UIReturnKeyDone;
     self.menshiNum.returnKeyType =UIReturnKeyDone;
    self.admindText.delegate =self;
    self.pwdText.delegate =self;
    self.kehuNum.delegate =self;
    self.menshiNum.delegate =self;
    NSString *loginIP = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginIp"];
    if ([BGControl isNULLOfString:loginIP]) {
         self.ipLabel.text = @"http://wpap1test.winton.com.tw";
         [self CheckHostStatusWithIPstr:@"http://wpap1test.winton.com.tw"];
    }else{
        self.twoView.hidden = YES;
        self.oneView.hidden = NO;
        self.ipLabel.text = loginIP;
        NSString *string = [loginIP substringToIndex:6];
        NSString *httpstring = [loginIP substringToIndex:5];
        NSString *  oneipStr;
        if ([string isEqualToString:@"https:"] || [string isEqualToString:@"HTTPS:"]|| [httpstring isEqualToString:@"HTTP:"]|| [httpstring isEqualToString:@"http:"]) {
           oneipStr = [NSString  stringWithFormat:@"%@",loginIP];
        }else{
            
            oneipStr = [NSString  stringWithFormat:@"%@%@",@"https://",loginIP];
        }
       
         [self CheckHostStatusWithIPstr:oneipStr];
        
    }
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.admindText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    if (sender.tag == 201 ) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"IP" owner:self options:nil];
        self.blackButton.hidden = NO;
        ipView = [nib firstObject];
        ipView.clipsToBounds = YES;
        CGRect ipRect = ipView.frame;
        ipRect.size.width = kScreenSize.width - 40;
        [ipView setFrame:ipRect];
        ipView.sybmitBth.clipsToBounds = YES;
        ipView.sybmitBth.layer.cornerRadius = 5.f;
        ipView.center = self.view.center;
        ipView.ipLabel.clipsToBounds = YES;
        ipView.ipLabel.layer.borderColor = [kTabBarColor CGColor];
        ipView.ipLabel.layer.cornerRadius = 5.f;
        ipView.ipLabel.layer.borderWidth = 2.f;
        
        [self.view addSubview:ipView];
        ipView.getIpBlock = ^(NSArray *arr){
            if ([arr[0] isEqualToString:@"hiddle"] && [self.ipLabel.text isEqualToString:@""]) {
                self.twoView.hidden = NO;
                self.oneView.hidden = YES;
            }else {
              
                
                if (![arr[0] isEqualToString:@"hiddle"] &&![BGControl isNULLOfString:arr[0]]) {
                    self.ipLabel.text = arr[0];
                    self.twoView.hidden = YES;
                    self.oneView.hidden = NO;
                    if (self.ipLabel.text.length <6) {
                        [self Alert:@"IP地址无效，请重新设置！"];
                        return ;
                    }
                    NSString *string = [self.ipLabel.text substringToIndex:6];
                    NSString *httpstring = [self.ipLabel.text substringToIndex:5];
                    if ([string isEqualToString:@"https:"] || [string isEqualToString:@"HTTPS:"]|| [httpstring isEqualToString:@"HTTP:"]|| [httpstring isEqualToString:@"http:"]) {
                        ipStr = [NSString  stringWithFormat:@"%@",self.ipLabel.text];
                    }else{
                        
                        ipStr = [NSString  stringWithFormat:@"%@%@",@"https://",self.ipLabel.text];
                    }
                
                      [self CheckHostStatusWithIPstr:ipStr];
                    
                }
            }
            [self hiddleAllViews];
        };
        
    }else if(sender.tag == 202) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginTwoViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginTwoViewController"];
        [self.navigationController pushViewController:loginVC animated:YES];
        
    }else if (sender.tag == 204) {
        
        if ([BGControl isNULLOfString:self.admindText.text] ) {
            [self Alert:@"请输入账号"];
            return;
        }
        if ([BGControl isNULLOfString:self.kehuNum.text] ) {
            [self Alert:@"请输入客户代号"];
            return;
        }
        if ([BGControl isNULLOfString:self.menshiNum.text] ) {
            [self Alert:@"请输入门市代号"];
            return;
        }
        if ([BGControl isNULLOfString:self.pwdText.text] ) {
            [self Alert:@"请输入密码"];
            return;
        }
        NSString *url = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginUrl"];
        [self setDataWithUrl:url];
       
    }
}

- (void)CheckHostStatusWithIPstr:(NSString *)urlStr {
    NSString *url = [NSString stringWithFormat:@"%@%@",urlStr,@"/App/System/CheckHostStatus"];
    [self show];
    [[AFClient shareInstance] CheckHostStatuswithUrl:url progressBlock:^(NSProgress *progress) {
       
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] intValue] == 200) {
            NSLog(@"%@",responseBody);
          
              [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"loginUrl"]] forKey:@"loginUrl"];
                  [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"logOutUrl"]] forKey:@"logOutUrl"];
                  [[NSUserDefaults standardUserDefaults] setValue:self.ipLabel.text forKey:@"ipStr"];
            [[NSUserDefaults standardUserDefaults] setValue:urlStr forKey:@"loginIp"];
            if ([[[responseBody valueForKey:@"data"] valueForKey:@"isDisplayCustId"] integerValue] == 0) {
                [self setView];
                isShow = NO;
            }
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
        [self Alert:@"IP设置失败"];
        NSString *loginIP = [[NSUserDefaults standardUserDefaults] valueForKey:@"ipStr"];
        if ([BGControl isNULLOfString:loginIP]) {
            self.ipLabel.text = @"http://wpap1test.winton.com.tw";
            
        }else{
           
            self.ipLabel.text = loginIP;
        }
        [self dismiss];
    }];
    
}
-(void)setView{
    CGFloat oneHei = CGRectGetHeight(self.adminView.frame);
    CGRect fourViewFrame = self.fourView.frame;
    fourViewFrame.size.height = oneHei*3;
    [self.fourView setFrame:fourViewFrame];
    CGRect tishiFrame = self.tishiLab.frame;
    tishiFrame.origin.y = CGRectGetMaxY(self.fourView.frame)+10;
    [self.tishiLab setFrame:tishiFrame];
    CGRect bthFrame = self.loginBth.frame;
    bthFrame.origin.y = CGRectGetMaxY(self.tishiLab.frame)+5;
    [self.loginBth setFrame:bthFrame];
    self.kehuView.hidden = YES;
    CGRect menshiFrame = self.menshiView.frame;
    menshiFrame.origin.y = 0;
    [self.menshiView setFrame:menshiFrame];
    CGRect adminFrame = self.adminView.frame;
    adminFrame.origin.y = oneHei;
    [self.adminView setFrame:adminFrame];
    CGRect pwtFrame = self.pwdView.frame;
    pwtFrame.origin.y = oneHei*2;
    [self.pwdView setFrame:pwtFrame];
}
- (void)setDataWithUrl:(NSString *)urlStr {
    [self show];
    [[AFClient shareInstance] LoginByCustId:self.kehuNum.text withUrl:urlStr withAccount:self.admindText.text withPassword:self.pwdText.text withStoreId:self.menshiNum.text isShow:isShow withArr:postArr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"token"]] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"isPasswordChangable"]] forKey:@"isPasswordChangable"];
//                NSString *cookieStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"];
//                [[NSUserDefaults standardUserDefaults] setObject:cookieStr forKey:@"cook"];
                 [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"token"]] forKey:@"token"];
                 [[NSUserDefaults standardUserDefaults] setValue:self.kehuNum.text forKey:@"appcustid"];
                  [[NSUserDefaults standardUserDefaults] setValue:self.admindText.text forKey:@"account"];
                 [[NSUserDefaults standardUserDefaults] setValue:self.pwdText.text forKey:@"password"];
                  [[NSUserDefaults standardUserDefaults] setValue:self.menshiNum.text forKey:@"storeId"];
                
                [[NSUserDefaults standardUserDefaults] setValue:@"admin" forKey:@"loginType"];
                  [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"fileCenterUrl"]] forKey:@"fileCenterUrl"];
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:[responseBody valueForKey:@"data"] options:0 error:&error];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [[NSUserDefaults standardUserDefaults] setValue:jsonString forKey:@"loginData"];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"Main" object:nil];
                
                
                [self dismiss];
                
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue] == 1) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self setDataWithUrl:urlStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue] == 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self setDataWithUrl:urlStr];
                            
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
            self.tishiLab.text = str;
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
        [self Alert:@"登录失败，请重试！"];
        [self dismiss];
    }];
    
}

-(void)blackButtonClick {
    [self hiddleAllViews];
}
- (void)hiddleAllViews{
    __block LoginoneViewController *oneView = self;
    __block IP *ipViewone = ipView;
    [ipViewone.ipText resignFirstResponder];
    [ipViewone removeFromSuperview];
    self.blackButton.hidden = YES;
}

//点击屏幕空白处去掉键盘
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{  [self.admindText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    [self.menshiNum resignFirstResponder];
    [self.kehuNum resignFirstResponder];
    __block IP *ipViewone = ipView;
    [ipViewone.ipText resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.bigView.frame = frame;
    }];
    
}
-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [self.admindText resignFirstResponder];
    [self.pwdText resignFirstResponder];
    [self.kehuNum resignFirstResponder];
    [self.menshiNum resignFirstResponder];
    [UIView animateWithDuration:0.3 animations:^{
        CGRect frame = self.view.frame;
        frame.origin.y = 0;
        self.bigView.frame = frame;
    }];
    return YES;
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}


- (IBAction)secretsClick:(UIButton *)sender {
    if (isSecrets) {
        self.pwdText.secureTextEntry = NO;
        self.secrecyImgView.image = [UIImage imageNamed:@"psw.png"];
        isSecrets = NO;
    }else {
        self.pwdText.secureTextEntry = YES;
         self.secrecyImgView.image = [UIImage imageNamed:@"secrecy.png"];
       
        isSecrets = YES;
        
    }
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    //216
    CGFloat offset = self.bigView.frame.size.height - (280+self.fourView.frame.origin.y+self.fourView.frame.size.height );
    if (offset<=0) {
        [UIView animateWithDuration:0.3 animations:^{
            CGRect frame = self.bigView.frame;
            frame.origin.y = offset;
            self.bigView.frame = frame;
        }];
    }
    return YES;
}
- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    
    return YES;
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
