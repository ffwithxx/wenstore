//
//  MemberInfoTwoVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MemberInfoTwoVC.h"
#import "BGControl.h"

@interface MemberInfoTwoVC (){
    NSDictionary *loginDict;
}


@end

@implementation MemberInfoTwoVC

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
    self.adminLab.text = [usesrDict valueForKey:@"userId"];
    self.storeNameLab.text = [NSString stringWithFormat:@"%@ %@",[usesrDict valueForKey:@"userId"],[usesrDict valueForKey:@"storeName"]];
    NSString *ipStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"ipStr"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults] valueForKey:@"appcustid"];
    self.Iplab.text = ipStr;
    if ([BGControl isNULLOfString:appcustid]) {
        self.twoView.hidden = YES;
        self.threeView.frame = CGRectMake(0, 135, kScreenSize.width, 60);
        self.threeView.frame = CGRectMake(0, 210, kScreenSize.width, 60);
    }else{
        
        self.kehuNumLab.text = appcustid;
    }
    


}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
