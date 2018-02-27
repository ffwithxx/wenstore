//
//  BaseViewController.m
//  Blossoms
//
//  Created by chenghong_mac on 15/11/25.
//  Copyright © 2015年 FL. All rights reserved.
//

#import "BaseViewController.h"

#import "BGControl.h"
#import "SVProgressHUD.h"
//#import "UserModel.h"
//#import "JPUSHService.h"
//#import "GiFHUD.h"
//#import "AFClient.h"
#import "AppDelegate.h"
#import "MainViewController.h"
// 取得AppDelegate单利
#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface BaseViewController () {
    NSMutableArray *_messageContents;
    int _messageCount;
    int _notificationCount;
}
@property (nonatomic,strong) UIImageView *IMGView;
@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated{
    //self.tabBarController.tabBar.hidden = NO;
   
    self.navigationController.navigationBar.hidden = YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.hidden = YES;
    [self JPushObserver];
    [self setNavTitle];
    [self creatBlackButton];
//     [self isxiugaiMiMa];
    
//    [GiFHUD setGifWithImageName:@"loading.gif"];
}
#pragma mark -- 创建黑色button
- (void)creatBlackButton{
    self.blackButton = [BGControl creatButtonWithFrame:self.view.frame target:self sel:@selector(blackButtonClick) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
    self.blackButton.backgroundColor = [UIColor blackColor];
    self.blackButton.alpha = 0.3f;
    self.blackButton.hidden = YES;
    [self.view addSubview:self.blackButton];

}

- (void)blackButtonClick {
    self.blackButton.hidden = YES;
}
- (void)pushNewViewController:(UIViewController *)newViewController {
    [self.navigationController pushViewController:newViewController animated:YES];
}
- (void)enableOpenLeftDrawer:(BOOL)enable
{
//    if (enable == YES) {
//        // 能够打开
//        UINavigationController *leftNav = [[UINavigationController alloc] initWithRootViewController:[[LeftViewController alloc] init]];
//    
//        [ShareApp.drawerController setLeftDrawerViewController:leftNav];
//    } else {
//        // 不能打开抽屉
//        [ShareApp.drawerController closeDrawerAnimated:YES completion:^(BOOL finished) {
//            [ShareApp.drawerController setLeftDrawerViewController:nil];
//        }];
//    }
}





- (void)showLoading{
    self.loadingView.alpha = 0.3;
//    [GiFHUD show];
}

- (void)hiddenLoading{
    self.loadingView.alpha = 0;
//    [GiFHUD dismiss];
  
    
}

#pragma mark - 极光监听

- (void)JPushObserver{
//    _messageCount = 0;
//    _notificationCount = 0;
//    _messageContents = [[NSMutableArray alloc] initWithCapacity:6];
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidSetup:)
//                          name:kJPFNetworkDidSetupNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidClose:)
//                          name:kJPFNetworkDidCloseNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidRegister:)
//                          name:kJPFNetworkDidRegisterNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidLogin:)
//                          name:kJPFNetworkDidLoginNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(networkDidReceiveMessage:)
//                          name:kJPFNetworkDidReceiveMessageNotification
//                        object:nil];
//    [defaultCenter addObserver:self
//                      selector:@selector(serviceError:)
//                          name:kJPFServiceErrorNotification
//                        object:nil];
//    
//    // Do any additional setup after loading the view from its nib.
//}
//
//- (void)dealloc {
//    [self unObserveAllNotifications];
//}
//- (void)unObserveAllNotifications {
//    NSNotificationCenter *defaultCenter = [NSNotificationCenter defaultCenter];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidSetupNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidCloseNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidRegisterNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidLoginNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFNetworkDidReceiveMessageNotification
//                           object:nil];
//    [defaultCenter removeObserver:self
//                             name:kJPFServiceErrorNotification
//                           object:nil];
}

- (void)networkDidSetup:(NSNotification *)notification {
    NSLog(@"已连接");
}

- (void)networkDidClose:(NSNotification *)notification {
    NSLog(@"未连接");
}

- (void)networkDidRegister:(NSNotification *)notification {
    NSLog(@"%@", [notification userInfo]);
    [[notification userInfo] valueForKey:@"RegistrationID"];

    NSLog(@"已注册");
}

- (void)networkDidLogin:(NSNotification *)notification {
    NSLog(@"已登录");
    
//    if ([JPUSHService registrationID]) {
//        NSString *jgid = [[NSUserDefaults standardUserDefaults] valueForKey:@"jgId"];
//        if (![jgid isEqualToString:[JPUSHService registrationID]]) {
//            [[NSUserDefaults standardUserDefaults] setValue:[JPUSHService registrationID] forKey:@"jgId"];
//        }else {
//        
//        }
//        
//    }
}


- (void)networkDidReceiveMessage:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *title = [userInfo valueForKey:@"title"];
    NSString *content = [userInfo valueForKey:@"content"];
    NSDictionary *extra = [userInfo valueForKey:@"extras"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    
    [dateFormatter setDateFormat:@"yyyy-MM-dd hh:mm:ss"];
    
    NSString *currentContent = [NSString
                                stringWithFormat:
                                @"收到自定义消息:%@\ntitle:%@\ncontent:%@\nextra:%@\n",
                                [NSDateFormatter localizedStringFromDate:[NSDate date]
                                                               dateStyle:NSDateFormatterNoStyle
                                                               timeStyle:NSDateFormatterMediumStyle],
                                title, content, [self logDic:extra]];
    NSLog(@"%@", currentContent);
    
    [_messageContents insertObject:currentContent atIndex:0];
    
    NSString *allContent = [NSString
                            stringWithFormat:@"%@收到消息:\n%@\nextra:%@",
                            [NSDateFormatter
                             localizedStringFromDate:[NSDate date]
                             dateStyle:NSDateFormatterNoStyle
                             timeStyle:NSDateFormatterMediumStyle],
                            [_messageContents componentsJoinedByString:nil],
                            [self logDic:extra]];
    
    _messageCount++;
    [self reloadMessageCountLabel];
}

// log NSSet with UTF8
// if not ,log will be \Uxxx
- (NSString *)logDic:(NSDictionary *)dic {
    if (![dic count]) {
        return nil;
    }
    NSString *tempStr1 =
    [[dic description] stringByReplacingOccurrencesOfString:@"\\u"
                                                 withString:@"\\U"];
    NSString *tempStr2 =
    [tempStr1 stringByReplacingOccurrencesOfString:@"\"" withString:@"\\\""];
    NSString *tempStr3 =
    [[@"\"" stringByAppendingString:tempStr2] stringByAppendingString:@"\""];
    NSData *tempData = [tempStr3 dataUsingEncoding:NSUTF8StringEncoding];
    NSString *str =
    [NSPropertyListSerialization propertyListFromData:tempData
                                     mutabilityOption:NSPropertyListImmutable
                                               format:NULL
                                     errorDescription:NULL];
    return str;
}

- (void)serviceError:(NSNotification *)notification {
    NSDictionary *userInfo = [notification userInfo];
    NSString *error = [userInfo valueForKey:@"error"];
    NSLog(@"%@", error);
}

- (void)addNotificationCount {
    _notificationCount++;
    [self reloadNotificationCountLabel];
}

- (void)addMessageCount {
    _messageCount++;
    [self reloadMessageCountLabel];
}

- (void)reloadMessageContentView {
}

- (void)reloadMessageCountLabel {
}

- (void)reloadNotificationCountLabel {
}

- (IBAction)cleanMessage:(id)sender {
    _messageCount = 0;
    _notificationCount = 0;
    [self reloadMessageCountLabel];
    [_messageContents removeAllObjects];
    [self reloadMessageContentView];
}



- (void)setNavTitle{
//    UIView *navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenSize.width, 64)];
//    navView.backgroundColor = kWhiteColor;
//    UIImageView *backImage = [[UIImageView alloc] initWithFrame:CGRectMake(15, 33, 11, 19) ];
//    backImage.image = [UIImage imageNamed:@"a_0068_ARROW-_-LEFT"];
//    [navView addSubview:backImage];
//    UIButton *backButton = [BGControl creatButtonWithFrame:CGRectMake(0, 10, 100,60) target:self sel:@selector(backButtonClick:) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];   [navView addSubview:backButton];
//    [navView addSubview:backButton];
//    
//    [self.view addSubview:navView];
    
    
    
}

-  (void)backButtonClick:(UIButton *)button {
    
    [self.navigationController popViewControllerAnimated:YES];
 }
//- (void)creatTitleText:(NSString *)text{
//    UILabel *label = [BGControl creatLabelWithFrame:CGRectMake(0, 33, kScreenSize.width, 20) text:text font:[UIFont systemFontOfSize:18] numberOfLine:1 isLayer:NO cornerRadius:0 backgroundColor:kClearColor];
//    label.textColor = kTextGrayColor;
//    label.textAlignment = NSTextAlignmentCenter;
//    
//    [self.view addSubview:label];
//}
#pragma mark --- 判断是否修改密码
- (void)isxiugaiMiMa {
//    NSString *password = [[NSUserDefaults standardUserDefaults] valueForKey:@"PSW"];
//    
//    NSString *mobileNo = [[NSUserDefaults standardUserDefaults] valueForKey:@"mobileNum"];
//    NSString *jgid = [[NSUserDefaults standardUserDefaults] valueForKey:@"jgId"];
//    if ([BGControl isNULLOfString:jgid]) {
//        jgid = @"0";
//    }
//
//    [[AFClient shareInstance] loginByMobile:mobileNo password:password  jgId:jgid success:^(id responseBody) {
//        if ([responseBody[@"code"]integerValue] == 200) {
//            NSDictionary * dict = responseBody[@"data"];
//            if (![BGControl isNULLOfString:responseBody[@"data"]]&&(![responseBody[@"data"]isEqualToString:@"<null>"])) {
//               [self getUserInfoByDictionory:dict];
//            }else {
//                [self Alert:@"数据请求失败"];
//            }
//        }else {
//            if ([responseBody[@"message"] isEqualToString:@"密码错误"]) {
//                [[NSNotificationCenter defaultCenter] postNotificationName:@"tLogin" object:nil];
//            }else {
//                [self Alert:responseBody[@"message"]];
//            }
//            
//        }
//    } failure:^(NSError *error) {
//    }];
}
- (void)getUserInfoByDictionory:(NSDictionary *)dic {
//    UserModel *model = [[UserModel alloc] init];
//    [model setValuesForKeysWithDictionary:dic];
//    NSString *fileName = [BGControl filePath:@"UserInfo.plist"];
//    NSMutableDictionary *saveDic = [[NSMutableDictionary alloc] init];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"birth" value:model.birth];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"blood_group" value:model.blood_group];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"created" value:model.created];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"gender" value:model.gender];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"head_url" value:model.head_url];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"height" value:model.height];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"id" value:model.id];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"jg_id" value:model.jg_id];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"id_number" value:model.id_number];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"locked" value:model.locked];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"mobile" value:model.mobile];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"nick_name" value:model.nick_name];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"password" value:model.password];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"weight" value:model.weight];
//    
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"name" value:model.name];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"reason" value:model.reason];
//    saveDic = [BGControl saveUserInfoInDictionary:saveDic key:@"checked" value:model.checked];
//    [saveDic writeToFile:fileName atomically:YES];
}
- (void)Alert:(NSString *)AlertStr{
    
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:[[UIApplication sharedApplication].windows lastObject]];
    
}
-(void)creatUI:(NSArray *)picArray imgScroView:(UIScrollView *)imgScroView buttonTag:(NSInteger)buttonTag{
//    imgScroView.contentSize=CGSizeMake(imgScroView.frame.size.width*picArray.count, imgScroView.frame.size.height);
//    imgScroView.pagingEnabled=YES;
//    imgScroView.contentOffset = CGPointMake(kScreenSize.width * buttonTag, 0);
//    if (picArray.count==0) {
//        imgScroView.hidden=YES;
//    }else{
//        for (NSInteger i=0; i<picArray.count; i++) {
//            UIImageView *imageVIEW = nil;
//            imageVIEW=[[UIImageView alloc]initWithFrame:CGRectMake(imgScroView.frame.size.width*i,0, imgScroView.frame.size.width, imgScroView.frame.size.height)];
//            imageVIEW.backgroundColor = kBlackColor;
//            //            NSLog(@"%f",imageVIEW.frame.origin.x);
//            NSString *url=[NSString stringWithFormat:@"%@",picArray[i]];
//            if ([picArray[i] isEqualToString:@""]) {
//            }else{
//                [imageVIEW sd_setImageWithURL:[NSURL URLWithString:url] placeholderImage:[UIImage imageNamed:@"512.png"]];
//            }
//            [imageVIEW setContentScaleFactor:[[UIScreen mainScreen] scale]];
//            imageVIEW.contentMode =  UIViewContentModeScaleAspectFit;
//            imageVIEW.autoresizingMask = UIViewAutoresizingFlexibleHeight;
//            imageVIEW.clipsToBounds  = YES;
//            UIButton *button = [BGControl creatButtonWithFrame:imageVIEW.frame target:self sel:@selector(hidden:) tag:0 image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
//            //            UIButton *saveButton = [BGControl creatButtonWithFrame:CGRectMake(kScreenSize.width - 60, kScreenSize.height - 50, 40, 25) target:self sel:@selector(saveImageButtonClick:) tag:0 image:nil isBackgroundImage:NO title:@"保存" isLayer:YES cornerRadius:kButtonCornerRadius];
//            //            saveButton.backgroundColor = kWhiteColor;
//            
//            //            self.IMGView = imageVIEW;
//            UITapGestureRecognizer*tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bigImage)];
//            imageVIEW.userInteractionEnabled = YES;
//            //            [imageVIEW addSubview:saveButton];
//            [imageVIEW addGestureRecognizer:tap];
//            [imgScroView addSubview:imageVIEW];
//            [imgScroView addSubview:button];
//        }
//        imgScroView.hidden = NO;
//    }
}
- (void)bigImage{
    NSLog(@"局部放大");
//    [BGControl showImage:self.IMGView];//调用方法
}


- (void)saveImageButtonClick:(UIButton *)button{
    UIImageWriteToSavedPhotosAlbum(self.IMGView.image, self, @selector(imageSavedToPhotosAlbum:didFinishSavingWithError:contextInfo:), nil);
}

//- (void)saveImageToPhotos:(UIImage*)savedImage{

- (void)imageSavedToPhotosAlbum:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *message = nil;
    if (!error) {
        [self Alert:@"图片已保存"];
    }else
    {
        message = [error description];
    }
}
- (void)hidden:(UIButton *)button{
    [self Alert:@"点击大图"];
    
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
