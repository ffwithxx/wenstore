//
//  CallOrderOneVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/17.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderOneVC.h"
#import "CallOrderOneCell.h"
#import "CallOrderTwoCell.h"
#define  kCellName @"CallOrderTwoCell"
#import "SearchVC.h"
#import "OrderDetailVC.h"
#import "Forecast.h"
#import "AFClient.h"
#import "NewModel.h"
#import "BuyModel.h"
#import "BGControl.h"
#import "SVProgressHUD.h"
#import "orderCountView.h"
#import "orderTwoView.h"
#import "CallOrderOneVC.h"
#import "SZCalendarPicker.h"

@interface CallOrderOneVC ()<UITableViewDelegate,UITableViewDataSource,forecastDelegate,maxHeiDelegate,orderCountDelegate,bottomHeiDelegate,PeiDelegate,ProDelegate,TanDelegate,TanLitterDelegate,callOrderFanDataDelegate,remindDelegate> {
    //    CallOrderTwoCell *_twoCell;
    NSMutableArray *arrOne;
    NSMutableArray *two;
    Forecast *forecastView;
    BOOL istrue;
    NSMutableDictionary *dataDict;
    NSMutableDictionary *rightDict;
    NSMutableDictionary *postDict;
    NSMutableArray *postArr;
    CGFloat callTaleHei;
    orderCountView *orderView;
    orderTwoView *orderConutTwoView;
    NSMutableArray *postOneArr;
    NSMutableDictionary *forecastDICT;
    NSInteger lpdt036;
    NSInteger lpdt042;
    NSInteger lpdt043;
    NSString *isRule;
    NSString *rightorXia;
    NSString *forecasType;
    NSInteger peiCount;
    NSString *jsob001Str;
    BOOL isFan;//是否返回到主页面
    
    
}

@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;
@end

@implementation CallOrderOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    rightorXia = @"right";
    isRule = @"1";
    isFan = YES;
    peiCount = 0;
    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    
    _ruleArr = [NSMutableArray array];
    forecastDICT = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray array];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray new];
    self.orderCountLab.hidden = YES;
    self.carTableView.showsVerticalScrollIndicator = NO;
    self.carTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
    [self firstOne];
    [self first];
    
    // Do any additional setup after loading the view.
}


- (UITableView *)tableView

{
    
    if (self.carTableView == nil) {
        
        self.carTableView = [[UITableView alloc] initWithFrame:self.carTableView.frame style:UITableViewStylePlain];
        
        self.carTableView.delegate = self;
        
        self.carTableView.dataSource = self;
        
        [self.view addSubview:self.carTableView];
        
    }
    
    return self.carTableView;
    
}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        //        for (NSInteger i = 1; i <= 5; i++) {
        //            [_datas addObject:[NSString stringWithFormat:@"第%zd分区", i]];
        //        }
    }
    return _datas;
}
- (IBAction)allDelet:(UIButton *)sender {
    [postArr removeAllObjects];
    peiCount = 0;
    [self hiddleAllViews];
    istrue = false;
    self.orderCountLab.text = @"";
    self.priceLab.text = @"";
    
    self.orderCountLab.hidden = YES;
    self.sumLab.text = @"";
    [self.carTableView reloadData];

    for (int i = 0; i<_ruleArr.count; i++) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dataDict valueForKey:[NSString stringWithFormat:@"%d",i]]];
        for (int j = 0; j<arr.count; j++) {
            NewModel *model = arr[j];
            model.orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
            [[self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]] replaceObjectAtIndex:j withObject:model];
            NSLog(@"%@",model.orderCount);
        }
    }
    dataDict = self.ruleDita;
    self.datas = self.ruleArr;
    [self.rightTableView reloadData];
    //    NewModel *model = oneArr[index];
    //    model.orderCount = count;
    //    model.originaltest = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",price]];
    //    [[dataDict valueForKey:key] replaceObjectAtIndex:index withObject:model];
}


-(void)jiaoyan {
    NSMutableDictionary *masterDict = [[NSMutableDictionary alloc] init];
    masterDict = [rightDict valueForKey:@"master"];
    NSMutableArray *uploadImgArr = [NSMutableArray array];
    uploadImgArr = [rightDict valueForKey:@"uploadImages"];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    NSMutableArray *detailArr = [NSMutableArray new];
    for (int i = 0; i<postArr.count; i++) {
        NewModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
        
        [modelOne setValue:model.k1dt101 forKey:@"k1dt101"];
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]] forKey:@"k1dt102"];
        
        [modelOne setValue:model.k1dt103 forKey:@"k1dt103"];
        [modelOne setValue:model.k1dt104 forKey:@"k1dt104"];
        NSNumber *numOne = [NSNumber numberWithInt:model.imge004];
        [modelOne setValue:numOne forKey:@"imge004"];
        [modelOne setValue:model.k1dt105 forKey:@"k1dt105"];
     
        NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
        
        NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
        
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
        [modelOne setValue:model.k1dt301 forKey:@"k1dt301"];
        [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
        NSNumber *num =[NSNumber numberWithInt:model.k1dt302 ];
        [modelOne setObject:num forKey:@"k1dt302"];
        NSNumber *num2 =[NSNumber numberWithBool:model.k1dt401  ];
        [modelOne setValue:num2 forKey:@"k1dt401"];
        NSNumber *num3 =[NSNumber numberWithBool:model.k1dt402  ];
        [modelOne setValue:num3 forKey:@"k1dt402"];
        NSArray *freeArr = [model.freeDict valueForKey:@"arrFree"];
        NSArray *buyArr = [model.buyDict valueForKey:@"buyArr"];
        NSArray *promoArr = [model.promDict valueForKey:@"promoArr"];
        if (freeArr.count > 0) {
            for (int j = 0; j < freeArr.count; j++) {
                NSMutableDictionary *freeDict = [NSMutableDictionary new];
                BuyModel *freeModel = freeArr[j];
                [freeDict setObject:freeModel.k7mf007 forKey:@"k1dt001"];
                [freeDict setObject:freeModel.k7mf008 forKey:@"k1dt002"];
                [freeDict setObject:freeModel.k7mf009 forKey:@"k1dt003"];
                [freeDict setObject:@"" forKey:@"k1dt004"];
                [freeDict setObject:freeModel.k7mf011 forKey:@"k1dt005"];
                [freeDict setObject:freeModel.orderCount forKey:@"k1dt102"];
                [freeDict setObject:model.k1dt001 forKey:@"k1dt501"];
                NSNumber *imgnum = [NSNumber numberWithInt:model.imge004];
                 [freeDict setObject:imgnum forKey:@"imge004"];
                NSNumber *num4 =[NSNumber numberWithInt:1 ];
                [freeDict setObject:num4 forKey:@"k1dt302"];
                [freeOrderArr addObject:freeDict];
                
                
            }
        }
        
        if (promoArr.count > 0) {
            for (int j = 0; j < promoArr.count; j++) {
                NSMutableDictionary *promoDict = [NSMutableDictionary new];
                BuyModel *freeModel = promoArr[j];
                [promoDict setObject:freeModel.k7mf007 forKey:@"k1dt001"];
                [promoDict setObject:freeModel.k7mf008 forKey:@"k1dt002"];
                [promoDict setObject:freeModel.k7mf009 forKey:@"k1dt003"];
                [promoDict setObject:freeModel.k7mf011 forKey:@"k1dt005"];
               
                [promoDict setObject:freeModel.orderCount forKey:@"k1dt102"];
                [promoDict setObject:model.k1dt001 forKey:@"k1dt503"];
                NSNumber *num4 =[NSNumber numberWithInt:3 ];
                NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                NSString *priceStr = [BGControl notRounding:freeModel.k7mf017 afterPoint:lpdt042];
                [promoDict setObject:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
                [promoDict setObject:num4 forKey:@"k1dt302"];
                NSNumber *imgnum = [NSNumber numberWithInt:model.imge004];
                [promoDict setObject:imgnum forKey:@"imge004"];
                
                 NSComparisonResult resut = [freeModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (resut == NSOrderedDescending) {
                    [proOrderArr addObject:promoDict];
                }

                
            }
        }
        
//        if (buyArr.count > 0) {
//            for (int j = 0; j < buyArr.count; j++) {
//                NSMutableDictionary *buyDict = [NSMutableDictionary new];
//                BuyModel *freeModel = buyArr[j];
//                [buyDict setObject:freeModel.k7mf007 forKey:@"k1dt001"];
//                [buyDict setObject:freeModel.k7mf008 forKey:@"k1dt002"];
//                [buyDict setObject:freeModel.k7mf009 forKey:@"k1dt003"];
//                [buyDict setObject:freeModel.k7mf011 forKey:@"k1dt005"];
//                [buyDict setObject:freeModel.orderCount forKey:@"k1dt102"];
//                NSDictionary *lpdt042dict = [self.dict valueForKey:@"precisionSetting"] ;
//                NSString *str2  = [NSString stringWithFormat:@"%@",[lpdt042dict valueForKey:@"lpdt042"]];
//                NSInteger lpdt042 = [str2 integerValue];
//                
//                NSString *priceStr = [BGControl notRounding:freeModel.k7mf017 afterPoint:lpdt042];
//                [buyDict setObject:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
//                //                    [buyDict setObject:freeModel.k7mf007 forKey:@"k1dt001"];
//                //                    [buyDict setObject:freeModel.k7mf008 forKey:@"k1dt002"];
//                //                    [buyDict setObject:freeModel.k7mf009 forKey:@"k1dt003"];
//                //                    //                    [promoDict setObject:@"" forKey:@"k1dt004"];
//                //                    [buyDict setObject:freeModel.k7mf011 forKey:@"k1dt005"];
//                //                    [buyDict setObject:freeModel.orderCount forKey:@"k1dt102"];
//                //                    [buyDict setObject:model.k1dt001 forKey:@"k1dt503"];
//                //                    NSNumber *num4 =[NSNumber numberWithInt:3 ];
//                //                    [promoDict setObject:num4 forKey:@"k1dt302"];
//                //                    [proOrderArr addObject:promoDict];
//                [detailArr addObject:buyDict];
//            }
//        }
//        
        [detailArr addObject:modelOne];
        
    }
    [postOneArr removeAllObjects];
    [self show];
    [[AFClient shareInstance] postValidateCart:masterDict detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr  withUrl:@"App/Wbp3001/ValidateCart" withjsob001:jsob001Str progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self dismiss];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OrderDetailVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderDetailVC"];
                detailVC.datadict = [responseBody valueForKey:@"data"];
                detailVC.zongdict = self.dict;
                detailVC.typeStr = @"1";
                detailVC.nameArr = [rightDict valueForKey:@"recentContactWindows"];
                detailVC.phoneArr = [rightDict valueForKey:@"recentContactPhones"];
                detailVC.adreessArr = [rightDict valueForKey:@"recentAddresses"];
                [self.navigationController pushViewController:detailVC animated:YES];
                
                
                [self dismiss];
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self jiaoyan];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self jiaoyan];
                            
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
    
}
- (IBAction)cancleClick:(UIButton *)sender {
   
}

- (IBAction)buttonClickOne:(UIButton *)sender {
    if (sender.tag == 204) {
        [self jiaoyan];
    }else if (sender.tag == 202) {
        NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
        NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
        if ([[[resourceDict valueForKey:@"data"]valueForKey:@"isSalesForecastByUser"] integerValue] == 1) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Forecast" owner:self options:nil];
            
            self.blackButton.hidden = NO;
            forecastView = [nib firstObject];
            forecastView.clipsToBounds = YES;
            forecastView.layer.cornerRadius = 5.f;
            
            forecastView.delegate = self;
            CGRect forecasFrame = forecastView.frame;
            forecasFrame.size.width = kScreenSize.width - 40;
            
            [forecastView setFrame:forecasFrame];
            forecastView.center = self.view.center;
            [self.view addSubview:forecastView];
        }else{
            [self yuce];
        }
       
    }else if (sender.tag == 203){
        if (!istrue && postArr.count>0) {
            self.blackButton.hidden = NO;
            [self.view addSubview:self.bigView];
            [self.view addSubview:self.bottonView];
            self.bigView.hidden = NO;
            self.carTableView.hidden = NO;
            istrue = true;
            rightorXia = @"xia";
            [self.carTableView reloadData];
            
        }else{
            rightorXia = @"right";
            [self hiddleAllViews];
            
            istrue = false;
        }
        
    }
}
-(void)blackButtonClick {
    
    [self hiddleAllViews];
}
- (void)hiddleAllViews{
    if (istrue) {
        istrue = false;
    }
    __block CallOrderOneVC *oneView = self;
    __block Forecast *forecastVie = forecastView;
    //    [forecastView.ipText resignFirstResponder];
    self.bigView.hidden = YES;
    rightorXia = @"right";
    self.carTableView.hidden = YES;
    [forecastVie removeFromSuperview];
    [self.bigView removeFromSuperview];
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    orderConutTwoView.hidden = YES;
    [orderConutTwoView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
}
-(void)hiddleOne{
    if (istrue) {
        istrue = false;
    }
    __block CallOrderOneVC *oneView = self;
    __block Forecast *forecastVie = forecastView;
    //    [forecastView.ipText resignFirstResponder];
    //    self.bigView.hidden = YES;
    [forecastVie removeFromSuperview];
    //    [self.bigView removeFromSuperview];
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    orderConutTwoView.hidden = YES;
    [orderConutTwoView.orderFile resignFirstResponder];
    //        self.blackButton.hidden = YES;
    
}

- (IBAction)searClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
    searchVC.dataDict = self.ruleDita;
    searchVC.maxCount = self.ruleArr.count;
    searchVC.fanDelegate = self;
    [self.navigationController pushViewController:searchVC animated:YES];
}
-(void)fanDict:(NSMutableDictionary *)dict withTitleStr:(NSString *)titleStr
{
    self.searchImg.hidden = YES;
    self.searchLab.hidden = YES;
    self.searchTitleLab.text = titleStr;
    self.forecastBth.enabled = NO;
    self.forecastLab.hidden = YES;
    NSArray *arr = [dict valueForKey:@"0"];
    //    self.ruleDita = dataDict;
    
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            NewModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",count];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            count = count+1;
            [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",count-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    
    if (self.datas.count<1) {
        self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
        dataDict = [[NSMutableDictionary alloc] init];
        dataDict = self.ruleDita;
    }
    isRule = @"2";
    isFan = NO;
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dict;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(void)postForecastStr:(NSString *)tagStr {
    if ([tagStr isEqualToString:@"501"]) {
        [self hiddleAllViews];
    }else if ([tagStr isEqualToString:@"502"]) {
        forecastView.litterView.hidden = NO;
        forecastView.bigview.layer.cornerRadius = 5.f;
        forecastView.bigview.layer.borderWidth = 1.f;
        forecastView.bigview.layer.borderColor = kTabBarColor.CGColor;
        forecastView.changeBth.layer.borderWidth=0;
        forecastView.ciView.hidden = YES;
        forecastView.dateBigView.hidden = YES;
        forecastView.changeBth.layer.borderColor = [UIColor clearColor].CGColor;
        
    }else if ([tagStr isEqualToString:@"503"]) {
        forecastView.bigTextField.text = @"日次预测";
        forecastView.ciFile.text=@"";
        forecastView.litterView.hidden = YES;
        forecastView.bigview.layer.borderWidth = 0;
        forecastView.changeBth.layer.borderWidth=1;
        forecastView.changeBth.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciView.hidden = NO;
        forecastView.ciButton.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciFile.placeholder = @"请选择预日次数";
        forecasType = @"1";
        [forecastDICT setObject:@"2" forKey:@"forecastMethod"];
        
    }else if ([tagStr isEqualToString:@"504"]) {
        forecastView.bigTextField.text = @"周次预测";
        forecastView.ciFile.text=@"";
        forecastView.litterView.hidden = YES;
        forecastView.bigview.layer.borderWidth = 0;
        forecastView.changeBth.layer.borderWidth=1;
        forecastView.changeBth.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciView.hidden = NO;
        forecastView.ciButton.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciFile.placeholder = @"请选择预周次数";
        forecasType = @"2";
        [forecastDICT setObject:@"1" forKey:@"forecastMethod"];
    }else if ([tagStr isEqualToString:@"505"]) {
        forecastView.ciFile.text=@"";
        forecastView.bigTextField.text = @"按次预测";
        forecastView.litterView.hidden = YES;
        forecastView.bigview.layer.borderWidth = 0;
        forecastView.changeBth.layer.borderWidth=1;
        forecastView.changeBth.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciView.hidden = NO;
        forecastView.ciButton.layer.borderColor = kTabBarColor.CGColor;
        forecasType = @"2";
        forecastView.ciFile.placeholder = @"请选择预次数";
        
        [forecastDICT setObject:@"3" forKey:@"forecastMethod"];
    }else if ([tagStr isEqualToString:@"506"]) {
        forecastView.bigTextField.text = @"日期预测";
        forecastView.litterView.hidden = YES;
        forecastView.bigview.layer.borderWidth = 0;
        forecastView.changeBth.layer.borderWidth=1;
        forecastView.changeBth.layer.borderColor = kTabBarColor.CGColor;
        forecastView.dateBigView.hidden = NO;
        
        forecastView.beginBth.layer.borderColor = kTabBarColor.CGColor;
        forecastView.endBth.layer.borderColor = kTabBarColor.CGColor;
        CGRect forecasFrame = forecastView.frame;
        forecasFrame.size.height = 320;
        
        [forecastView setFrame:forecasFrame];
        [forecastDICT setObject:@"4" forKey:@"forecastMethod"];
        CGRect bigFrame = forecastView.bigview.frame;
        bigFrame.size.height = 270;
        [forecastView.bigview setFrame:bigFrame];
        
    }else if ([tagStr isEqualToString:@"508"]) {
        
        forecastView.ciPicker.hidden = NO;
        forecastView.ciButton.layer.borderColor = [UIColor clearColor].CGColor;
        forecastView.ciView.clipsToBounds = YES;
        forecastView.ciView.layer.cornerRadius = 5.0f;
        forecastView.ciView.layer.borderColor = kTabBarColor.CGColor;
        forecastView.ciView.layer.borderWidth = 1.f;
        CGRect ciFrame = forecastView.ciView.frame;
        ciFrame.size.height = 170;
        
        [forecastView.ciView setFrame:ciFrame];
        CGRect forecasFrame = forecastView.frame;
        forecasFrame.size.height = 320;
        
        [forecastView setFrame:forecasFrame];
        NSNumber *num = [NSNumber numberWithInt:5];
        [forecastDICT setObject:num forKey:@"forecastCount"];
        
    }else if ([tagStr isEqualToString:@"509"]) {
        CGRect forecasFrame = forecastView.frame;
        forecasFrame.size.height = 0.8*self.view.frame.size.height;
        
        [forecastView setFrame:forecasFrame];
        forecastView.center = self.view.center;
        CGFloat maxHei = 0.8*self.view.frame.size.height;
        ;
        CGRect bigDateViewFrame = forecastView.dateBigView.frame;
        bigDateViewFrame.size.height = 120 ;
        [forecastView.dateBigView setFrame:bigDateViewFrame];
        
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:forecastView];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        
        calendarPicker.frame = CGRectMake(0, 0, forecastView.frame.size.width, maxHei );
        //        calendarPicker.center = forecastView.dateView.center;
        //        calendarPicker.clipsToBounds = YES;
        //
        calendarPicker.layer.cornerRadius = 10.f;
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
            forecastView.beginTime.text = [NSString stringWithFormat:@"%i-%i-%i", year,month,day];
            NSDate *beginDate = [BGControl stringToDate: forecastView.beginTime.text ];
            [forecastDICT setObject:beginDate forKey:@"forecastStart"];
            
            CGRect forecasFrame = forecastView.frame;
            forecasFrame.size.height = 320;
            [forecastView setFrame:forecasFrame];
            forecastView.center = self.view.center;
            CGRect bigFrame = forecastView.bigview.frame;
            bigFrame.size.height = 270;
            [forecastView.bigview setFrame:bigFrame];
            
            
        };
        calendarPicker.cancleBlock = ^(){
            
            CGRect forecasFrame = forecastView.frame;
            forecasFrame.size.height = 320;
            [forecastView setFrame:forecasFrame];
            forecastView.center = self.view.center;
            CGRect bigFrame = forecastView.bigview.frame;
            bigFrame.size.height = 270;
            [forecastView.bigview setFrame:bigFrame];
            
        };
        
        
    }else if ([tagStr isEqualToString:@"507"]){
        [self hiddleAllViews];
        [self yuce];
    }else if ([tagStr isEqualToString:@"510"]){
        CGRect forecasFrame = forecastView.frame;
        forecasFrame.size.height = 0.8*self.view.frame.size.height;
        
        [forecastView setFrame:forecasFrame];
        forecastView.center = self.view.center;
        CGFloat maxHei = 0.8*self.view.frame.size.height;
        ;
        CGRect bigDateViewFrame = forecastView.dateBigView.frame;
        bigDateViewFrame.size.height = 120;
        [forecastView.dateBigView setFrame:bigDateViewFrame];
        
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:forecastView];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        
        calendarPicker.frame = CGRectMake(0, 0, forecastView.frame.size.width, maxHei );
        //        calendarPicker.center = forecastView.dateView.center;
        //        calendarPicker.clipsToBounds = YES;
        //
        calendarPicker.layer.cornerRadius = 10.f;
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
            forecastView.endTimeFile.text = [NSString stringWithFormat:@"%i-%i-%i", year,month,day];
            NSDate *endDate = [BGControl stringToDate: forecastView.endTimeFile.text ];
            [forecastDICT setObject:endDate forKey:@"forecastEnd"];
            CGRect forecasFrame = forecastView.frame;
            forecasFrame.size.height = 320;
            
            [forecastView setFrame:forecasFrame];
            forecastView.center = self.view.center;
            CGRect bigFrame = forecastView.bigview.frame;
            bigFrame.size.height = 270;
            [forecastView.bigview setFrame:bigFrame];
            
        };
        calendarPicker.cancleBlock = ^(){
            
            CGRect forecasFrame = forecastView.frame;
            forecasFrame.size.height = 320;
            [forecastView setFrame:forecasFrame];
            forecastView.center = self.view.center;
            CGRect bigFrame = forecastView.bigview.frame;
            bigFrame.size.height = 270;
            [forecastView.bigview setFrame:bigFrame];
            
        };
        
    }
    
    
    
    
}

-(void)yuce {
    [self show];
    NSDate *date = [NSDate date];
    [forecastDICT setObject:date forKey:@"k1mf003"];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    if ([[[resourceDict valueForKey:@"data"]valueForKey:@"isSalesForecastByUser"] integerValue] == 1)  {
    if ([forecasType isEqualToString:@"1"]) {
        [forecastDICT setObject:forecastView.ciFile.text forKey:@"forecastCount"];
    }else if ([forecasType isEqualToString:@"2"]){
        [forecastDICT setObject:forecastView.ciFile.text forKey:@"forecastCount"];
    }else if ([forecasType isEqualToString:@"3"]){
        [forecastDICT setObject:forecastView.ciFile.text forKey:@"forecastCount"];
    }
    }
    [[AFClient shareInstance] SalesForecastWith:forecastDICT withArr:postOneArr progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                NSLog(@"%@",responseBody);
                [postArr removeAllObjects];
                NSMutableArray *forecasArr = [NSMutableArray arrayWithArray:[[responseBody valueForKey:@"data"] valueForKey:@"result"]];
                jsob001Str = [[responseBody valueForKey:@"data"] valueForKey:@"jsob001"];
                NSArray *groupTitleArr = [rightDict valueForKey:@"groupTitles"];
                NSArray *arrFree = [rightDict valueForKey:@"freeActivities"];
                NSArray *arrpromo= [rightDict valueForKey:@"promoActivities"];
                NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
                for (int j = 0; j<forecasArr.count; j++) {
                    NSString *idStr = [forecasArr[j]valueForKey:@"k1dt001" ];
                    for (int i = 0; i<groupTitleArr.count; i++) {
                        NSDecimalNumber *peiShopCount;
                        peiCount = postArr.count;
                        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)i]]];;
                        NSMutableArray *biArr = [NSMutableArray array];
                        for (NewModel *oneModel in arr) {
                            [biArr addObject:oneModel.k1dt001];
                        }
                        if ([biArr containsObject:idStr]) {
                            NSInteger index = [biArr indexOfObject:idStr];
                            NewModel *model = arr[index];
                            NSInteger lp036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
                            NSString *countStr = [BGControl notRounding:[forecasArr[j]valueForKey:@"k1dt101" ] afterPoint:lp036];
                            model.orderCount = [NSDecimalNumber decimalNumberWithString:countStr];
                            model.k1dt102 = [NSDecimalNumber decimalNumberWithString:countStr];
                            NSInteger cellCount = 0;
                            NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                            NSInteger xiaoCount = 0;
                            model.xianStr = @"1";
                            model.ispei = 1;
                            model.minPei = [NSDecimalNumber decimalNumberWithString:@"0"];
                            [arr replaceObjectAtIndex:index withObject:model];
                            if (model.hasLimiteInfo == true) {
                                

                                
                                if (model.hasPromo == true) {
                                    NSMutableArray *promoArr = [NSMutableArray new];
                                    for (int i = 0; i < arrpromo.count ; i++) {
                                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]];
                                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf005"]]];
                                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                                           
                                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                           
                                                                           scale:0
                                                                           
                                                                           raiseOnExactness:NO
                                                                           
                                                                           raiseOnOverflow:NO
                                                                           
                                                                           raiseOnUnderflow:NO
                                                                           
                                                                           raiseOnDivideByZero:YES];
                                        
                                        if ([model.k1dt001 isEqualToString:[arrpromo[i] valueForKey:@"k7mf004"]]) {
                                            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                                            NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                                            
                                            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                                            BuyModel *buyModel = [BuyModel new];
                                            buyModel.orderCount = zengText;
                                            buyModel.k7mf004 = [arrpromo[i] valueForKey:@"k7mf004"];
                                            buyModel.k7mf005 = [arrpromo[i] valueForKey:@"k7mf005"];
                                            buyModel.k7mf006 = (int)[arrpromo[i] valueForKey:@"k7mf006"];
                                            buyModel.k7mf007 = [arrpromo[i] valueForKey:@"k7mf007"];
                                            buyModel.k7mf008 = [arrpromo[i] valueForKey:@"k7mf008"];
                                            
                                            buyModel.k7mf009 = [arrpromo[i] valueForKey:@"k7mf009"];
                                            buyModel.k7mf010 = [arrpromo[i] valueForKey:@"k7mf010"];
                                            buyModel.k7mf011 = [arrpromo[i] valueForKey:@"k7mf011"];
                                            buyModel.k7mf012 = [arrpromo[i] valueForKey:@"k7mf012"];
                                            buyModel.k7mf016 = [arrpromo[i] valueForKey:@"k7mf016"];
                                            buyModel.k7mf017 = [arrpromo[i] valueForKey:@"k7mf017"];
                                            [promoArr addObject:buyModel];
                                            if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                                                cellCount = cellCount +1;
                                                NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                                                NSString *priceStr = [BGControl notRounding:buyModel.k7mf017 afterPoint:lpdt042];
                                                NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                                                NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:zengText];
                                                sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                                            }
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    model.promDict = [NSMutableDictionary new];
                                    [model.promDict setValue:promoArr forKey:@"promoArr"];
                                }
                                if (model.hasFree == true) {
                                    NSMutableArray *freeArr = [NSMutableArray new];
                                    for (int i = 0; i < arrFree.count ; i++) {
                                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]];
                                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf005"]]];
                                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                                           
                                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                           
                                                                           scale:0
                                                                           
                                                                           raiseOnExactness:NO
                                                                           
                                                                           raiseOnOverflow:NO
                                                                           
                                                                           raiseOnUnderflow:NO
                                                                           
                                                                           raiseOnDivideByZero:YES];
                                        
                                        if ([model.k1dt001 isEqualToString:[arrFree[i] valueForKey:@"k7mf004"]]) {
                                            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                                            NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                                            
                                            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                                            BuyModel *buyModel = [BuyModel new];
                                            buyModel.orderCount = zengText;
                                            buyModel.k7mf004 = [arrFree[i] valueForKey:@"k7mf004"];
                                            buyModel.k7mf005 = [arrFree[i] valueForKey:@"k7mf005"];
                                            buyModel.k7mf006 = (int)[arrFree[i] valueForKey:@"k7mf006"];
                                            buyModel.k7mf007 = [arrFree[i] valueForKey:@"k7mf007"];
                                            buyModel.k7mf008 = [arrFree[i] valueForKey:@"k7mf008"];
                                            
                                            buyModel.k7mf009 = [arrFree[i] valueForKey:@"k7mf009"];
                                            buyModel.k7mf010 = [arrFree[i] valueForKey:@"k7mf010"];
                                            buyModel.k7mf011 = [arrFree[i] valueForKey:@"k7mf011"];
                                            buyModel.k7mf012 = [arrFree[i] valueForKey:@"k7mf012"];
                                            buyModel.k7mf016 = [arrFree[i] valueForKey:@"k7mf016"];
                                            buyModel.k7mf017 = [arrFree[i] valueForKey:@"k7mf017"];
                                            [freeArr addObject:buyModel];
                                            if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                                                cellCount = cellCount +1;
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    model.freeDict = [NSMutableDictionary new];
                                    [model.freeDict setValue:freeArr forKey:@"arrFree"];
                                }
                                
                                
                                
                            }
                            NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                            
                            NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
                            NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                            NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]]];
                            sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                            
                            model.sumPrice = sumPrice;
                            CGFloat bottomHei = cellCount *40;
                            model.bottomHei = bottomHei +65;
                            [postArr addObject:model];
                            
                            
                        }
                        [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)i]];
                    }
                    
                    
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = dataDict;
                [self dismiss];
                [self setpei];
                
                
            }else{
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self yuce];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self yuce];
                            
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
        }else{
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
        }
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}

-(void)setCarView {
    NSDecimalNumber *SumorderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    //    istrue = YES;
    callTaleHei = 0;
    NSDecimalNumber *priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i <postArr.count; i++) {
        NewModel *modelTwo = postArr[i];
        //        orderCount = orderCount + modelTwo.orderCount;
        priceNumber = [priceNumber decimalNumberByAdding:modelTwo.sumPrice];
        if (modelTwo.bottomHei == 0) {
            callTaleHei = callTaleHei +65;
        }else{
            callTaleHei = callTaleHei + modelTwo.bottomHei;
        }
        NSInteger xiaoCount = 0;
        if (modelTwo.hasLimiteInfo == true) {
            if (modelTwo.hasBuyTogether == true) {
                NSMutableArray  *buyArr = [NSMutableArray new];
                buyArr = [modelTwo.buyDict valueForKey:@"buyArr"];
                for (int i = 0; i < buyArr.count ; i++) {
                    BuyModel *buyModelOne = buyArr[i];
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModelOne.k7mf005]];
                    
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    
                    
                    NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                    NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                    
                    
                    NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModelOne.k7mf012]] decimalNumberByMultiplyingBy:total];
                    buyModelOne.orderCount = zengText;
                    if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                    }
                    
                    //
                    
                }
                
            }
            
            if (modelTwo.hasPromo == true) {
                NSMutableArray  *promoArr = [NSMutableArray new];
                promoArr = [modelTwo.promDict valueForKey:@"promoArr"];
                for (int i = 0; i < promoArr.count ; i++) {
                    BuyModel *promoModelOne = promoArr[i];
                    
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promoModelOne.k7mf005]];
                    
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                    NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                    
                    NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promoModelOne.k7mf012]] decimalNumberByMultiplyingBy:total];
                    promoModelOne.orderCount = zengText;
                    if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                    }
                }
                
            }
            if (modelTwo.hasFree == true) {
                NSMutableArray *freeArr = [NSMutableArray new];
                freeArr = [modelTwo.freeDict valueForKey:@"arrFree"];
                for (int i = 0; i < freeArr.count ; i++) {
                    BuyModel *freeModelOne = freeArr[i];
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",freeModelOne.k7mf005]];
                    
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    
                    NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                    NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                    
                    
                    NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",freeModelOne.k7mf012]] decimalNumberByMultiplyingBy:total];
                    freeModelOne.orderCount = zengText;
                    if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                    }
                    
                }
                
            }
            modelTwo.jiCount = xiaoCount;
            //            SumorderCount = SumorderCount +modelTwo.jiCount +modelTwo.orderCount;
            
            
        }
        
        SumorderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:SumorderCount afterPoint:lpdt036]];
        SumorderCount = [SumorderCount decimalNumberByAdding:modelTwo.orderCount];
        [postArr replaceObjectAtIndex:i withObject:modelTwo];
    }
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    self.sumLab.text = @"合计:";
    self.orderCountLab.text = [NSString stringWithFormat:@"%lu",(unsigned long)postArr.count];
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.orderCountLab.text FontSize:9 MaxSize:CGSizeMake(20, 20)].width;
    self.orderCountLab.clipsToBounds = YES;
    if (orderWidth >10) {
        self.orderCountLab.frame = CGRectMake(52, -((orderWidth +4)/2), orderWidth+4, orderWidth+4);
        self.orderCountLab.layer.cornerRadius =(orderWidth +4)/2;
    }else {
        self.orderCountLab.layer.cornerRadius = 7.f;
        self.orderCountLab.frame = CGRectMake(52, -((orderWidth +4)/2), 14, 14);
    }
    
    if (postArr.count >0) {
        self.orderCountLab.hidden = NO;
        self.addOrderBth.backgroundColor = kTabBarColor;
        self.addOrderBth.enabled = YES;
        [self.addOrderBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else {
        self.orderCountLab.hidden = YES;
        self.addOrderBth.backgroundColor = kBackGroungColor;
        self.addOrderBth.enabled = NO;
        [self.addOrderBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [self hiddleAllViews];
        istrue = false;
        self.orderCountLab.text = @"";
        self.priceLab.text = @"";
      
        self.orderCountLab.hidden = YES;
        self.sumLab.text = @"";
        
    }
    CGFloat maxHei = self.view.frame.size.height *0.65;
    if (callTaleHei +40 > maxHei) {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - maxHei - 50-40, kScreenSize.width, maxHei+40 );
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width,self.bigView.frame.size.height);
    }else {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50 - callTaleHei-40, kScreenSize.width, callTaleHei +40);
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.bigView.frame));
        
    }
    
    rightorXia = @"xia";
    [self.carTableView reloadData];
    
}

-(void)firstOne {
    [self show];
    [[AFClient shareInstance] GetNew:self.K1mf100 withArr:postOneArr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                NSDictionary *dict = responseBody[@"data"];
                rightDict = responseBody[@"data"];
                jsob001Str = [[responseBody valueForKey:@"data"] valueForKey:@"jsob001"];
                NSArray *dataArr = [dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    [self.datas addObject:titleStr];
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        NewModel *model  = [NewModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        NSDecimalNumber *prict = [dictOne valueForKey:@"originalK1dt201"];
                        model.originalK1dt201 = prict;
                        model.remindStr = @"1";//1为未进行过到货提醒
                        model.maxHei = 0;
                        model.bottomHei = 0;
                          model.orderCount =[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt102"]]];
                        model.originaltest = model.originalK1dt201;
                        model.xianStr = @"1";
                        model.keyStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.index = j;
                        model.indexOne = j;
                        model.ispei = 1;
                        model.minPei = [NSDecimalNumber decimalNumberWithString:@"0"];
                        [model setValuesForKeysWithDictionary:dictOne];
                        
                        [arr addObject:model];
                        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
                            NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                            NSArray *arrFree = [rightDict valueForKey:@"freeActivities"];
                            NSArray *arrpromo= [rightDict valueForKey:@"promoActivities"];
                            NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
                            NSInteger cellCount = 0;
                            if (model.hasLimiteInfo == true) {
                                if (model.hasBuyTogether == true) {
                                    NSMutableArray *buyArr = [NSMutableArray new];
                                    
                                }
                                
                                if (model.hasPromo == true) {
                                    NSMutableArray *promoArr = [NSMutableArray new];
                                    for (int i = 0; i < arrpromo.count ; i++) {
                                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]];
                                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf005"]]];
                                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                                           
                                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                           
                                                                           scale:0
                                                                           
                                                                           raiseOnExactness:NO
                                                                           
                                                                           raiseOnOverflow:NO
                                                                           
                                                                           raiseOnUnderflow:NO
                                                                           
                                                                           raiseOnDivideByZero:YES];
                                        
                                        if ([model.k1dt001 isEqualToString:[arrpromo[i] valueForKey:@"k7mf004"]]) {
                                            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                                            NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                                            
                                            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                                            BuyModel *buyModel = [BuyModel new];
                                            buyModel.orderCount = zengText;
                                            buyModel.k7mf004 = [arrpromo[i] valueForKey:@"k7mf004"];
                                            buyModel.k7mf005 = [arrpromo[i] valueForKey:@"k7mf005"];
                                            buyModel.k7mf006 = (int)[arrpromo[i] valueForKey:@"k7mf006"];
                                            buyModel.k7mf007 = [arrpromo[i] valueForKey:@"k7mf007"];
                                            buyModel.k7mf008 = [arrpromo[i] valueForKey:@"k7mf008"];
                                            
                                            buyModel.k7mf009 = [arrpromo[i] valueForKey:@"k7mf009"];
                                            buyModel.k7mf010 = [arrpromo[i] valueForKey:@"k7mf010"];
                                            buyModel.k7mf011 = [arrpromo[i] valueForKey:@"k7mf011"];
                                            buyModel.k7mf012 = [arrpromo[i] valueForKey:@"k7mf012"];
                                            buyModel.k7mf016 = [arrpromo[i] valueForKey:@"k7mf016"];
                                            buyModel.k7mf017 = [arrpromo[i] valueForKey:@"k7mf017"];
                                            [promoArr addObject:buyModel];
                                            if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                                                cellCount = cellCount +1;
                                                NSString *priceStr = [BGControl notRounding:buyModel.k7mf017 afterPoint:lpdt042];
                                                NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                                                NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:zengText];
                                                sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                                            }
                                            
                                            
                                            
                                        }
                                        
                                        
                                    }
                                    model.promDict = [NSMutableDictionary new];
                                    [model.promDict setValue:promoArr forKey:@"promoArr"];
                                }
                                if (model.hasFree == true) {
                                    NSMutableArray *freeArr = [NSMutableArray new];
                                    for (int i = 0; i < arrFree.count ; i++) {
                                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]];
                                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf005"]]];
                                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                                           
                                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                                           
                                                                           scale:0
                                                                           
                                                                           raiseOnExactness:NO
                                                                           
                                                                           raiseOnOverflow:NO
                                                                           
                                                                           raiseOnUnderflow:NO
                                                                           
                                                                           raiseOnDivideByZero:YES];
                                        
                                        if ([model.k1dt001 isEqualToString:[arrFree[i] valueForKey:@"k7mf004"]]) {
                                            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                                            NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                                            
                                            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                                            BuyModel *buyModel = [BuyModel new];
                                            buyModel.orderCount = zengText;
                                            buyModel.k7mf004 = [arrFree[i] valueForKey:@"k7mf004"];
                                            buyModel.k7mf005 = [arrFree[i] valueForKey:@"k7mf005"];
                                            buyModel.k7mf006 = (int)[arrFree[i] valueForKey:@"k7mf006"];
                                            buyModel.k7mf007 = [arrFree[i] valueForKey:@"k7mf007"];
                                            buyModel.k7mf008 = [arrFree[i] valueForKey:@"k7mf008"];
                                            
                                            buyModel.k7mf009 = [arrFree[i] valueForKey:@"k7mf009"];
                                            buyModel.k7mf010 = [arrFree[i] valueForKey:@"k7mf010"];
                                            buyModel.k7mf011 = [arrFree[i] valueForKey:@"k7mf011"];
                                            buyModel.k7mf012 = [arrFree[i] valueForKey:@"k7mf012"];
                                            buyModel.k7mf016 = [arrFree[i] valueForKey:@"k7mf016"];
                                            buyModel.k7mf017 = [arrFree[i] valueForKey:@"k7mf017"];
                                            [freeArr addObject:buyModel];
                                            if ([[NSString stringWithFormat:@"%@",zengText] integerValue] >0) {
                                                cellCount = cellCount +1;
                                            }
                                            
                                        }
                                        
                                        
                                    }
                                    model.freeDict = [NSMutableDictionary new];
                                    [model.freeDict setValue:freeArr forKey:@"arrFree"];
                                }
                                
                            }
                            NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
                            NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                            NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]]];
                            sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                            
                            model.sumPrice = sumPrice;
                            CGFloat bottomHei = cellCount *40;
                            model.bottomHei = bottomHei +65;
                            [postArr addObject:model];
                            
                        }
                    }
                    
                    [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)i]];
                    
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = dataDict;
                self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
                [self dismiss];
                 [self setpei];
                
                
                
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [self.navigationController popViewControllerAnimated:YES];
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self firstOne];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
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
        [self Alert:@"数据请求失败，请重试!"];
        [self.navigationController popViewControllerAnimated:YES];
        [self dismiss];
    }];
    
}
- (void)setpei{
    
    NSArray *dataArr = [rightDict valueForKey:@"groupDetail"];
    NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
    for (int i = 0; i<self.datas.count; i++) {
        
        NSArray *dictDetail = [dataDict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arr =[NSMutableArray array];
        for (int j = 0; j<dictDetail.count; j++) {
            NewModel *model  = [NewModel new];
            model = dictDetail[j];
            
            if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]&&![BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.orderCount]]) {
                if (model.hasLimiteInfo == true) {
                    if (model.hasBuyTogether == true) {
                        NSMutableArray *buyArr = [NSMutableArray new];
                        for (int m = 0; m < buyTogetherArr.count ; m++) {
                            //现在必备的商品的数量
                            NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]];
                            //倍率
                            NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[m] valueForKey:@"k7mf005"]]];
                            ///现在必备的商品的数量除以倍率
                            NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                               
                                                               decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                               
                                                               scale:0
                                                               
                                                               raiseOnExactness:NO
                                                               
                                                               raiseOnOverflow:NO
                                                               
                                                               raiseOnUnderflow:NO
                                                               
                                                               raiseOnDivideByZero:YES];
                            //找到要必备的商品信息
                            
                            if ([model.k1dt001 isEqualToString:[buyTogetherArr[m] valueForKey:@"k7mf004"]]) {
                                NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                                NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                                //计算出现在必备商品的商品数量
                                NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[m] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                                BuyModel *buyModel =[BuyModel new];
                                buyModel.k7mf007 = [buyTogetherArr[m] valueForKey:@"k7mf007"];
                                NSComparisonResult resultCha = [zengText compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                                //                            if ( resultCha != NSOrderedAscending) {
                                [self buyModel:buyModel withCha:zengText withres:[NSString stringWithFormat:@"%ld",(long)resultCha] withTypr:@"1"];
                            }
                        }
                        
                    }
                    
                    
                }
            }
        }
    }
    [self setCarView];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }
}
-(void)buyModel:(BuyModel *)buyModel withCha:(NSDecimalNumber *)cha withres:(NSString *)str withTypr:(NSString *)type{
    //type 为1 则为初始化  为2 则为重新加减
    for (int m = 0; m < self.datas.count; m++) {
        NSString *indexStr = [NSString stringWithFormat:@"%d",m];
        NSArray *oneArr = [dataDict valueForKey:indexStr];
        for (int n =0; n<oneArr.count; n++) {
            NewModel *bijiaoModel = oneArr[n];
            NSLog(@"buy=%@bijiao=%@",buyModel.k7mf007,bijiaoModel.k1dt001);
            
            if ([bijiaoModel.k1dt001 isEqualToString:buyModel.k7mf007]) {
                
                
                NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                
                bijiaoModel.ispei = 2;
                if ([str isEqualToString:@"-1"]) {
                    bijiaoModel.minPei = [bijiaoModel.minPei decimalNumberByAdding:cha];
                    if ([type isEqualToString:@"2"]) {
                        bijiaoModel.orderCount = [bijiaoModel.orderCount decimalNumberByAdding:cha];
                    }
                    
                }else{
                    
                    if ([type isEqualToString:@"2"]) {
                        bijiaoModel.orderCount = [bijiaoModel.orderCount decimalNumberByAdding:cha];
                    }
                    bijiaoModel.minPei = [bijiaoModel.minPei decimalNumberByAdding:cha];
                }
                
                NSInteger indexNum = 0;
                NSMutableArray *arr = [NSMutableArray array];
                for (NewModel *oneModel in postArr) {
                    [arr addObject:oneModel.k1dt001];
                }
                
                
                if ([arr containsObject:bijiaoModel.k1dt001]) {
                    NSInteger index = [arr indexOfObject:bijiaoModel.k1dt001];
                    peiCount = peiCount - 1;
                    [postArr  removeObjectAtIndex:index];
                }
                indexNum = postArr.count;
                NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                NSString *priceStr = [BGControl notRounding:bijiaoModel.originaltest afterPoint:lpdt042];
                NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:bijiaoModel.orderCount];
                sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                bijiaoModel.sumPrice = sumPrice;
                if ([bijiaoModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                    [postArr insertObject:bijiaoModel atIndex:indexNum];
                }
                peiCount = postArr.count;
                
            }
        }
    }
}

- (void)first {
    
    
    if (self.dict) {
        //         NSString * isEnableJsob = [self.dict[@"isEnableJsob"] stringValue];
        ////        BOOL isEnableSalesForecast = self.dict[@"isEnableSalesForecast"];
        if ([[self.dict[@"isEnableJsob"] stringValue] isEqualToString:@"1"]) {
            self.tanView.hidden = NO;
            [self.view addSubview:self.tanView];
        }
        if ([[self.dict[@"isEnableSalesForecast"] stringValue]isEqualToString:@"0"]) {
            self.forecastBth.hidden = YES;
            self.forecastLab.hidden = YES;
        }
    }
    
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
       
    }
    
    if (!isPrice) {
        self.priceLab.hidden = YES;
        self.sumLab.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
        self.sumLab.hidden = NO;
    }
    self.addOrderBth.enabled = NO;
    
    self.carTableView.delegate = self;
    self.carTableView.dataSource = self;
    istrue = NO;
    self.carTableView.hidden = YES;
    self.bigView.hidden = YES;
    self.topview.clipsToBounds = YES;
    self.topview.layer.cornerRadius = 15.f;
    CGFloat marginWidth = 15;
    CGFloat marginHei = 20;
    CGFloat oneWidth = (kScreenSize.width - 45-40)/2;
    CGFloat oneHei = 40;
    NSArray *arr = @[@"采购经理",@"门店主管",@"服务员",@"厨师"];
    
    for ( int i = 0; i<arr.count; i++) {
        UILabel * lab = [[UILabel alloc] init];
        //        view.backgroundColor = [UIColor redColor];
        lab.frame = CGRectMake((i%2)*(marginWidth+oneWidth) +15, i/2*(40+marginHei) +60,oneWidth  , 40);
        lab.text = arr[i];
        lab.backgroundColor = [UIColor whiteColor];
        lab.clipsToBounds = YES;
        lab.layer.cornerRadius = 20.f;
        lab.layer.borderWidth = 1.f;
        lab.textColor = kTextGrayColor;
        lab.layer.borderColor = [kTabBarColor CGColor];
        lab.textAlignment = NSTextAlignmentCenter;
        [self.tanView addSubview:lab];
        self.tanView.hidden = YES;
           }
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.backgroundColor = kBackGroungColor;
    self.carTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.carTableView.backgroundColor = kBackGroungColor;
    
    [self.carTableView setTableHeaderView:self.topView];

    NSInteger  one = arr.count / 2;
    NSInteger add = 0;
    if (arr.count%2 == 1) {
        one = one +1;
    };
    
    self.tanView.hidden = YES;
    self.tanView.frame = CGRectMake(0, 0, kScreenSize.width-40, 60 +one*(40+15)+20 );
    self.tanView.center = self.view.center;
}

- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - private
- (void)setBaseTableView {
    // leftTableView
    
    
    // rightTableView
    self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 60, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 110);
    // 默认选择左边tableView的第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)selectLeftTableViewWithScrollView:(UIScrollView *)scrollView {
    if (self.currentSelectIndexPath) {
        return;
    }
    // 如果现在滑动的是左边的tableView，不做任何处理
    if ((UITableView *)scrollView == self.leftTableView) return;
    // 滚动右边tableView，设置选中左边的tableView某一行。indexPathsForVisibleRows属性返回屏幕上可见的cell的indexPath数组，利用这个属性就可以找到目前所在的分区
    if ((UITableView *)scrollView == self.carTableView) return;
    
    if (self.datas.count > 0) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.rightTableView.indexPathsForVisibleRows.firstObject.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];
    }
    
}

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView)
    {
        return 1;
    }else if (tableView == self.rightTableView){
        
        return self.datas.count;
    }else {
        return 1;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView){
        return self.datas.count;
    }else if (tableView == self.rightTableView){
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)section]];
        return arr.count;
    }else {
        return postArr.count;
    }
    
    
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return nil;
//    return self.datas[section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == self.leftTableView){
        static NSString *ID = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.textLabel.text = self.datas[indexPath.row];
        cell.textLabel.textColor = kTextGrayColor;
        cell.textLabel.highlightedTextColor = kTabBarColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.backgroundView.backgroundColor = kBackGroungColor;
        cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        cell.textLabel.numberOfLines = 0;
        return cell;
    }
    else if (tableView == self.rightTableView) {
        //        if ([model.xianStr isEqualToString:@"1"]) {
        // 通过不同标识创建cell实例
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        CallOrderTwoCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            _twoCell = [[CallOrderTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            CGRect cellFrame = _twoCell.contentView.frame;
            cellFrame.size.width = kScreenSize.width-100;
            [_twoCell.contentView setFrame:cellFrame];
            
        }
        
        
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _twoCell.reminDelegate = self;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        NewModel *model = arr[indexPath.row];
        
        [_twoCell showModel:model withDict:self.dict widtRight:rightDict withKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section] withIndex:indexPath.row];
        _twoCell.delegate = self;
        _twoCell.orderDelegate = self;
        _twoCell.TanDelegate = self;
        
        
        
        //    XyModel *model = self.dataArray[indexPath.row];
        //        [_twoCell showModel];
        return _twoCell;
        
        //        }
        
        //        cell.textLabel.text = [NSString stringWithFormat:@"%@ ----- 第%zd行", self.datas[indexPath.section], indexPath.row + 1];
    }else {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        CallOrderOneCell  * _oneCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_oneCell) {
            _oneCell = [[CallOrderOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
  
        }
        CGRect cellFrame = _oneCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width;
        [_oneCell.contentView setFrame:cellFrame];
        _oneCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_oneCell.frame];
        _oneCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _oneCell.peiDelegate = self;
        _oneCell.proDelegate = self;
        _oneCell.tanDelegate = self;
        _oneCell.tanLitterDelegate = self;
        
        NewModel *model = postArr[indexPath.row];
        [_oneCell showModel:model withDict:self.dict widtRight:rightDict withselfIndex:indexPath.row withIndex:model.index];
        _oneCell.Bottomdelegate = self;
        _oneCell.orderDelegate = self;
        
        //    XyModel *model = self.dataArray[indexPath.row];
        //        [_twoCell showModel];
        
        return _oneCell;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果点击的是右边的tableView，不做任何处理
    if (tableView == self.rightTableView)
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else if(tableView == self.leftTableView) {
        // 点击左边的tableView，设置选中右边的tableView某一行。左边的tableView的每一行对应右边tableView的每个分区
        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
        UITableViewCell * cell = [self.rightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView.backgroundColor = kBackGroungColor;
        cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        UITableViewCell * cellone = [self.rightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.currentSelectIndexPath = indexPath;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return 70;
    }else if (tableView == self.rightTableView){
        //        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        //  CallOrderTwoCell *cell = (CallOrderTwoCell *)[tableView cellForRowAtIndexPath:indexPath];
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        NewModel *model = arr[indexPath.row];
        //        __weak __typeof(&*cell) weakCell = cell;
        CGFloat hei = 0;
        
        //        cell.xiablock = ^(CGFloat nCount, BOOL boo){
        ////                        weakCell.orderCountLab.text = [NSString stringWithFormat:@"%ld",nCount];
        //          __block  hei = nCount ;
        //                    };
        if (model.hasLimiteInfo == true) {
            if (model.maxHei !=0) {
                if (kScreenSize.width == 320) {
                    return 154+model.maxHei-20 +20;
                }
                return 154+model.maxHei +20;
            }else{
                if (kScreenSize.width == 320) {
                    return 150 +20;
                }
                return 170 +20;
            }
        }else {
            if (kScreenSize.width == 320) {
                return 134 + 20;
            }
            return 154 +30;
        }
        
    }else {
        NewModel *model = postArr[indexPath.row];
        CGFloat hei;
        if (model.bottomHei !=0) {
            hei = model.bottomHei;
        }else{
            hei = 65;
        }
        //        callTaleHei = callTaleHei +hei;
        return hei;
    }
}

//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return 0;
//    return 30;
//}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 重新选中一下当前选中的行数，不然会有bug
    if (self.currentSelectIndexPath) self.currentSelectIndexPath = nil;
}


- (IBAction)buttonClick:(UIButton *)sender {
    if (isFan) {
         [self.navigationController popViewControllerAnimated:YES];
    }else {
        self.forecastBth.enabled = YES;
        self.forecastLab.hidden = NO;
        self.searchTitleLab.text = @"";
        self.searchLab.hidden = NO;
        self.searchImg.hidden = NO;
        dataDict = [[NSMutableDictionary alloc] init];
        for (int i = 0; i<self.ruleArr.count; i++) {
            NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            for (int j = 0; j<arrTwo.count; j++) {
                NewModel *model = arrTwo[j];
                model.xianStr = @"1";
                [arr addObject:model];
                
            }
            [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];
        }
        
        
        self.ruleDita = [[NSMutableDictionary alloc] init];
        self.ruleDita = dataDict;
        self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
        [self.rightTableView reloadData];
        [self.leftTableView reloadData];
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        isFan = YES;
    }
   
}
-(void)getwithKey:(NSString *)key withIndex:(NSInteger)index withModel:(NewModel *)model withweizhi:(NSString *)weizhi {
    rightorXia = weizhi;
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"orderCountView" owner:self options:nil];
    self.blackButton.hidden = NO;
    orderView = [nib firstObject];
    orderView.clipsToBounds = YES;
    CGRect ipRect = orderView.frame;
    ipRect.size.width = kScreenSize.width - 40;
    [orderView setFrame:ipRect];
    orderView.subMitBth.clipsToBounds = YES;
    orderView.subMitBth.layer.cornerRadius = 10.f;
    orderView.center = self.view.center;
    orderView.bigView.clipsToBounds = YES;
    orderView.bigView.layer.borderColor = [kLineColor CGColor];
    orderView.bigView.layer.cornerRadius = 5.f;
    orderView.bigView.layer.borderWidth = 1.0f;
    orderView.layer.cornerRadius = 5.f;
    orderView.keyStr = key;
    orderView.index = index;
    orderView.model = model;
    orderView.dict = rightDict;
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    orderView.OrderDelegate = self;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];
    
    
}
- (void)getWithModel:(NewModel *)model withTag:(NSString *)tag withIndex:(NSInteger)index withType:(NSString *)type {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"orderTwoView" owner:self options:nil];
    self.blackButton.hidden = YES;
    self.blackButton.hidden = NO;
    orderConutTwoView = [nib firstObject];
    orderConutTwoView.clipsToBounds = YES;
    CGRect ipRect = orderConutTwoView.frame;
    ipRect.size.width = kScreenSize.width - 40;
    [orderConutTwoView setFrame:ipRect];
    orderConutTwoView.subMitBth.clipsToBounds = YES;
    orderConutTwoView.subMitBth.layer.cornerRadius = 10.f;
    orderConutTwoView.center = self.view.center;
    orderConutTwoView.bigView.clipsToBounds = YES;
    orderConutTwoView.bigView.layer.borderColor = [kLineColor CGColor];
    orderConutTwoView.bigView.layer.cornerRadius = 5.f;
    orderConutTwoView.bigView.layer.borderWidth = 1.0f;
    orderConutTwoView.layer.cornerRadius = 5.f;
    
    orderConutTwoView.model = model;
    orderConutTwoView.dict = rightDict;
    orderConutTwoView.tag = tag;
    orderConutTwoView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    orderConutTwoView.prooneDelegate = self;
    orderConutTwoView.PeiDelegate = self;
    orderConutTwoView.index = index;
    orderConutTwoView.typeStr = type;
    [orderConutTwoView.orderFile becomeFirstResponder];
    [self.view addSubview:orderConutTwoView];
    
    
    
}
- (void)getpro:(NSMutableArray *)payArr withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount {
    [self hiddleOne];
    NSString *str = [NSString stringWithFormat:@"%@",dec];
    if (![BGControl isNULLOfString:str]) {
        //        if ([str isEqualToString:@"0"]) {
        //            <#statements#>
        //        }
        [self Alert:[NSString stringWithFormat:@"%@",@"不能高于最高促销数量"]];
    }else {
        NewModel *model = postArr[index];
        NSArray *proArr = [model.promDict valueForKey:@"promoArr"];
        NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
        NSDecimalNumber *yuanPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber * nowPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
        for (int i = 0; i< proArr.count; i++) {
            BuyModel *buyModel = proArr[i];
            NSString *priceStr = [BGControl notRounding:[proArr[i] valueForKey:@"k7mf017"] afterPoint:lpdt042];
            NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
            NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[proArr[i] valueForKey:@"orderCount"]];
            nowPrice = [nowPrice decimalNumberByAdding:onePrice];
            
            
            NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",yuanCount]];
            NSDecimalNumber *yuanonePrice = [singlePrice decimalNumberByMultiplyingBy:dec];
            yuanPrice = [yuanPrice decimalNumberByAdding:yuanonePrice];
        }
        
        NSDecimalNumber *jianyuan = [model.sumPrice decimalNumberBySubtracting:yuanPrice];
        model.sumPrice = [jianyuan decimalNumberByAdding:nowPrice];
        NSInteger yuanCountone = [[NSString stringWithFormat:@"%@",yuanCount] integerValue];
        NSInteger nowCountone = [[NSString stringWithFormat:@"%@",nowCount] integerValue];
        model.jiCount = model.jiCount-yuanCountone+nowCountone;
        [model.promDict setValue:payArr forKey:@"promoArr"];
        [postArr replaceObjectAtIndex:index withObject:model];
        //        callTaleHei = 0;
        NSDecimalNumber  *priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber  *sunCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSInteger shopCount = 0;
        for (int i = 0; i <postArr.count; i++) {
            NewModel *modelTwo = postArr[i];
            
            priceNumber = [priceNumber decimalNumberByAdding:modelTwo.sumPrice];
            //            sunCount = sunCount +modelTwo.orderCount+modelTwo.jiCount;
            sunCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:sunCount afterPoint:lpdt036]];
            sunCount = [sunCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]]];
            //计算所有品相项的数量
            NSArray *freeArr = [modelTwo.freeDict valueForKey:@"arrFree"];
            NSArray *promArr = [modelTwo.promDict valueForKey:@"promoArr"];
            NSArray *buyArr = [modelTwo.buyDict valueForKey:@"buyArr"];
            shopCount = freeArr.count + promArr.count + buyArr.count +shopCount;
        }
//        self.orderCountLab.text = [NSString stringWithFormat:@"%ld",shopCount+postArr.count];
        self.orderCountLab.text = [NSString stringWithFormat:@"%ld",postArr.count];
        self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
        self.sumLab.text = @"合计:";
        [self.carTableView reloadData];
    }
    
}
-(void)getpei:(NSMutableArray *)payArr withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount {
    //  [postArr replaceObjectAtIndex:index withObject:modelOne];
    
    [self hiddleOne];
    
    NSString *str = [NSString stringWithFormat:@"%@",dec];
    if (![BGControl isNULLOfString:str]) {
        [self Alert:[NSString stringWithFormat:@"%@",@"不能低于最低必配数量"]];
    }else {
        NewModel *model = postArr[index];
        NSArray *peiArr = [model.buyDict valueForKey:@"buyArr"];
        NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
        NSDecimalNumber *yuanPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber * nowPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
        for (int i = 0; i< peiArr.count; i++) {
            BuyModel *buyModel = peiArr[i];
            NSString *priceStr = [BGControl notRounding:[peiArr[i] valueForKey:@"k7mf017"] afterPoint:lpdt042];
            NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
            NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[peiArr[i] valueForKey:@"orderCount"]];
            nowPrice = [nowPrice decimalNumberByAdding:onePrice];
            NSDecimalNumber *yuanonePrice = [singlePrice decimalNumberByMultiplyingBy:buyModel.orderCount];
            yuanPrice = [yuanPrice decimalNumberByAdding:yuanonePrice];
        }
        
        NSDecimalNumber *jianyuan = [model.sumPrice decimalNumberBySubtracting:yuanPrice];
        model.sumPrice = [jianyuan decimalNumberBySubtracting:nowPrice];
        NSInteger yuanCountone = [[NSString stringWithFormat:@"%@",yuanCount] integerValue];
        NSInteger nowCountone = [[NSString stringWithFormat:@"%@",nowCount] integerValue];
        model.jiCount = model.jiCount-yuanCountone+nowCountone;
        [model.buyDict setValue:payArr forKey:@"buyArr"];
        [postArr replaceObjectAtIndex:index withObject:model];
        NSDecimalNumber  *priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber *sunCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSInteger shopCount = 0;
        for (int i = 0; i <postArr.count; i++) {
            NewModel *modelTwo = postArr[i];
            
            
            priceNumber = [priceNumber decimalNumberByAdding:modelTwo.sumPrice];
            //            sunCount = sunCount +modelTwo.orderCount+modelTwo.jiCount;
            sunCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:sunCount afterPoint:lpdt036]];
            sunCount = [sunCount decimalNumberByAdding:modelTwo.orderCount];
            NSArray *freeArr = [modelTwo.freeDict valueForKey:@"arrFree"];
            NSArray *promArr = [modelTwo.promDict valueForKey:@"promoArr"];
            NSArray *buyArr = [modelTwo.buyDict valueForKey:@"buyArr"];
            shopCount = freeArr.count + promArr.count + buyArr.count +shopCount;
            //            sunCount = sunCount +modelTwo.orderCount;
            
        }
        self.orderCountLab.text = [NSString stringWithFormat:@"%ld",postArr.count];
        self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
        self.sumLab.text = @"合计:";
        
        [self.carTableView reloadData];
    }
    
    
    
}

- (void)getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price withStr:(NSString *)str {
//    if ([[NSString stringWithFormat:@"%@",count] isEqualToString:@"0"]) {
//        return;
//    }
    NSInteger cellCount = 0;
    NSDecimalNumber *peiShopCount;
    peiCount = postArr.count;
    if ([rightorXia isEqualToString:@"xia"]) {
        [self hiddleOne];
        
    }else{
        
        [self hiddleAllViews];
    }
    if (![BGControl isNULLOfString:str]) {
           [self Alert:str];
  
    }
    
    NSInteger xiaoCount = 0;
    NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSArray *arrFree = [rightDict valueForKey:@"freeActivities"];
    NSArray *arrpromo= [rightDict valueForKey:@"promoActivities"];
    NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:key];
    
    NewModel *model = oneArr[index];
    if (model.ispei == 2) {
        NSComparisonResult result = [count compare:model.minPei];
        if (result == NSOrderedAscending) {
            
            return;
        }
    }
    
    NSMutableArray *arr = [NSMutableArray new];
    for (NewModel *oneModel in postArr) {
        [arr addObject:oneModel.k1dt001];
    }
    
    
    if ([arr containsObject:model.k1dt001]) {
        //在postArr的数组中找到k1dt001这个商品
        NSInteger index = [arr indexOfObject:model.k1dt001];
        if (count) {
          
            NewModel *modelOne = postArr[index];
            //原先的这个商品的数量
            peiShopCount  = modelOne.orderCount;
            modelOne.orderCount = count;
           
            modelOne.originaltest = price;
            NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
            
            NSString *priceStr = [BGControl notRounding:modelOne.originaltest afterPoint:lpdt042];
            NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
            NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelOne.orderCount]]];
            sumPrice = [sumPrice decimalNumberByAdding:onePrice];
            modelOne.sumPrice = sumPrice;
            
            if (modelOne.hasLimiteInfo == true) {
                if (modelOne.hasBuyTogether == true) {
                    NSMutableArray  *buyArr = [NSMutableArray new];
                    buyArr = [modelOne.buyDict valueForKey:@"buyArr"];
                    for (int i = 0; i < buyTogetherArr.count ; i++) {
                        //现在必备的商品的数量
                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                        //倍率
                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[i] valueForKey:@"k7mf005"]]];
                        ///现在必备的商品的数量除以倍率
                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                           
                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                           
                                                           scale:0
                                                           
                                                           raiseOnExactness:NO
                                                           
                                                           raiseOnOverflow:NO
                                                           
                                                           raiseOnUnderflow:NO
                                                           
                                                           raiseOnDivideByZero:YES];
                        //找到要必备的商品信息
                        
                        if ([model.k1dt001 isEqualToString:[buyTogetherArr[i] valueForKey:@"k7mf004"]]) {
                            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                            NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                            //计算出现在必备商品的商品数量
                            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                            //上一次的必备的商品的数量除以倍率
                            NSDecimalNumber *chuTwo =  [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",peiShopCount]] decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",meijiao]]];

                              NSDecimalNumber *zengTextTwo = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:chuTwo];
                            //计算两次最低必配商品的差值
                            NSDecimalNumber *chaCount = [zengText decimalNumberBySubtracting: zengTextTwo];
                          
//                            buyModel.orderCount = zengText;
                           BuyModel *buyModel =[BuyModel new];
                            buyModel.k7mf007 = [buyTogetherArr[i] valueForKey:@"k7mf007"];
                            // NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
//                            xiaoCount = xiaoCount +count;
                            NSComparisonResult resultCha = [chaCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
//                            if ( resultCha != NSOrderedAscending) {
                            [self buyModel:buyModel withCha:chaCount withres:[NSString stringWithFormat:@"%ld",(long)resultCha] withType:@"2"];
//                            }
                            
                            
                        }
                        
                    }
                    
                }
                
                if (modelOne.hasPromo == true) {
                    NSMutableArray  *promoArr = [NSMutableArray new];
                    promoArr = [modelOne.promDict valueForKey:@"promoArr"];
                    for (int i = 0; i < promoArr.count ; i++) {
                        BuyModel *promoModelOne = promoArr[i];
                        
                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promoModelOne.k7mf005]];
                        
                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                           
                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                           
                                                           scale:0
                                                           
                                                           raiseOnExactness:NO
                                                           
                                                           raiseOnOverflow:NO
                                                           
                                                           raiseOnUnderflow:NO
                                                           
                                                           raiseOnDivideByZero:YES];
                        
                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                        NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                        NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                        
                        NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promoModelOne.k7mf012]] decimalNumberByMultiplyingBy:total];
//                        promoModelOne.orderCount = zengText;
                        
                        cellCount = cellCount +1;
                        NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                        
                        NSString *priceStr = [BGControl notRounding:promoModelOne.k7mf017 afterPoint:lpdt042];
                        NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                        NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:promoModelOne.orderCount];
                        sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                        
                        [[modelOne.promDict valueForKey:@"promoArr"] replaceObjectAtIndex:i withObject:promoModelOne];
                        //
                        
                        
                    }
                    
                }
                if (modelOne.hasFree == true) {
                    NSMutableArray *freeArr = [NSMutableArray new];
                    freeArr = [modelOne.freeDict valueForKey:@"arrFree"];
                    for (int i = 0; i < freeArr.count ; i++) {
                        BuyModel *freeModelOne = freeArr[i];
                        NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                        NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",freeModelOne.k7mf005]];
                        
                        NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                           
                                                           decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                           
                                                           scale:0
                                                           
                                                           raiseOnExactness:NO
                                                           
                                                           raiseOnOverflow:NO
                                                           
                                                           raiseOnUnderflow:NO
                                                           
                                                           raiseOnDivideByZero:YES];
                        NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                        
                        NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                        NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                        
                        
                        NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",freeModelOne.k7mf012]] decimalNumberByMultiplyingBy:total];
                        freeModelOne.orderCount = zengText;
                        
                        cellCount = cellCount +1;
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                        
                        [[modelOne.freeDict valueForKey:@"arrFree"] replaceObjectAtIndex:i withObject:freeModelOne];
                        
                    }
                    
                }
                CGFloat bottomHei = cellCount *40;
                modelOne.bottomHei = bottomHei +65;
                modelOne.sumPrice = sumPrice;
                modelOne.sumPrice = sumPrice;
                modelOne.jiCount = xiaoCount;
                [postArr replaceObjectAtIndex:index withObject:modelOne];
            }
            
            if (!([count compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending)) {
                  [postArr removeObjectAtIndex:index];
            }
            
            
        }else {
            [postArr removeObjectAtIndex:index];
        }
        
    }else{
        
        
        if (model.hasLimiteInfo == true) {
            if (model.hasBuyTogether == true) {
                NSMutableArray *buyArr = [NSMutableArray new];
                for (int i = 0; i < buyTogetherArr.count ; i++) {
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[i] valueForKey:@"k7mf005"]]];
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    
                    if ([model.k1dt001 isEqualToString:[buyTogetherArr[i] valueForKey:@"k7mf004"]]) {
                        NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                        NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                        
                        NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[buyTogetherArr[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                        BuyModel *buyModel = [BuyModel new];
                        buyModel.orderCount = zengText;
                        buyModel.k7mf004 = [buyTogetherArr[i] valueForKey:@"k7mf004"];
                        buyModel.k7mf005 = [buyTogetherArr[i] valueForKey:@"k7mf005"];
                        buyModel.k7mf006 = (int)[buyTogetherArr[i] valueForKey:@"k7mf006"];
                        buyModel.k7mf007 = [buyTogetherArr[i] valueForKey:@"k7mf007"];
                        buyModel.k7mf008 = [buyTogetherArr[i] valueForKey:@"k7mf008"];
                        
                        buyModel.k7mf009 = [buyTogetherArr[i] valueForKey:@"k7mf009"];
                        buyModel.k7mf010 = [buyTogetherArr[i] valueForKey:@"k7mf010"];
                        buyModel.k7mf011 = [buyTogetherArr[i] valueForKey:@"k7mf011"];
                        buyModel.k7mf012 = [buyTogetherArr[i] valueForKey:@"k7mf012"];
                        buyModel.k7mf016 = [buyTogetherArr[i] valueForKey:@"k7mf016"];
                        buyModel.k7mf017 = [buyTogetherArr[i] valueForKey:@"k7mf017"];
                        [buyArr addObject:buyModel];
                        
//                        cellCount = cellCount +1;
//                      NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
//                        xiaoCount = xiaoCount +count;
                        [self buyModel:buyModel withCha:buyModel.orderCount withres:@"yes" withType:@"2"];
                        
                    }
                    
                }
                model.buyDict = [NSMutableDictionary new];
                //                [model.buyDict setValue:buyArr forKey:@"buyArr"];
                
            }
            
            if (model.hasPromo == true) {
                NSMutableArray *promoArr = [NSMutableArray new];
                for (int i = 0; i < arrpromo.count ; i++) {
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf005"]]];
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    
                    if ([model.k1dt001 isEqualToString:[arrpromo[i] valueForKey:@"k7mf004"]]) {
                        NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                        NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                        
                        NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrpromo[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                        BuyModel *buyModel = [BuyModel new];
//                        buyModel.orderCount = zengText;
                         buyModel.orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                        buyModel.k7mf004 = [arrpromo[i] valueForKey:@"k7mf004"];
                        buyModel.k7mf005 = [arrpromo[i] valueForKey:@"k7mf005"];
                        buyModel.k7mf006 = (int)[arrpromo[i] valueForKey:@"k7mf006"];
                        buyModel.k7mf007 = [arrpromo[i] valueForKey:@"k7mf007"];
                        buyModel.k7mf008 = [arrpromo[i] valueForKey:@"k7mf008"];
                        
                        buyModel.k7mf009 = [arrpromo[i] valueForKey:@"k7mf009"];
                        buyModel.k7mf010 = [arrpromo[i] valueForKey:@"k7mf010"];
                        buyModel.k7mf011 = [arrpromo[i] valueForKey:@"k7mf011"];
                        buyModel.k7mf012 = [arrpromo[i] valueForKey:@"k7mf012"];
                        buyModel.k7mf016 = [arrpromo[i] valueForKey:@"k7mf016"];
                        buyModel.k7mf017 = [arrpromo[i] valueForKey:@"k7mf017"];
                        [promoArr addObject:buyModel];
                        
                        cellCount = cellCount +1;
                        NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                        NSString *priceStr = [BGControl notRounding:buyModel.k7mf017 afterPoint:lpdt042];
                        NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                        NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:buyModel.orderCount];
                        sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                        
                        
                        
                        
                    }
                    
                    
                }
                model.promDict = [NSMutableDictionary new];
                [model.promDict setValue:promoArr forKey:@"promoArr"];
            }
            if (model.hasFree == true) {
                NSMutableArray *freeArr = [NSMutableArray new];
                for (int i = 0; i < arrFree.count ; i++) {
                    NSDecimalNumber *orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
                    NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf005"]]];
                    NSDecimalNumber *chu =  [orderCount decimalNumberByDividingBy:meijiao];
                    NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                       
                                                       decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                       
                                                       scale:0
                                                       
                                                       raiseOnExactness:NO
                                                       
                                                       raiseOnOverflow:NO
                                                       
                                                       raiseOnUnderflow:NO
                                                       
                                                       raiseOnDivideByZero:YES];
                    
                    if ([model.k1dt001 isEqualToString:[arrFree[i] valueForKey:@"k7mf004"]]) {
                        NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                        NSDecimalNumber *total = [chu decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                        
                        NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrFree[i] valueForKey:@"k7mf012"]]] decimalNumberByMultiplyingBy:total];
                        BuyModel *buyModel = [BuyModel new];
                        buyModel.orderCount = zengText;
                        buyModel.k7mf004 = [arrFree[i] valueForKey:@"k7mf004"];
                        buyModel.k7mf005 = [arrFree[i] valueForKey:@"k7mf005"];
                        buyModel.k7mf006 = (int)[arrFree[i] valueForKey:@"k7mf006"];
                        buyModel.k7mf007 = [arrFree[i] valueForKey:@"k7mf007"];
                        buyModel.k7mf008 = [arrFree[i] valueForKey:@"k7mf008"];
                        
                        buyModel.k7mf009 = [arrFree[i] valueForKey:@"k7mf009"];
                        buyModel.k7mf010 = [arrFree[i] valueForKey:@"k7mf010"];
                        buyModel.k7mf011 = [arrFree[i] valueForKey:@"k7mf011"];
                        buyModel.k7mf012 = [arrFree[i] valueForKey:@"k7mf012"];
                        buyModel.k7mf016 = [arrFree[i] valueForKey:@"k7mf016"];
                        buyModel.k7mf017 = [arrFree[i] valueForKey:@"k7mf017"];
                        [freeArr addObject:buyModel];
                        
                        cellCount = cellCount +1;
                        NSInteger count = [[NSString stringWithFormat:@"%@",zengText] integerValue];
                        xiaoCount = xiaoCount +count;
                        
                        
                    }
                    
                    
                }
                model.freeDict = [NSMutableDictionary new];
                [model.freeDict setValue:freeArr forKey:@"arrFree"];
            }
            
        }
       
       
        NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
        
        NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
        NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
        NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]]];
        sumPrice = [sumPrice decimalNumberByAdding:onePrice];
        
        model.sumPrice = sumPrice;
        model.jiCount = xiaoCount;
        CGFloat bottomHei = cellCount *40;
        model.bottomHei = bottomHei +65;
        model.orderCount = count;
        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
             [postArr insertObject:model atIndex:postArr.count-peiCount];
        }
       
        
        
    }
    model.orderCount = count;
    model.originaltest = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",price]];
    //    [[dataDict valueForKey:model.keyOneStr] replaceObjectAtIndex:model.indexOne withObject:model];
    [[self.ruleDita valueForKey:key] replaceObjectAtIndex:index withObject:model];

    NSDecimalNumber  *orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    callTaleHei = 0;
    NSDecimalNumber *priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSInteger shopCount = 0;
    for (int i = 0; i <postArr.count; i++) {
        NewModel *modelTwo = postArr[i];
        //        orderCount = orderCount + modelTwo.orderCount +modelTwo.jiCount;
        
        orderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:orderCount afterPoint:lpdt036]];
        
        orderCount =  [orderCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]]];
        
        priceNumber = [priceNumber decimalNumberByAdding:modelTwo.sumPrice];
        if (modelTwo.bottomHei == 0) {
            callTaleHei = callTaleHei +65;
        }else{
            callTaleHei = callTaleHei + modelTwo.bottomHei;
        }
        NSArray *freeArr = [modelTwo.freeDict valueForKey:@"arrFree"];
        NSArray *promArr = [modelTwo.promDict valueForKey:@"promoArr"];
        //当赠送商品数量不为0才显示
        NSInteger freeCount = 0;
        for (int t = 0; t<freeArr.count; t++) {
            BuyModel *freeModel= freeArr[t];
            if (![[NSString stringWithFormat:@"%@",freeModel.orderCount] isEqualToString:@"0"]) {
                freeCount ++;
            }
        }
        
//        shopCount = freeCount + promArr.count  +shopCount;
        
    }
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    self.sumLab.text = @"合计:";
    //    self.orderCountLab.text = [NSString stringWithFormat:@"%@",orderCount];
    self.orderCountLab.text = [NSString stringWithFormat:@"%ld",postArr.count];
    
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.orderCountLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
    self.orderCountLab.clipsToBounds = YES;
    if (orderWidth >10) {
        self.orderCountLab.frame = CGRectMake(52, -((orderWidth +4)/2), orderWidth+4, orderWidth+4);
        self.orderCountLab.layer.cornerRadius =(orderWidth +4)/2;
    }else {
        self.orderCountLab.layer.cornerRadius = 7.f;
        self.orderCountLab.frame = CGRectMake(52, -((orderWidth +4)/2), 14, 14);
    }
    
    if (postArr.count >0) {
        self.orderCountLab.hidden = NO;
        self.addOrderBth.backgroundColor = kTabBarColor;
        self.addOrderBth.enabled = YES;
        [self.addOrderBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else {
        self.orderCountLab.hidden = YES;
        self.addOrderBth.backgroundColor = kBackGroungColor;
        self.addOrderBth.enabled = NO;
        [self.addOrderBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [self hiddleAllViews];
        istrue = false;
        self.orderCountLab.text = @"";
        self.priceLab.text = @"";
        
        self.orderCountLab.hidden = YES;
        self.sumLab.text = @"";
        
    }
    CGFloat maxHei = self.view.frame.size.height *0.65;
    if (callTaleHei +40 > maxHei) {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - maxHei - 50-40, kScreenSize.width, maxHei+40 );
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width,self.bigView.frame.size.height);
    }else {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50 - callTaleHei-40, kScreenSize.width, callTaleHei +40);
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.bigView.frame));
        
    }
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            NewModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            countOne = countOne+1;
            [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    
    
    [self.carTableView reloadData];
    //     [self.carTableView setContentOffset:CGPointMake(kScreenSize.width, CGFLOAT_MAX)];
    //     [self.carTableView sizeThatFits:CGSizeMake(CGRectGetWidth(self.carTableView.bounds), CGFLOAT_MAX)];
    [self.rightTableView reloadData];
    
    
    
}

-(void)buyModel:(BuyModel *)buyModel withCha:(NSDecimalNumber *)cha withres:(NSString *)str withType:(NSString *)type{
    //typeW为1则为初始化 不需要重新计算必配商品的数量  为2重新计算
    
    for (int m = 0; m < self.datas.count; m++) {
        NSString *indexStr = [NSString stringWithFormat:@"%d",m];
        NSArray *oneArr = [dataDict valueForKey:indexStr];
        for (int n =0; n<oneArr.count; n++) {
            NewModel *bijiaoModel = oneArr[n];
            NSLog(@"buy=%@bijiao=%@",buyModel.k7mf007,bijiaoModel.k1dt001);
            //找到对应的商品
            if ([bijiaoModel.k1dt001 isEqualToString:buyModel.k7mf007]) {
                
               
                NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
                
                bijiaoModel.ispei = 2;
                if ([str isEqualToString:@"-1"]) {
                     bijiaoModel.minPei = [bijiaoModel.minPei decimalNumberByAdding:cha];
                    if ([type isEqualToString:@"2"]) {
                         bijiaoModel.orderCount = [bijiaoModel.orderCount decimalNumberByAdding:cha];
                    }
                    
                }else{
                    if ([type isEqualToString:@"2"]) {
                         bijiaoModel.orderCount = [bijiaoModel.orderCount decimalNumberByAdding:cha];
                    }
                    
                     bijiaoModel.minPei = [bijiaoModel.minPei decimalNumberByAdding:cha];
                }
                
                NSInteger indexNum = 0;
                NSMutableArray *arr = [NSMutableArray array];
                for (NewModel *oneModel in postArr) {
                    [arr addObject:oneModel.k1dt001];
                }
                
                
                if ([arr containsObject:bijiaoModel.k1dt001]) {
                    NSInteger index = [arr indexOfObject:bijiaoModel.k1dt001];
                    peiCount = peiCount - 1;
                    [postArr  removeObjectAtIndex:index];
                }
                indexNum = postArr.count;
               
                NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
                NSString *priceStr = [BGControl notRounding:bijiaoModel.originaltest afterPoint:lpdt042];
                NSDecimalNumber *singlePrice = [NSDecimalNumber decimalNumberWithString:priceStr];
                NSDecimalNumber *onePrice = [singlePrice decimalNumberByMultiplyingBy:bijiaoModel.orderCount];
                sumPrice = [sumPrice decimalNumberByAdding:onePrice];
                bijiaoModel.sumPrice = sumPrice;
            
                if ([bijiaoModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                      [postArr insertObject:bijiaoModel atIndex:indexNum];
                }
              
                peiCount = postArr.count;
                
            }
        }
    }
    
    
}
-(void)remindStr:(NSString *)remindStr with:(NewModel *)model {
    if ([model.remindStr isEqualToString:@"2"]) {
        [self Alert:@"到货提醒已设定!"];
        return;
    }
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    NewModel *modelOne = oneArr[model.index];
    [self show];
    [[AFClient shareInstance] OrderableRemind:remindStr withArr:postOneArr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self dismiss];
                modelOne.remindStr = @"2";
                [self Alert:@"到货提醒成功!"];
                 [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:modelOne];
                [self dismiss];
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self jiaoyan];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self jiaoyan];
                            
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
        
    }];
}

- (void)getBottomHei:(CGFloat)maxHei withIndex:(NSInteger)index{
    NewModel *model = postArr[index];
    model.bottomHei = maxHei;
    
    [postArr replaceObjectAtIndex:index withObject:model];
//    [self.carTableView wreloadData];
    
}
- (void)getMaxHei:(CGFloat)maxHei withKey:(NSString *)key withIndex:(NSInteger)index {
    
    NSMutableArray *oneArr= [self.ruleDita valueForKey:key];
    NewModel *model = oneArr[index];
    model.maxHei = maxHei;
    //  [model setValuesForKeysWithDictionary:oneDict];
    [[self.ruleDita valueForKey:key] replaceObjectAtIndex:index withObject:model];
    [self.rightTableView reloadData];
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
