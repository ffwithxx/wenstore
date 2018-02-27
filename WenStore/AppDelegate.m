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

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [NSThread sleepForTimeInterval:2.0];
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
      [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tiaoLogin) name: @"tLogin" object: nil];
    UIViewController * ctrl = (UIViewController *)[storyboard instantiateInitialViewController];
    LoginoneViewController *logVC =[storyboard instantiateViewControllerWithIdentifier:@"LoginoneViewController"];
    UINavigationController *loginNav = [[UINavigationController alloc] initWithRootViewController:logVC];
    self.window.rootViewController = loginNav;
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
