//
//  AppDelegate.m
//  WenStore
//
//  Created by 冯丽 on 17/7/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginoneViewController.h"
#import "MainViewController.h"
#import "LeftOneVC.h"
#import "BaiduMobStat.h"
#import "BGControl.h"
#import "SVProgressHUD.h"
#import "AFClient.h"

@interface AppDelegate () {
    BOOL isShow;
     NSMutableArray *postArr;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:2.0];
    isShow = YES;
    postArr = [[NSMutableArray alloc] init];
    [[UITextField appearance] setTintColor:kTabBarColor];
    [[UITextView appearance] setTintColor:kTabBarColor];
   [[BaiduMobStat defaultStat] startWithAppId:@"92f6c59983"];
    NSArray *languages = [NSLocale preferredLanguages];
    
    NSString *language = [languages objectAtIndex:0];
    
    if ([language hasPrefix:@"zh-Hans"]) {//开头匹配
        
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hans" forKey:@"appLanguage"];
        
    }else{
        
        [[NSUserDefaults standardUserDefaults] setObject:@"zh-Hant" forKey:@"appLanguage"];
        
    }

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaoOne) name: @"Main" object: nil];
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    self.window.rootViewController = [[UIViewController alloc]init];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(login) name: @"tLogin" object: nil];
    [self tiaoLogin];
    UIViewController * ctrl = (UIViewController *)[storyboard instantiateInitialViewController];
//    LoginoneViewController *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginoneViewController"];
//    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
//    self.window.rootViewController = loginNav;
//    MainViewController *mainVC =[storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
//    UINavigationController *mainNav = [[UINavigationController alloc] initWithRootViewController:mainVC];
//    LeftOneVC  *leftVC =[storyboard instantiateViewControllerWithIdentifier:@"LeftOneVC"];
//    UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:leftVC];
//    self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:mainNav leftDrawerViewController:leftNav rightDrawerViewController:nil];
//    
//    [self.drawerController setShowsShadow:YES]; // 是否显示阴影效果
//    self.drawerController.maximumLeftDrawerWidth = kScreenSize.width*4/6; // 左边拉开的最大宽度
//
//    [self.drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
//    [self.drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
//    
//    self.window.rootViewController = self.drawerController;
    
    
    
    [self.window makeKeyAndVisible];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loginPage:) name:@"tMain" object:nil];
    return YES;
}

-(void)tiaoLogin{
    NSString *loginIP = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginIp"];
    if ([BGControl isNULLOfString:loginIP]) {
//        self.ipLabel.text = @"http://wpap1test.winton.com.tw";
        [self CheckHostStatusWithIPstr:@"http://wpap1test.winton.com.tw"];
    }else{
       
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

- (void)CheckHostStatusWithIPstr:(NSString *)urlStr {
    NSString *url = [NSString stringWithFormat:@"%@%@",urlStr,@"/App/System/CheckHostStatus"];
    [self show];
    [[AFClient shareInstance] CheckHostStatuswithUrl:url progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] intValue] == 200) {
            NSLog(@"%@",responseBody);
            
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"loginUrl"]] forKey:@"loginUrl"];
            [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"logOutUrl"]] forKey:@"logOutUrl"];
            
            [[NSUserDefaults standardUserDefaults] setValue:urlStr forKey:@"loginIp"];
             [self setDataWithUrl:[[responseBody valueForKey:@"data"] valueForKey:@"loginUrl"]];
            if ([[[responseBody valueForKey:@"data"] valueForKey:@"isDisplayCustId"] integerValue] == 0) {
              
                isShow = NO;
            }
            
        }else{
            [self login];
        }
        [self dismiss];
    } failure:^(NSError *error) {
       [self login];
        
        [self dismiss];
    }];
    
}

- (void)setDataWithUrl:(NSString *)urlStr {
    NSString *admindText=[[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
    NSString *pwdText=[[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
    NSString *kehuNum = [[NSUserDefaults standardUserDefaults] valueForKey:@"appcustid"];
    NSString *menshiNum =[[NSUserDefaults standardUserDefaults] valueForKey:@"storeId"];
    [self show];

    [[AFClient shareInstance] LoginByCustId:kehuNum withUrl:urlStr withAccount:admindText withPassword:pwdText withStoreId:menshiNum isShow:isShow withArr:postArr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"token"]] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"isPasswordChangable"]] forKey:@"isPasswordChangable"];
                //                NSString *cookieStr = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"];
                //                [[NSUserDefaults standardUserDefaults] setObject:cookieStr forKey:@"cook"];
                [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"token"]] forKey:@"token"];
                [[NSUserDefaults standardUserDefaults] setValue:kehuNum forKey:@"appcustid"];
                [[NSUserDefaults standardUserDefaults] setValue:admindText forKey:@"account"];
                [[NSUserDefaults standardUserDefaults] setValue:pwdText forKey:@"password"];
                [[NSUserDefaults standardUserDefaults] setValue:menshiNum forKey:@"storeId"];
                
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
                [self login];
            }
        }else {
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self login];
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
       [self login];
        [self dismiss];
    }];
    
}

- (void)login{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaoLogin) name: @"tLogin" object: nil];
    LoginoneViewController *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginoneViewController"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.window.rootViewController = loginNav;
}
- (void)tiaoOne {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    MainViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
    self.mainNavigationController = [[UINavigationController alloc] initWithRootViewController:mainVC];
    LeftOneVC *leftVC = [storyboard instantiateViewControllerWithIdentifier:@"LeftOneVC"];
    self.LeftSlideVC = [[LeftSlideViewController alloc] initWithLeftView:leftVC andMainView:self.mainNavigationController];
    self.window.rootViewController = self.LeftSlideVC;

}
-(void)show {
    [SVProgressHUD setBackgroundColor:kTextGrayColor];
    [SVProgressHUD setForegroundColor:[UIColor whiteColor]];
    [SVProgressHUD showWithStatus:@"加载中..." maskType:SVProgressHUDMaskTypeNone];
    
}
- (void)dismiss
{
    [SVProgressHUD dismiss];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
