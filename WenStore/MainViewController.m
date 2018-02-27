//
//  MainViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/9.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MainViewController.h"
#import "HeadquarterNews.h"
#import "MatterViewController.h"
#import "DealtViewController.h"
#import "AppDelegate.h"
#import "BGControl.h"
#import "AddAddressVC.h"
#import "AddressListVC.h"
#import "CallOrderOneVC.h"
#import "OrderTwoVC.h"
#import "CallOrderFourVC.h"
#import "CallOrderThreeVC.h"
#import "PurchaseOnePageVC.h"
#import "ScrapOnePageVC.h"
#import "StocktakOnePageVC.h"
#import "ProcurementOrderOnePagVC.h"
#import "ProcurementOrderVC.h"
#import "PSOnePageVC.h"
#import "AFClient.h"
#import "dialOnePageVC.h"
#import "AsideOnePageVC.h"
#import "ProducedOnePaggeVC.h"
#import "TryEatOnePageVC.h"
#import "GiveAwayOnePageVC.h"
#import "RecipientsOnePageVC.h"
#import "CallTableVC.h"
#import "DistributionTableVC.h"

// 取得AppDelegate单利
#define ShareApp ((AppDelegate *)[[UIApplication sharedApplication] delegate])
@interface MainViewController ()<UIScrollViewDelegate> {
    NSMutableDictionary *dict;
  NSMutableArray *postArr;
    NSDictionary *loginDict;
    NSMutableArray *oneArr;
    NSMutableArray *twoArr;
    NSMutableArray *threeArr;
    NSMutableArray *fourArr;
    NSMutableArray *postAllArr;
    NSMutableDictionary *groupDict;
    NSString *_urlStr;
    NSInteger bthTag;
    NSArray *detpsArr;
    NSMutableArray *reasonsArr;
    BOOL isShow;
    CGFloat headerHei;
}

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"loginData"];
    
    loginDict = [BGControl dictionaryWithJsonString:jsonString];
    oneArr = [NSMutableArray array];
    twoArr = [NSMutableArray array];
    threeArr = [NSMutableArray array];
    fourArr = [NSMutableArray array];
    postAllArr = [NSMutableArray array];
    detpsArr = [NSArray array];

    [self firs];
    [self firstOne];
    
    
   
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:YES];
  
}
-(void)firstOne{
    [self show];
    [[AFClient shareInstance] All:postAllArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue]==200) {
         NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
            
                groupDict = responseBody[@"data"];
                NSDictionary *indexTodo = [groupDict valueForKey:@"indexTodo"];
                self.detailLab.text = [indexTodo valueForKey:@"appMsg"];
                self.numLab.text = [NSString stringWithFormat:@"%@%@",[groupDict valueForKey:@"todoCount"],@"条"];
                CGFloat numWidth = [BGControl labelAutoCalculateRectWith:self.numLab.text FontSize:10 MaxSize:CGSizeMake(MAXFLOAT, 15)].width;
                self.numLab.frame = CGRectMake(kScreenSize.width-15-numWidth-20, 27, numWidth+10, 15);
                CGFloat detailWidth = [BGControl labelAutoCalculateRectWith:self.detailLab.text FontSize:13 MaxSize:CGSizeMake(MAXFLOAT, 15)].width;
                self.detailLab.frame = CGRectMake(20, 0, detailWidth, 20);
                self.detailBth.frame = CGRectMake(20, 0, detailWidth, 20);
                self.infoScrollview.contentSize = CGSizeMake(detailWidth+50,20);
            
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue] ==1 || [[userResponseDict valueForKey:@"code"] intValue] ==4) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postAllArr removeAllObjects];
                        [postAllArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self firstOne];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue] == 2  ) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postAllArr removeAllObjects];
                            [postAllArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self firstOne];
                            
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
        [self dismiss];
    } failure:^(NSError *error) {
      [self dismiss];
    }];
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    NSNumber *pageNumber = [NSNumber numberWithInt:1];
    NSNumber *page = [NSNumber numberWithInt:50];
    [postDict setObject:pageNumber forKey:@"page"];
    [postDict setObject:page forKey:@"perPage"];
    [self show];
    [[AFClient shareInstance] GetNewswithUrl:@"App/Setting/GetNews" withDict:postDict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]== 200) {
            CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:@"0" FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
            self.CountLab.text = [NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"total"]];
            self.CountLab.font = [UIFont systemFontOfSize:10];
            self.CountLab.clipsToBounds = YES;
            self.CountLab.layer.cornerRadius = oneNumWidth /2 +3;
            self.CountLab.frame = CGRectMake(kScreenSize.width-20, 20, oneNumWidth+6, oneNumWidth+6);
            if ([self.CountLab.text isEqualToString:@"0"]) {
                self.CountLab.hidden = YES;
            }else {
                self.CountLab.hidden = NO;
            }
            self.CountLab.textAlignment = NSTextAlignmentCenter;
            
        }else {
            [self Alert:@"请求失败"];
            
        }
       
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}


-(void)firs {
    isShow = YES;
    dict = [NSMutableDictionary new];
    self.bigScrollview.delegate = self;
    self.bigScrollview.showsVerticalScrollIndicator = NO;
    
    self.bigScrollview.contentSize = CGSizeMake(self.view.frame.size.width,1150);
    self.bigScrollview.scrollEnabled = YES;
    self.infoScrollview.delegate = self;
    self.infoScrollview.showsHorizontalScrollIndicator = NO;
    self.infoScrollview.scrollEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.bigScrollview.frame = CGRectMake(0, 60, kScreenSize.width, kScreenSize.height - 60);
    if (isShow == NO) {
        self.oneView.hidden = YES;
        headerHei = 15;
    }else{
           self.oneView.frame = CGRectMake(0, 15, kScreenSize.width, 100);
        headerHei = 125;
    }

  
    self.numLab.clipsToBounds = YES;
    self.numLab.layer.cornerRadius = 8.f;
    
    self.twoView.frame = CGRectMake(0, 125, kScreenSize.width, 235);
    self.threeView.frame = CGRectMake(0, 375, kScreenSize.width, 235);
    self.fourView.frame = CGRectMake(0, 625, kScreenSize.width, 235);
    self.fiveView.frame = CGRectMake(0, 875, kScreenSize.width, 235);
    [self setView];
   
  
    
    
}

- (void)setDataWithUrl:(NSString *)urlStr {
    [self show];
    [[AFClient shareInstance] GetResource:@"1" withArr:postArr withUrl:urlStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                dict = responseBody[@"data"];
                NSError *error;
                NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
                NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                [[NSUserDefaults standardUserDefaults] setValue:jsonString forKey:@"ResourceData"];
                if ([urlStr isEqualToString:@"App/Wbp3001/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"lpdt036"];
                     [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[dict valueForKey:@"isEnablePayment"]  ]forKey:@"isEnablePayment"];
//                    isEnablePayment
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3008/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3008lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3008lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3008lpdt036"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3011/GetResource"]) {
                    reasonsArr = [[NSMutableArray alloc] init];
                    reasonsArr = [dict valueForKey:@"reasons"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3011lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3011lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3011lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                     [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3011isDisplayUnitPrice"];
                      [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3022/GetResource"]) {
                 
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3022lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3022lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3022lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3022isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3004/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3004lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3004lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3004lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3004isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3002/GetResource"]) {
                    reasonsArr = [[NSMutableArray alloc] init];
                    reasonsArr = [dict valueForKey:@"reasons"];
                   
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3002lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3002lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3002lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3002isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3003/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3003lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3003lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3003lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3003isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3023/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3023lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3023lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3023lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3023isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3005/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3005lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3005lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3005lpdt036"];
                    detpsArr = [NSArray array];
                    detpsArr = [dict valueForKey:@"depts"];
                    
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3005isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3010/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3010lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3010lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3010lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3010isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3007/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3007lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3007lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3007lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3007isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3018/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3018lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3018lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3018lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3018isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3019/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3019lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3019lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3019lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3019isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3013/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3013lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3013lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3013lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3013isDisplayUnitPrice"];
                    [self delayMethod];
                }
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue] == 1|| [[userResponseDict valueForKey:@"code"] intValue] == 4) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postArr removeAllObjects];
                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self setDataWithUrl:urlStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]==2 ) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postArr removeAllObjects];
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
            } }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }

        [self dismiss];
        
        
    } failure:^(NSError *error) {
        [self Alert:@"请重试!"];
        [self dismiss]; 
    }];
}
- (void)setView {
    CGFloat margin = 1;
    CGFloat height = 95;
    CGFloat maxHei;
    CGFloat width = (kScreenSize.width- 1)/2;
    
    NSMutableArray *twoTiltle = [NSMutableArray array];
    NSMutableArray *zongArr = [loginDict valueForKey:@"menus"];
    if (zongArr.count<1) {
        return;
    }
    
    
    NSArray *twoImg = @[@"11.png",@"12.png",@"13.png",@"14.png"];
    
    NSMutableArray *threeTiltle = [NSMutableArray array];
    NSArray *threeImg = @[@"21.png",@"22.png",@"23.png",@"24.png",@"25.png"];
    
    NSMutableArray *fourTiltle = [NSMutableArray array];
    NSArray *fourImg = @[@"31.png",@"32.png",@"33.png",@"34.png",@"35.png",@"36.png",@"37.png",@"38.png"];
    
    NSMutableArray *fiveTiltle = [NSMutableArray array];
    NSArray *fiveImg = @[@"41.png",@"42.png"];
    for (int i = 0; i<zongArr.count; i++) {
        if ([[zongArr[i] valueForKey:@"groupName"] isEqualToString:@"门市叫货"]) {
            NSArray *billsArr = [zongArr[i] valueForKey:@"bills"];
            twoTiltle = [NSMutableArray arrayWithArray:billsArr];
        }
        
        if ([[zongArr[i] valueForKey:@"groupName"] isEqualToString:@"门市采购"]) {
            NSArray *billsArr = [zongArr[i] valueForKey:@"bills"];
            threeTiltle = [NSMutableArray arrayWithArray:billsArr];
        }
        if ([[zongArr[i] valueForKey:@"groupName"] isEqualToString:@"门市调配"]) {
            NSArray *billsArr = [zongArr[i] valueForKey:@"bills"];
            fourTiltle = [NSMutableArray arrayWithArray:billsArr];
        }
        if ([[zongArr[i] valueForKey:@"groupName"] isEqualToString:@"门市统计"]) {
            NSArray *billsArr = [zongArr[i] valueForKey:@"bills"];
            fiveTiltle = [NSMutableArray arrayWithArray:billsArr];
        }
    }
    NSInteger  one = twoTiltle.count / 2;
    NSInteger add = 0;
    if (twoTiltle.count%2 == 1) {
        one = one +1;
    };
    NSInteger  two = threeTiltle.count / 2;
    if (threeTiltle.count%2 == 1) {
        two = two +1;
    };
    NSInteger  three = fourTiltle.count / 2;
    if (fourTiltle.count%2 == 1) {
        three = three +1;
    };
    NSInteger  four = fiveTiltle.count / 2;
    if (fiveTiltle.count%2 == 1) {
        four = four +1;
    };
    
    if (twoTiltle.count >2) {
        UIView *linetwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 140, kScreenSize.width, 1)];
        linetwoView.backgroundColor = kLineColor;
        [self.twoView addSubview:linetwoView];
    }
    
    
    
    if (one==0) {
        self.twoView.frame = CGRectMake(0, headerHei, kScreenSize.width, 0);
       
    }else {
        self.twoView.frame = CGRectMake(0, headerHei, kScreenSize.width, one*95 +45);
        add = add+1;
    }
    if (two == 0) {
        self.threeView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame) , kScreenSize.width, 0);
    }else {
        self.threeView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame), kScreenSize.width, two*95 +45);
        add = add+1;
    }
    if (three == 0) {
        self.fourView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame) +CGRectGetHeight(self.threeView.frame) , kScreenSize.width, 0);
    }else {
        self.fourView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame) +CGRectGetHeight(self.threeView.frame), kScreenSize.width, three*95 +45);
        add = add+1;
    }
    
    if (four == 0) {
        self.fiveView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame) +CGRectGetHeight(self.threeView.frame) +CGRectGetHeight(self.fourView.frame) , kScreenSize.width, 0);
    }else {
        self.fiveView.frame = CGRectMake(0, headerHei+add*15 +CGRectGetHeight(self.twoView.frame) +CGRectGetHeight(self.threeView.frame)+CGRectGetHeight(self.fourView.frame), kScreenSize.width, four*95 +45);
        add = add+1;
    }
    for (int i =1; i<two; i++) {
        UIView *linetwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 95*i +45, kScreenSize.width, 1)];
        linetwoView.backgroundColor = kLineColor;
        [self.threeView addSubview:linetwoView];
        
    }
    
    for (int i =1; i<three; i++) {
        UIView *linetwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 95*i +45, kScreenSize.width, 1)];
        linetwoView.backgroundColor = kLineColor;
        [self.fourView addSubview:linetwoView];
        
    }
    
    for (int i =1; i<four; i++) {
        UIView *linetwoView = [[UIView alloc] initWithFrame:CGRectMake(0, 95*i +45, kScreenSize.width, 1)];
        linetwoView.backgroundColor = kLineColor;
        [self.fiveView addSubview:linetwoView];
        
    }
    maxHei = CGRectGetMaxY(self.fiveView.frame);
    self.bigScrollview.contentSize = CGSizeMake(self.view.frame.size.width,maxHei +50);
    for (int i = 0; i<twoTiltle.count; i++) {
        UIView * view = [[UIView alloc] init];
        //        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake((i%2)*(margin+width), i/2*95 +45,width  , 94);
        [self.twoView addSubview:view];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*(margin+width)+width, i/2*95 +45, 1, 95)];
        lineView.backgroundColor = kLineColor;
        [self.twoView addSubview:lineView];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 32, 36, 36)];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, width, 94)];
        label.text = [twoTiltle[i] valueForKey:@"title"];
        [view addSubview: imgview];
        [view addSubview:label];
        UILabel *twoLab = [[UILabel alloc] init];
        twoLab.backgroundColor = kredColor;
        twoLab.textColor = [UIColor whiteColor];
        twoLab.font = [UIFont systemFontOfSize:10];
        twoLab.clipsToBounds = YES;
        twoLab.text = [NSString stringWithFormat:@"%@",[twoTiltle[i] valueForKey:@"unconfirmedQuality"]];
        CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:twoLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
        twoLab.layer.cornerRadius = oneNumWidth /2 +2;
        twoLab.frame = CGRectMake(41, 30, oneNumWidth+4, oneNumWidth+4);
        if ([twoLab.text isEqualToString:@"0"]) {
            twoLab.hidden = YES;
        }else {
            twoLab.hidden = NO;
        }
        twoLab.textAlignment = NSTextAlignmentCenter;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
        if ([[twoTiltle[i] valueForKey:@"no"] isEqualToString:@"WBW3001"]) {
            imgview.image = [UIImage imageNamed:twoImg[0]];
            button.tag = 300;
        }else if ([[twoTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3001LIST"]) {
            imgview.image = [UIImage imageNamed:twoImg[1]];
            button.tag = 301;
        }else if ([[twoTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3008"]) {
            imgview.image = [UIImage imageNamed:twoImg[2]];
            button.tag = 302;
        }else if ([[twoTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3011"]) {
            imgview.image = [UIImage imageNamed:twoImg[3]];
            button.tag = 303;
        }

        [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        [view addSubview:twoLab];
        
    }
    for (int i = 0; i<threeTiltle.count; i++) {
        UIView * view = [[UIView alloc] init];
        //        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake((i%2)*(margin+width), i/2*95 +45,width  , 94);
        [self.threeView addSubview:view];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*(margin+width)+width, i/2*95 +45, 1, 95)];
        lineView.backgroundColor = kLineColor;
        [self.threeView addSubview:lineView];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 32, 36, 36)];
//        imgview.image = [UIImage imageNamed:threeImg[i]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, width, 94)];
        label.text = [threeTiltle[i] valueForKey:@"title"];
        [view addSubview: imgview];
        [view addSubview:label];
        UILabel *twoLab = [[UILabel alloc] init];
        twoLab.backgroundColor = kredColor;
        twoLab.textColor = [UIColor whiteColor];
        twoLab.font = [UIFont systemFontOfSize:10];
        twoLab.clipsToBounds = YES;
        twoLab.text = [NSString stringWithFormat:@"%@",[threeTiltle[i] valueForKey:@"unconfirmedQuality"]];
        CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:twoLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
        twoLab.layer.cornerRadius = oneNumWidth /2 +2;
        twoLab.frame = CGRectMake(41, 30, oneNumWidth+4, oneNumWidth+4);
        if ([twoLab.text isEqualToString:@"0"]) {
            twoLab.hidden = YES;
        }else {
            twoLab.hidden = NO;
        }
        twoLab.textAlignment = NSTextAlignmentCenter;

        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
        if ([[threeTiltle[i] valueForKey:@"no"] isEqualToString:@"WBW3022"]) {
            imgview.image = [UIImage imageNamed:threeImg[0]];
            button.tag = 400;
        }else if ([[threeTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3022LIST"]) {
            imgview.image = [UIImage imageNamed:threeImg[1]];
            button.tag = 401;
        }else if ([[threeTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3023"]) {
            imgview.image = [UIImage imageNamed:threeImg[2]];
            button.tag = 402;
        }else if ([[threeTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3004"]) {
            imgview.image = [UIImage imageNamed:threeImg[3]];
            button.tag = 403;
        }else if ([[threeTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3024"]) {
            imgview.image = [UIImage imageNamed:threeImg[4]];
            button.tag = 404 ;
        }

       
        [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [view addSubview:twoLab];
        
    }
    for (int i = 0; i<fourTiltle.count; i++) {
        UIView * view = [[UIView alloc] init];
        //        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake((i%2)*(margin+width), i/2*95 +45,width  , 95);
        [self.fourView addSubview:view];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*(margin+width)+width, i/2*95 +45, 1, 95)];
        lineView.backgroundColor = kLineColor;
        [self.fourView addSubview:lineView];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 32, 36, 36)];
//        imgview.image = [UIImage imageNamed:fourImg[i]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, width, 94)];
        label.text = [fourTiltle[i] valueForKey:@"title"];
        [view addSubview: imgview];
        [view addSubview:label];
        UILabel *twoLab = [[UILabel alloc] init];
        twoLab.backgroundColor = kredColor;
        twoLab.textColor = [UIColor whiteColor];
        twoLab.font = [UIFont systemFontOfSize:10];
        twoLab.clipsToBounds = YES;
        twoLab.text = [NSString stringWithFormat:@"%@",[fourTiltle[i] valueForKey:@"unconfirmedQuality"]];
        CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:twoLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
        twoLab.layer.cornerRadius = oneNumWidth /2 +2;
        twoLab.frame = CGRectMake(41, 30, oneNumWidth+4, oneNumWidth+4);
        if ([twoLab.text isEqualToString:@"0"]) {
            twoLab.hidden = YES;
        }else {
            twoLab.hidden = NO;
        }
        twoLab.textAlignment = NSTextAlignmentCenter;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
        if ([[fourTiltle[i] valueForKey:@"no"] isEqualToString:@"WBW3002"]) {
            imgview.image = [UIImage imageNamed:fourImg[0]];
            button.tag = 500;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3003"]) {
            imgview.image = [UIImage imageNamed:fourImg[1]];
            button.tag = 501;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3005"]) {
            imgview.image = [UIImage imageNamed:fourImg[2]];
            button.tag = 502;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3010"]) {
            imgview.image = [UIImage imageNamed:fourImg[3]];
            button.tag = 503;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3007"]) {
            imgview.image = [UIImage imageNamed:fourImg[4]];
            button.tag = 504 ;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3018"]) {
            imgview.image = [UIImage imageNamed:fourImg[5]];
            button.tag = 505 ;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3019"]) {
            imgview.image = [UIImage imageNamed:fourImg[6]];
            button.tag = 506 ;
        }else if ([[fourTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW3013"]) {
            imgview.image = [UIImage imageNamed:fourImg[7]];
            button.tag = 507 ;
        }


        

        [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];
        
        [view addSubview:twoLab];
        
    }
    for (int i = 0; i<fiveTiltle.count; i++) {
        UIView * view = [[UIView alloc] init];
        //        view.backgroundColor = [UIColor redColor];
        view.frame = CGRectMake((i%2)*(margin+width), i/2*95 +45,width  , 94);
        [self.fiveView addSubview:view];
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake((i%2)*(margin+width)+width, i/2*95 +45, 1, 95)];
        lineView.backgroundColor = kLineColor;
        [self.fiveView addSubview:lineView];
        UIImageView *imgview = [[UIImageView alloc] initWithFrame:CGRectMake(15, 32, 36, 36)];
//        imgview.image = [UIImage imageNamed:fiveImg[i]];
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(66, 0, width, 94)];
        label.text = [fiveTiltle[i] valueForKey:@"title"];
        [view addSubview: imgview];
        [view addSubview:label];
        UILabel *twoLab = [[UILabel alloc] init];
        twoLab.backgroundColor = kredColor;
        twoLab.textColor = [UIColor whiteColor];
        twoLab.font = [UIFont systemFontOfSize:10];
        twoLab.clipsToBounds = YES;
        twoLab.text = [NSString stringWithFormat:@"%@",[fiveTiltle[i] valueForKey:@"unconfirmedQuality"]];
        CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:twoLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
        twoLab.layer.cornerRadius = oneNumWidth /2 +2;
        twoLab.frame = CGRectMake(41, 30, oneNumWidth+4, oneNumWidth+4);
        if ([twoLab.text isEqualToString:@"0"]) {
            twoLab.hidden = YES;
        }else {
            twoLab.hidden = NO;
        }
        twoLab.textAlignment = NSTextAlignmentCenter;
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(view.frame), CGRectGetHeight(view.frame))];
        if ([[fiveTiltle[i] valueForKey:@"no"] isEqualToString:@"WBW5012"]) {
            imgview.image = [UIImage imageNamed:fiveImg[0]];
            button.tag = 600;
        }else if ([[fiveTiltle[i]  valueForKey:@"no"] isEqualToString:@"WBW5013"]) {
            imgview.image = [UIImage imageNamed:fiveImg[1]];
            button.tag = 601;
        }
        [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [view addSubview:button];

        [view addSubview:twoLab];
        
    }
    
    
}


-(void)itemButtonClick:(UIButton *)button {
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *storyboardTwo = [UIStoryboard storyboardWithName:@"WendianTwo" bundle:nil];
    if (button.tag == 300) {

        [self setDataWithUrl:@"App/Wbp3001/GetResource"];
        bthTag = button.tag;
       
    }else if (button.tag == 301){
        [self setDataWithUrl:@"App/Wbp3001/GetResource"];
        bthTag = button.tag;
        
        
    }else if (button.tag == 302){
       
        [self setDataWithUrl:@"App/Wbp3008/GetResource"];
        bthTag = button.tag;
//        [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
       
        
        
    }else if (button.tag == 303) {
         [self setDataWithUrl:@"App/Wbp3011/GetResource"];
          bthTag = button.tag;
//         [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
        
    }else if (button.tag == 400 || button.tag == 401) {
        [self setDataWithUrl:@"App/Wbp3022/GetResource"];
        bthTag = button.tag;
        //         [self performSelector:@selector(delayMethod) withObject:nil/*可传任意类型参数*/ afterDelay:1.0];
        
    }else if (button.tag == 402) {
        [self setDataWithUrl:@"App/Wbp3023/GetResource"];
        bthTag = button.tag;
    }
    else if (button.tag == 403) {
        [self setDataWithUrl:@"App/Wbp3004/GetResource"];
        bthTag = button.tag;
          }else if (button.tag == 500) {
        [self setDataWithUrl:@"App/Wbp3002/GetResource"];
        bthTag = button.tag;
          }else if (button.tag == 501) {
        [self setDataWithUrl:@"App/Wbp3003/GetResource"];
        bthTag = button.tag;
     
    }else if (button.tag == 502) {
        [self setDataWithUrl:@"App/Wbp3005/GetResource"];
        bthTag = button.tag;
      
    }else if (button.tag == 503) {
        [self setDataWithUrl:@"App/Wbp3010/GetResource"];
        bthTag = button.tag;
        
    }else if (button.tag == 504) {
        [self setDataWithUrl:@"App/Wbp3007/GetResource"];
        bthTag = button.tag;
        
    }else if (button.tag == 505) {
        [self setDataWithUrl:@"App/Wbp3018/GetResource"];
        bthTag = button.tag;
        
    }else if (button.tag == 506) {
        [self setDataWithUrl:@"App/Wbp3019/GetResource"];
        bthTag = button.tag;
        
    }else if (button.tag == 507) {
        [self setDataWithUrl:@"App/Wbp3013/GetResource"];
        bthTag = button.tag;
        
    }else if (button.tag == 600){
        CallTableVC *matter = [storyboardTwo instantiateViewControllerWithIdentifier:@"CallTableVC"];
        [self.navigationController pushViewController:matter animated:YES];
    }else if (button.tag == 601){
      
        DistributionTableVC  *matter = [storyboardTwo instantiateViewControllerWithIdentifier:@"DistributionTableVC"];
        [self.navigationController pushViewController:matter animated:YES];
        
    }
}
- (void)delayMethod{
      UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      UIStoryboard *storyboardTwo = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
      UIStoryboard *storyboardThree = [UIStoryboard storyboardWithName:@"WendianTwo" bundle:nil];
    if (bthTag == 302) {
        CallOrderThreeVC *callOrderThree = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeVC"];
        [self.navigationController pushViewController:callOrderThree animated:YES];

    }else if (bthTag == 303){
        CallOrderFourVC *callFour = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourVC"];
        callFour.reasonsArr = reasonsArr;
        [self.navigationController pushViewController:callFour animated:YES];
    }else if (bthTag == 300){
        CallOrderOneVC *callVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderOneVC"];
        callVC.dict = dict;
        [self.navigationController pushViewController:callVC animated:YES];
        
        
    }else if (bthTag == 301){
        OrderTwoVC *orderTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
        orderTwo.fanStr =@"MainViewController";
        orderTwo.dataDict = dict;
        [self.navigationController pushViewController:orderTwo animated:YES];
    }else if (bthTag == 400){
        ProcurementOrderVC *procure = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
       procure.typeStr = @"add";
        [self.navigationController pushViewController:procure animated:YES];
    }else if (bthTag == 401){
        ProcurementOrderOnePagVC *procure = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderOnePagVC"];
        
        [self.navigationController pushViewController:procure animated:YES];
    }else if (bthTag == 402) {
        PSOnePageVC *onePage = [storyboardTwo instantiateViewControllerWithIdentifier:@"PSOnePageVC"];
        [self.navigationController pushViewController:onePage animated:YES];
    }
    
    else if (bthTag == 403){
        PurchaseOnePageVC *purchase = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseOnePageVC"];
        
        [self.navigationController pushViewController:purchase animated:YES];
    }else if (bthTag == 500){
        ScrapOnePageVC *scrapOn = [storyboard instantiateViewControllerWithIdentifier:@"ScrapOnePageVC"];
        scrapOn.reasonsArr = reasonsArr;
        [self.navigationController pushViewController:scrapOn animated:YES];
    }else if (bthTag == 501){
        StocktakOnePageVC *scrapOn = [storyboard instantiateViewControllerWithIdentifier:@"StocktakOnePageVC"];
        
        [self.navigationController pushViewController:scrapOn animated:YES];
    }else if (bthTag == 502){
        AsideOnePageVC *asideVC = [storyboardTwo instantiateViewControllerWithIdentifier:@"AsideOnePageVC"];
        asideVC.detpsArr = detpsArr;
        [self.navigationController pushViewController:asideVC animated:YES];
    }else if (bthTag == 503){
        dialOnePageVC *dialVC = [storyboardTwo instantiateViewControllerWithIdentifier:@"dialOnePageVC"];
        [self.navigationController pushViewController:dialVC animated:YES];
    }else if (bthTag == 504){
        ProducedOnePaggeVC *ProducedVC = [storyboardTwo instantiateViewControllerWithIdentifier:@"ProducedOnePaggeVC"];
        [self.navigationController pushViewController:ProducedVC animated:YES];
    }else if (bthTag == 505){
        TryEatOnePageVC *ProducedVC = [storyboardTwo instantiateViewControllerWithIdentifier:@"TryEatOnePageVC"];
        [self.navigationController pushViewController:ProducedVC animated:YES];
    }else if (bthTag == 506){
        GiveAwayOnePageVC *ProducedVC = [storyboardThree instantiateViewControllerWithIdentifier:@"GiveAwayOnePageVC"];
        [self.navigationController pushViewController:ProducedVC animated:YES];
    }else if (bthTag == 507){
        RecipientsOnePageVC *ProducedVC = [storyboardThree instantiateViewControllerWithIdentifier:@"RecipientsOnePageVC"];
        [self.navigationController pushViewController:ProducedVC animated:YES];
    }
}
- (IBAction)leftBthClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 201) {
        AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        if (tempAppDelegate.LeftSlideVC.closed)
        {
            [tempAppDelegate.LeftSlideVC openLeftView];
        }
        else
        {
            [tempAppDelegate.LeftSlideVC closeLeftView];
        }
        
    }else if(sender.tag == 202) {
            HeadquarterNews *headVC = [storyboard instantiateViewControllerWithIdentifier:@"HeadquarterNews"];
        [self.navigationController pushViewController:headVC animated:YES];
        
    }else {
        //待办事项
        DealtViewController *dealt = [storyboard instantiateViewControllerWithIdentifier:@"DealtViewController"];
        dealt.dataDict = groupDict;
        [self.navigationController pushViewController:dealt animated:YES];
    }
    
    
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    NSLog(@"viewWillDisappear");
    AppDelegate *tempAppDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [tempAppDelegate.LeftSlideVC setPanEnabled:NO];
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
