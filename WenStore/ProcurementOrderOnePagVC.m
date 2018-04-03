//
//  ProcurementOrderOnePagVC.m
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProcurementOrderOnePagVC.h"
#import "ProcurementOrderOnePagCell.h"
#define kCellName @"ProcurementOrderOnePagCell"
#import "Choice.h"
#import "PayViewController.h"
#import "ProcurementOrderVC.h"
#import "MainViewController.h"
#import "AFClient.h"
#import "ProcurementOrderOnePagModel.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#import "BGControl.h"
#import "AddProcurementModel.h"
#import "ProcurementOrderDetailVC.h"
#import "EmailViewController.h"
#import "AddPSOnePageVC.h"

@interface ProcurementOrderOnePagVC ()<choiceDelegate,orderDelegete,UITableViewDelegate,UITableViewDataSource,UIAlertViewDelegate>{
    ProcurementOrderOnePagCell *_cell;
    Choice *choiceView;
    NSString *timeStr;
    NSMutableDictionary *postDict;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    NSMutableArray *postOneArr;
    NSMutableArray *postArr;
    NSString *k1mf100Str;
    NSString *kidStr;
     int CategoryOne;
}


@end

@implementation ProcurementOrderOnePagVC

-(void)viewWillAppear:(BOOL)animated {
     [self isIphoneX];
    timeStr = @"201";
    CategoryOne = 0;
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    postDict = [[NSMutableDictionary alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    [self first];

}
- (void)isIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
     self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftImg.frame = CGRectMake(15, 52, 24, 16);
        self.rightImg.frame = CGRectMake(kScreenSize.width-73, 52, 20, 13);
        self.rightLab.frame = CGRectMake(kScreenSize.width-55, 34, 40, 50);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
//        self.oneView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, 40);
        self.bgView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
//        self.bigTableView .frame = CGRectMake(0, kNavHeight+40, kScreenSize.width, kScreenSize.height-40-kNavHeight);
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
        // Do any additional setup after loading the view.
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
    NSNumber *categoryNo = [NSNumber numberWithBool:CategoryOne];
    [postDict setObject:pageNumber forKey:@"page"];
    [postDict setObject:page forKey:@"perPage"];
    [postDict setObject:page forKey:@"perPage"];
    [postDict setObject:categoryNo forKey:@"category"];

    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3022/OnePage" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if (pageIndex == 1) {
            self.dataArray = [NSMutableArray new];
         
        }
        
        if ([[responseBody valueForKey:@"status"] integerValue]== 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSArray *dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"data"];
                
                for (int i = 0; i<dataArr.count; i++) {
                    NSDictionary *dict  = dataArr[i];
                    ProcurementOrderOnePagModel *model = [ProcurementOrderOnePagModel new];
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
    CGFloat oneWidth = kScreenSize.width/3;
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
        CategoryOne = 0;
        pageIndex = 0;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 204){
        lineFrame.origin.x = oneWidth;
     CategoryOne = 1;
        pageIndex = 0;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 205){
     
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
        [self first];
    }
    
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
        _cell = [[ProcurementOrderOnePagCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    _cell.orderDelegate = self;
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    ProcurementOrderOnePagModel *model = self.dataArray[indexPath.section];
    
    [_cell showModel:model withDict:self.dataDict];
    return _cell;
    
    
}
-(void)postoneStr:(NSString *)idStr twoStr:(NSString *)str withCount:(NSDecimalNumber *)count withModel:(ProcurementOrderOnePagModel *)model {
    NSLog(@"%@",idStr);
    kidStr = str;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([idStr isEqualToString:@"301"]) {
//        if (model.billState == 0) {
            UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProcurementOrderDetailVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProcurementOrderDetailVC"];
            detail.billState = model.billState;
            detail.idStr = model.k1mf100;
            detail.orderModel = model;
            detail.tagNum = [idStr integerValue];
            [self.navigationController pushViewController:detail animated:YES];
//            if (model.isNeedDeleteConfirmation == true) {
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否删除此订单？" preferredStyle:UIAlertControllerStyleAlert ];
//                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                }];
//                [alertController addAction:cancelAction];
//                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                    [postOneArr removeAllObjects];
//                    [self delet:model.k1mf100];
//
//                }];
//                [alertController addAction:confirmAction];
//                [self presentViewController:alertController animated:YES completion:nil];
//
//            }else {
//                [self delet:model.k1mf100];
//            }
            

//        }else {
//            if (model.billState == 10 ||model.billState == 30||model.billState == 40) {
//                EmailViewController *emailVC = [storyboard instantiateViewControllerWithIdentifier:@"EmailViewController"];
//                emailVC.idStr = str;
//                [self.navigationController pushViewController:emailVC animated:YES];
//            }
//
//
//        }
        }else if ([idStr isEqualToString:@"303"]) {
            UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProcurementOrderDetailVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProcurementOrderDetailVC"];
            detail.billState = model.billState;
            detail.idStr = model.k1mf100;
            detail.orderModel = model;
            detail.tagNum = [idStr integerValue];
            [self.navigationController pushViewController:detail animated:YES];
//        if (model.billState == 0) {
//        UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        ProcurementOrderDetailVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProcurementOrderDetailVC"];
//        detail.billState = model.billState;
//        detail.idStr = model.k1mf100;
//        [self.navigationController pushViewController:detail animated:YES];
//        }else if (model.billState == 10){
//
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否转出？" preferredStyle:UIAlertControllerStyleAlert ];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self first];
//            }];
//            [alertController addAction:cancelAction];
//            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                [self Divert:kidStr];
//            }];
//            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否转出？"];
//            [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 5)];
//            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 5)];
//            [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
//            [alertController addAction:confirmAction];
//           [self presentViewController:alertController animated:YES completion:nil];
//        }else {
//               [self PreviewWithIdStr:str];
//            }
    }else if ([idStr isEqualToString:@"302"]) {
        UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProcurementOrderDetailVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProcurementOrderDetailVC"];
        detail.billState = model.billState;
        detail.idStr = model.k1mf100;
        detail.orderModel = model;
        detail.tagNum = [idStr integerValue];
        [self.navigationController pushViewController:detail animated:YES];
//        if (model.billState == 0 || model.billState == 10) {
//        ProcurementOrderVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
//        orderVC.idStr = str;
//        [self.navigationController pushViewController:orderVC animated:YES];
//        }else {
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否转出？" preferredStyle:UIAlertControllerStyleAlert ];
//            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//                [self first];
//            }];
//            [alertController addAction:cancelAction];
//            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                [self Divert:kidStr];
//            }];
//            NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否转出？"];
//            [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 5)];
//            [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 5)];
//            [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
//            [alertController addAction:confirmAction];
//          [self presentViewController:alertController animated:YES completion:nil];
//        }
    }else if ([idStr isEqualToString:@"304"]) {
        if (model.billState == 0 || model.billState == 10) {
            ProcurementOrderVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
            orderVC.idStr = str;
            [self.navigationController pushViewController:orderVC animated:YES];
        }else{
            UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            ProcurementOrderDetailVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProcurementOrderDetailVC"];
            detail.billState = model.billState;
            detail.idStr = model.k1mf100;
            detail.orderModel = model;
            [self.navigationController pushViewController:detail animated:YES];
        }
        
       }
    
    
}

/*结案*/

-(void)PreviewWithIdStr:(NSString *)idStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3022/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
              NSDictionary *Dict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [Dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        AddProcurementModel *model  = [AddProcurementModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt101"]]];
                        NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                        NSDecimalNumber *k1dt110Count = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt110"]]];
                        NSComparisonResult k1dt110compar = [k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                        if (compar == NSOrderedDescending || k1dt110compar == NSOrderedDescending) {
                            [model setValuesForKeysWithDictionary:dictOne];
                            [self.dataArray addObject:model];
                            [postArr addObject:dictOne];
                        }
                        
                        
                        
                    }
                }

                [self UpdateStateWith:[responseBody valueForKey:@"data"]];
               
                
                
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
                        [self PreviewWithIdStr:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self PreviewWithIdStr:idStr];
                            
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
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    

}

- (void)UpdateStateWith:(NSDictionary *)dataDic{
    
    
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDic valueForKey:@"master"],@"master",postArr,@"detail",nil];
    
    
    // [postMast setObject:[dataDict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    // [postMast setObject:[dataDict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    [self show];
    [[AFClient shareInstance] UpdateState:postMast withArr:postOneArr withUrl:@"App/Wbp3022/UpdateState"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                [self Alert:@"结案成功"];
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
                        [self UpdateStateWith:dataDic];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self UpdateStateWith:dataDic];
                            
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
        }
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}

/*转出*/
-(void)Divert:(NSString *)idStr {
    [self show];

    [[AFClient shareInstance] Divert:idStr withArr:postOneArr withUrl:@"App/Wbp3022/Divert" progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                k1mf100Str = [NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"data"]];
                [self Alert:@"转出成功"];
               // [self first];
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否进入采购进货 ？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//                alert.alertViewStyle = UIAlertViewStyleDefault;
//                alert.tag = 202;
//                alert.delegate = self;
//                [alert show];
                
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"是否进入采购进货？" preferredStyle:UIAlertControllerStyleAlert ];
                UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                    [self first];
                }];
                [alertController addAction:cancelAction];
                UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                    AddPSOnePageVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPSOnePageVC"];
                    mainVC.idStr = k1mf100Str;
                    [self.navigationController pushViewController:mainVC animated:YES];
                }];
                NSMutableAttributedString *alertControllerMessageStr = [[NSMutableAttributedString alloc] initWithString:@"是否进入采购进货？"];
                [alertControllerMessageStr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:NSMakeRange(0, 9)];
                [alertControllerMessageStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range:NSMakeRange(0, 9)];
                [alertController setValue:alertControllerMessageStr forKey:@"attributedMessage"];
                [alertController addAction:confirmAction];
                [self presentViewController:alertController animated:YES completion:nil];
                
                
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
                        [self Divert:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self Divert:idStr];
                            
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
        [self Alert:@"转出失败!"];
        [self dismiss];
    }];
    

}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == 1) {
        if (alertView.tag == 201) {
            [self Divert:kidStr];
        }else{
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
        AddPSOnePageVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPSOnePageVC"];
        mainVC.idStr = k1mf100Str;
        [self.navigationController pushViewController:mainVC animated:YES];
        }
    }else{
        [self first];
    }
}
-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3022/Destroy" progressBlock:^(NSProgress *progress) {
     
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
                    }];
                    [alertController addAction:confirmAction];
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self delet:idStr];
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
     ProcurementOrderOnePagModel *model = self.dataArray[indexPath.section];
    CGFloat hei = 364;
    if (model.billState == 90) {
        hei =  314;
    }
    
    return hei ;
    
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
