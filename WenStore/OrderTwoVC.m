//
//  OrderTwoVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OrderTwoVC.h"
#import "OrderTwoCell.h"
#define kCellName @"OrderTwoCell"
#import "Choice.h"
#import "PayViewController.h"
#import "OrderTwoDetailVC.h"
#import "MainViewController.h"
#import "AFClient.h"
#import "orderModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#import "BGControl.h"
#import "EditVC.h"
#import "CallOrderOneVC.h"
#import "OrderDetailVC.h"
@interface OrderTwoVC () <choiceDelegate,orderDelegete,UITableViewDelegate,UITableViewDataSource>{
    OrderTwoCell *_cell;
    Choice *choiceView;
    NSString *timeStr;
    NSMutableDictionary *postDict;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    int CategoryOne;
    NSMutableArray *postOneArr;
    NSString *isEnablePayment;
    CGFloat oneWidth;
}

@end

@implementation OrderTwoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isEnablePayment = [[NSUserDefaults standardUserDefaults] valueForKey:@"isEnablePayment"];
    self.dataArray = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    postDict = [[NSMutableDictionary alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    oneWidth = kScreenSize.width/3;
    if (![isEnablePayment isEqualToString:@"1"]) {
        oneWidth = kScreenSize.width/2;
        CGRect oneFrame = self.oneBth.frame;
        oneFrame.size.width = oneWidth;
        [self.oneBth setFrame:oneFrame];
        
        CGRect twoFrame = self.twoBth.frame;
        twoFrame.size.width = oneWidth;
        twoFrame.origin.x = CGRectGetMaxX(self.oneBth.frame);
        [self.twoBth setFrame:twoFrame];
        
        CGRect lineFrame = self.lineView.frame;
        lineFrame.size.width = oneWidth;
        [self.lineView setFrame:lineFrame];
        self.threeBth.hidden = YES;
    }
    
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    CategoryOne = 0;
    timeStr = @"201";
    [self first];
}
- (void)first {
    
    MJRefreshNormalHeader *refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        pageIndex = 1;
        [self getDate];
    }];
    
    self.bigTableView.mj_header = refreshHeader;
    MJRefreshBackNormalFooter *refreshFooter = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        pageIndex ++;
        [self getDate];
    }];
    self.bigTableView.mj_footer = refreshFooter;
    [self.bigTableView.mj_header beginRefreshing];
}
//-(void)header {
//    pageIndex = 0;
//    [self getDate];
//}
//-(void)fotter {
//    pageIndex ++;
//    [self getDate];
//}
-(void)getDate {
    NSNumber *pageNumber = [NSNumber numberWithInt:pageIndex];
    NSNumber *page = [NSNumber numberWithInt:50];
    NSNumber *isYes = [NSNumber numberWithBool:k1mf006Yes];
    NSNumber *isNo = [NSNumber numberWithBool:k1mf006No];
    [postDict setObject:pageNumber forKey:@"page"];
    [postDict setObject:page forKey:@"perPage"];
    [postDict setObject:page forKey:@"perPage"];
    NSNumber *categoryNum = [NSNumber numberWithInteger:CategoryOne];
    [postDict setObject:categoryNum forKey:@"Category"];
    // [postDict setObject:isYes forKey:@"k1mf006Yes"];
    //[postDict setObject:isNo forKey:@"k1mf006No"];
    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3001/OnePage" progressBlock:^(NSProgress *progress) {
    } success:^(id responseBody) {
        if (pageIndex == 1) {
            [self.dataArray removeAllObjects];
        }
        if ([[responseBody valueForKey:@"status"] integerValue]== 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSArray *dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"data"];
                
                for (int i = 0; i<dataArr.count; i++) {
                    NSDictionary *dict  = dataArr[i];
                    orderModel *model = [orderModel new];
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArray addObject:model];
                }
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
                        [self first];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self first];
                            
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
        
        if (self.dataArray.count <1) {
            self.bigTableView.hidden = YES;
            
        }else {
            self.bigTableView.hidden = NO;
        }
        
        [self.bigTableView reloadData];
        [self.bigTableView.mj_header endRefreshing];
        [self.bigTableView.mj_footer endRefreshing];
        [self dismiss];
        
    } failure:^(NSError *error) {
        [self.bigTableView.mj_header endRefreshing];
        [self.bigTableView.mj_footer endRefreshing];
        [self dismiss];
    }];
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    CGRect lineFrame = self.lineView.frame;
    
    if (sender.tag == 201) {
        if ([self.fanStr isEqualToString:@"MainViewController"]) {
            [self.navigationController popViewControllerAnimated:YES];
        }else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            MainViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
        
    }else if (sender.tag == 202) {
        NSArray *nib = [[NSBundle mainBundle]loadNibNamed:@"Choice" owner:sender options:nil];
        choiceView = [nib firstObject];
        self.blackButton.hidden = NO;
        choiceView.delegate =self;
        [self.view addSubview:choiceView];
        choiceView.center = self.view.center;
        choiceView.clipsToBounds = YES;
        choiceView.layer.cornerRadius = 10.f;
        
        
        [self changeTwo:choiceView];
        
    }else if (sender.tag == 203){
        lineFrame.origin.x = 0;
        k1mf006Yes = 0;
        k1mf006No = 0;
        CategoryOne = 0;
        pageIndex = 0;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 204){
        lineFrame.origin.x = oneWidth;
        k1mf006Yes = 0;
        k1mf006No = 1;
        pageIndex = 0;
        CategoryOne = 1;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 205){
        k1mf006Yes = 1;
        k1mf006No = 0;
        pageIndex = 0;
        CategoryOne = 2;
        lineFrame.origin.x = oneWidth*2;
        [self.lineView setFrame:lineFrame];
        [self first];
    }
}

- (void)postChoiceStr:(NSString *)choiceStr {
    __block Choice *choiceVie = choiceView;
    NSDate *tody = [NSDate date];
    if (![choiceStr isEqualToString:@"205"]) {
        timeStr = choiceStr;
        if ([choiceStr isEqualToString:@"201"]) {
            NSDate *monthDate = [BGControl getPriousorLaterDateFromDate:tody withWeek:-1];
            [postDict setObject:[NSString stringWithFormat:@"%@",monthDate] forKey:@"k1mf003Begin"];
            [postDict setObject:[NSString stringWithFormat:@"%@",tody] forKey:@"k1mf003End"];
        }else if ([choiceStr isEqualToString:@"202"]) {
            NSDate *monthDate = [BGControl getPriousorLaterDateFromDate:tody withMonth:-1];
            [postDict setObject:[NSString stringWithFormat:@"%@",monthDate] forKey:@"k1mf003Begin"];
            [postDict setObject:[NSString stringWithFormat:@"%@",tody] forKey:@"k1mf003End"];
        }else if ([choiceStr isEqualToString:@"203"]) {
            NSDate *monthDate = [BGControl getPriousorLaterDateFromDate:tody withMonth:-6];
            [postDict setObject:[NSString stringWithFormat:@"%@",monthDate] forKey:@"k1mf003Begin"];
            [postDict setObject:[NSString stringWithFormat:@"%@",tody] forKey:@"k1mf003End"];
        }else if ([choiceStr isEqualToString:@"204"]) {
            NSDate *monthDate = [BGControl getPriousorLaterDateFromDate:tody withMonth:-12];
            [postDict setObject:[NSString stringWithFormat:@"%@",monthDate] forKey:@"k1mf003Begin"];
            [postDict setObject:[NSString stringWithFormat:@"%@",tody] forKey:@"k1mf003End"];
        }
        
    }
    [self first];
    self.blackButton.hidden = YES;
    [choiceVie removeFromSuperview];
}
- (void)changeTwo:(Choice *)test{
    
    
    if ([timeStr isEqualToString:@"201"] ) {
        [test.oneBth setBackgroundColor:kTabBarColor];
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 15.f;
        test.twoBth.layer.borderColor = kTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.threeBth.layer.cornerRadius = 15.f;
        test.threeBth.layer.borderColor = kTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        [test.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.oneBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 15.f;
        test.fourBth.layer.borderColor = kTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.oneBth.layer.cornerRadius = 15.f;
    }else if ([timeStr isEqualToString:@"202"]) {
        [test.twoBth setBackgroundColor:kTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 15.f;
        test.oneBth.layer.borderColor = kTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.threeBth.layer.cornerRadius = 15.f;
        test.threeBth.layer.borderColor = kTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.twoBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 15.f;
        test.fourBth.layer.borderColor = kTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.twoBth.layer.cornerRadius = 15.f;
        
        
    }else if ([timeStr isEqualToString:@"203"]) {
        [test.threeBth setBackgroundColor:kTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 15.f;
        test.oneBth.layer.borderColor = kTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        [test.fourBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 15.f;
        test.twoBth.layer.borderColor = kTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.threeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        test.fourBth.layer.cornerRadius = 15.f;
        test.fourBth.layer.borderColor = kTabBarColor.CGColor;
        test.fourBth.layer.borderWidth = 1.f;
        test.threeBth.layer.cornerRadius = 15.f;
    }else if ([timeStr isEqualToString:@"204"]) {
        [test.fourBth setBackgroundColor:kTabBarColor];
        [test.oneBth setBackgroundColor:[UIColor whiteColor]];
        test.oneBth.layer.cornerRadius = 15.f;
        test.oneBth.layer.borderColor = kTabBarColor.CGColor;
        test.oneBth.layer.borderWidth = 1.f;
        [test.threeBth setBackgroundColor:[UIColor whiteColor]];
        [test.twoBth setBackgroundColor:[UIColor whiteColor]];
        test.twoBth.layer.cornerRadius = 15.f;
        test.twoBth.layer.borderColor = kTabBarColor.CGColor;
        test.twoBth.layer.borderWidth = 1.f;
        [test.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.fourBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [test.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [test.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        test.threeBth.layer.cornerRadius = 15.f;
        test.threeBth.layer.borderColor = kTabBarColor.CGColor;
        test.threeBth.layer.borderWidth = 1.f;
        test.fourBth.layer.cornerRadius = 15.f;
    }
    
    
    
}
-(void)blackButtonClick {
    [self hiddleAllViews];
}
- (void)hiddleAllViews{
    __block Choice *tes = choiceView;
    [tes removeFromSuperview];
    self.blackButton.hidden = YES;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[OrderTwoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    _cell.orderDelegate = self;
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    orderModel *model = self.dataArray[indexPath.section];
    
    [_cell showModel:model withDict:self.dataDict];
    return _cell;
    
    
}
-(void)postoneStr:(NSString *)idStr twoStr:(NSString *)str withCount:(NSDecimalNumber *)count withModel:(orderModel *)model {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([idStr isEqualToString:@"301"]) {
        if (model.isNeedDeleteConfirmation == true) {
            
            OrderTwoDetailVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoDetailVC"];
            orderVC.idStr = str;
            orderVC.myDict = self.dataDict;
            orderVC.orderModel = model;
            orderVC.isji = model.k1mf109;
            orderVC.tag = [idStr integerValue];
            orderVC.billState = model.billState;
            orderVC.billStateStr = [NSString stringWithFormat:@"%d",model.billState];
            [self.navigationController pushViewController:orderVC animated:YES];
        }
        
    }else if ([idStr isEqualToString:@"303"]) {
        
        if (model.billState == 10 || model.billState == 30 || model.billState == 40) {
            if ([isEnablePayment isEqualToString:@"1"]) {
                PayViewController *payVC = [storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
                payVC.k1mf100 = model.k1mf100;
               
                [self.navigationController pushViewController:payVC animated:YES];
            }else {
                [self Alert:@"不支持线上支付！"];
            }
            
        }else{
            // [self tiaoWithStr:model.k1mf100];
            OrderTwoDetailVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoDetailVC"];
            orderVC.idStr = str;
            orderVC.myDict = self.dataDict;
            orderVC.orderModel = model;
            orderVC.isji = model.k1mf109;
            orderVC.tag = [idStr integerValue];
            orderVC.billState = model.billState;
            orderVC.billStateStr = [NSString stringWithFormat:@"%d",model.billState];
            [self.navigationController pushViewController:orderVC animated:YES];
            
        }
        
    }else if ([idStr isEqualToString:@"302"]) {
        
        OrderTwoDetailVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoDetailVC"];
        orderVC.idStr = str;
        orderVC.myDict = self.dataDict;
        orderVC.orderModel = model;
        orderVC.isji = model.k1mf109;
        orderVC.tag = [idStr integerValue];
        orderVC.billState = model.billState;
        orderVC.billStateStr = [NSString stringWithFormat:@"%d",model.billState];
        [self.navigationController pushViewController:orderVC animated:YES];
    }else if ([idStr isEqualToString:@"304"]) {
        
        if (model.billState ==0 ||model.billState == 10 || model.billState == 40 ) {
            if (model.isEditable == true) {
                EditVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
                editVC.idStr = str;
                editVC.dict = self.dataDict;
                editVC.countStr = [NSString stringWithFormat:@"%@",count];
                [self.navigationController pushViewController:editVC animated:YES];
            }else{
                OrderTwoDetailVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoDetailVC"];
                orderVC.idStr = str;
                orderVC.isji = model.k1mf109;
                orderVC.myDict = self.dataDict;
                orderVC.orderModel = model;
                orderVC.billState = model.billState;
                orderVC.tag = [idStr integerValue];
                orderVC.billStateStr = [NSString stringWithFormat:@"%d",model.billState];
                [self.navigationController pushViewController:orderVC animated:YES];
            }
            
        }else if(model.billState == 60|| model.billState == 30||model.billState == 90) {
            
            OrderTwoDetailVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoDetailVC"];
            orderVC.idStr = str;
            orderVC.myDict = self.dataDict;
            orderVC.orderModel = model;
            orderVC.isji = model.k1mf109;
            orderVC.billState = model.billState;
            orderVC.tag = [idStr integerValue];
            orderVC.billStateStr = [NSString stringWithFormat:@"%d",model.billState];
            [self.navigationController pushViewController:orderVC animated:YES];
            
        }
        
    }else if ([idStr isEqualToString:@"305"]) {
        
        CallOrderOneVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderOneVC"];
        editVC.K1mf100 = model.k1mf100;
        [self.navigationController pushViewController:editVC animated:YES];
        
    }
    
}

- (void)tiaoWithStr:(NSString *)idStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3001/preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                OrderDetailVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderDetailVC"];
                detailVC.datadict = [responseBody valueForKey:@"data"];
                detailVC.zongdict = self.dataDict;
                detailVC.typeStr = @"2";
                
                detailVC.idStr = idStr;
                [self.navigationController pushViewController:detailVC animated:YES];
                
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
                        [self first];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self first];
                            
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
            
            
            [self Alert:[responseBody valueForKey:@"errors"][0]];
            [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        [self dismiss];
    } failure:^(id errrorresponseBody) {
        [self Alert:[errrorresponseBody valueForKey:@"errors"][0]];
        [self dismiss];
    }];
    
}
-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3001/Destroy" progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:@"删除成功"];
                [self first];
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
                        [self delet:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self delet:idStr];
                            
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
            [self.navigationController popViewControllerAnimated:YES];
            [self dismiss];
            
        }
    } failure:^(NSError *error) {
        [self Alert:@"删除失败!"];
        [self dismiss];
    }];
    
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    orderModel *model = self.dataArray[indexPath.section];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isyunPrice = false;
    CGFloat chaHei = 0;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF301"]) {
            isyunPrice = true;
        }else {
            chaHei = 50;
        }
    }
    if (model.isDisplayEditButton || model.isDisplayDeleteButton || model.isDisplayCommitButton || model.isDisplayPayBillButton) {
        return 315 - chaHei;
    }else{
        if (model.billState == 0) {
            return 265- chaHei;
        }else{
            return 315- chaHei;
        }
        
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
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
