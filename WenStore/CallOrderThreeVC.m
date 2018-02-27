//
//  CallOrderThreeVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeVC.h"
#import "CallOrderThreeCell.h"
#import "CallOrderThreeDetailOneVC.h"
#import "CallOrderThreeDetailTwoVC.h"
#import "CallOrderThreeDetailThreeVC.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#import "BGControl.h"
#import "AFClient.h"
#import "orderModel.h"
#import "ThreeDetailVC.h"
#import "CallOrderThreeDetailVC.h"
#define kCellName @"CallOrderThreeCell"

@interface CallOrderThreeVC ()<UITableViewDelegate,UITableViewDataSource,orderThreeDelegete>{
    CallOrderThreeCell *_cell;
    NSMutableDictionary *postDict;
    NSMutableArray *postOneArr;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    NSString *bthTagStr;
     int CategoryOne;
    NSMutableArray *postArr;
    orderModel *editModelDemo;
    
}

@end

@implementation CallOrderThreeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    postArr = [[NSMutableArray alloc] init];
    CategoryOne = 0;
    self.dataArray = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    postDict = [[NSMutableDictionary alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    bthTagStr = @"0";
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
-(void)getDate {
    
        postDict = [[NSMutableDictionary alloc] init];
        NSNumber *pageNumber = [NSNumber numberWithInt:pageIndex];
        NSNumber *page = [NSNumber numberWithInt:50];
        [postDict setObject:pageNumber forKey:@"page"];
        [postDict setObject:page forKey:@"perPage"];
        [postDict setObject:page forKey:@"perPage"];
        NSNumber *categoryNum = [NSNumber numberWithInteger:CategoryOne];
        [postDict setObject:categoryNum forKey:@"Category"];

//        [postDict setObject:isYes forKey:@"k1mf006Yes"];
    
    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3008/OnePage" progressBlock:^(NSProgress *progress) {
        
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
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 || [[userResponseDict valueForKey:@"code"] intValue]== 4 ) {
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
    CGFloat oneWidth = (kScreenSize.width)/4;
    if (sender.tag == 201) {
        
    [[NSNotificationCenter defaultCenter] postNotificationName:@"Main" object:nil];
        
    }else if (sender.tag == 202){
        lineFrame.origin.x = 0;
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        CategoryOne = 0;
         [self first];
    }else if (sender.tag == 203){
        CategoryOne = 1;
        lineFrame.origin.x = oneWidth;
           bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 204){
        CategoryOne = 2;
        lineFrame.origin.x = oneWidth*2;
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 205){
        CategoryOne = 3;
        lineFrame.origin.x = oneWidth*3;
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        [self first];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[CallOrderThreeCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    orderModel *model = self.dataArray[indexPath.section];
    
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    _cell.orderthreeDelegate = self;
    [_cell.contentView setFrame:cellFrame];
    
    [_cell showModel:model];
    return _cell;
    
    
}

-(void)postoneStr:(NSString *)idStr twoStr:(NSString *)str withModel:(orderModel *)model {
    editModelDemo  = model;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([idStr isEqualToString:@"301"]) {
        if (model.isDisplayDeleteButton == true) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除此订单？" preferredStyle:UIAlertControllerStyleAlert ];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
            }];
            [alertController addAction:cancelAction];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                [postOneArr removeAllObjects];
                [self delet:model.k1mf100];
                
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else{
            [self PreviewWithIdStr:model.k1mf100 withBillstate:model.billState withTagStr:idStr];
        }
        
    }else if ([idStr isEqualToString:@"304"]){
        if (model.billState == 0 ||model.billState == 10) {
            CallOrderThreeDetailOneVC *callOrder = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailOneVC"];
            callOrder.idStr = model.k1mf100;
            [self.navigationController pushViewController:callOrder animated:YES];
            
        }else if (model.billState == 40){
             [self PreviewWithIdStr:model.k1mf100 withBillstate:model.billState withTagStr:idStr];
        }else{
            [self PreviewWithIdStr:model.k1mf100 withBillstate:model.billState withTagStr:idStr];
            
        }
        
    }else if ([idStr isEqualToString:@"303"]) {
        [self PreviewWithIdStr:model.k1mf100 withBillstate:model.billState withTagStr:idStr];
        
    }else if ([idStr isEqualToString:@"302"]) {
        CallOrderThreeDetailOneVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailOneVC"];
        callOneVC.idStr = model.k1mf100;
        [self.navigationController pushViewController:callOneVC animated:YES];
        
    }
}


-(void)PreviewWithIdStr:(NSString *)idStr withBillstate:(int)billstate withTagStr:(NSString *)tagStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3008/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSDictionary *Dict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [Dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        orderModel *model  = [orderModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        
                        [postArr addObject:dictOne];
                     
                    }
                }
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                if ([tagStr isEqualToString:@"303"]) {
                    ThreeDetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"ThreeDetailVC"];
                    addVC.datDict = responseBody[@"data"];
                    addVC.typeStr = @"2";
                    [self.navigationController pushViewController:addVC animated:YES];
                }else{
                    
                    CallOrderThreeDetailVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailVC"];
                    detailVC.billstate = billstate;
                    detailVC.tagStr = tagStr;
                    detailVC.dataDict = Dict;
                    detailVC.orderModel = editModelDemo;
                    [self.navigationController pushViewController:detailVC animated:YES];
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
                        [self PreviewWithIdStr:idStr withBillstate:billstate withTagStr:tagStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self PreviewWithIdStr:idStr withBillstate:billstate withTagStr:tagStr];
                            
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

- (void)GreateWith:(NSDictionary *)dataDic{
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDic valueForKey:@"master"],@"master",postArr,@"detail",nil];
    [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3008/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
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
                        [self GreateWith:dataDic];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self GreateWith:dataDic];
                            
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
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}

-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3008/Destroy" progressBlock:^(NSProgress *progress) {
        
        
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
            
            [self dismiss];
            
        }
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
    
}





- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    orderModel *model = self.dataArray[indexPath.section];
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayCheckedButton) {
        return 265;
    }else{
        return 215;
        
    }
   
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    orderModel *model = self.dataArray[indexPath.section];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (model.billState == 0 ||model.billState == 10) {
        CallOrderThreeDetailOneVC *callOrder = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailOneVC"];
        callOrder.idStr = model.k1mf100;
         [self.navigationController pushViewController:callOrder animated:YES];

    }else if (model.billState == 40){
     CallOrderThreeDetailTwoVC *callTwo = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailTwoVC"];
         callTwo.idStr = model.k1mf100;
    [self.navigationController pushViewController:callTwo animated:YES];
    }else{
     CallOrderThreeDetailThreeVC *callThree = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailThreeVC"];
        callThree.idStr = model.k1mf100;
        [self.navigationController pushViewController:callThree animated:YES];

    }
    
   
   

    
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
