//
//  MemberInfoViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MemberInfoViewController.h"
#import "AppDelegate.h"
#import "LoginoneViewController.h"
#import "MainViewController.h"
#import "BGControl.h"
// 取得AppDelegate单利
#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface MemberInfoViewController () {
NSDictionary *loginDict;
}

@end

@implementation MemberInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    [self first];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationItem.title = @"账户详情";
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:17],NSForegroundColorAttributeName:[UIColor whiteColor]}];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.hidden = NO;
    
    
}
- (void)isIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
    }
}
-(void)first {
   
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    loginDict = [BGControl dictionaryWithJsonString:jsonString];
    NSDictionary *usesrDict = [loginDict valueForKey:@"user"];
      self.mobileLab.text = [usesrDict valueForKey:@"userId"];
}


// 即将出去后再打开 因为可能其他页面需要抽屉效果
- (void)viewWillDisappear:(BOOL)animated
{
//    [super viewWillDisappear:animated];
//    [self enableOpenLeftDrawer:YES];
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {

    [self.navigationController popViewControllerAnimated:YES];
//    UINavigationController *centerNav = [[UINavigationController alloc] initWithRootViewController:[[MainViewController alloc] init]];
//    [ShareApp.drawerController setCenterViewController:centerNav withCloseAnimation:YES completion:nil];
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
