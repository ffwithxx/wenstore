//
//  ProducedOnePaggeVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProducedOnePaggeVC.h"
#import "ProducedOnePageCell.h"
#import "BGControl.h"
#import "AFClient.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#import "ProducedOnePageModel.h"
#import "MainViewController.h"
#import "AddProducedVC.h"
#import "ProducedVC.h"
#import "ProducedDetailVC.h"
#define kCellName @"ProducedOnePageCell"
@interface ProducedOnePaggeVC ()<UITableViewDelegate,UITableViewDataSource,orderDelegete>{
    ProducedOnePageCell *_cell;
    NSMutableDictionary *postDict;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    NSMutableArray *postOneArr;
    NSMutableArray *postArr;
    NSString *timeStr;
    int CategoryOne;
}


@end

@implementation ProducedOnePaggeVC

- (void)viewDidLoad {
    [super viewDidLoad];
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
    NSNumber *pageNumber = [NSNumber numberWithInt:pageIndex];
    NSNumber *page = [NSNumber numberWithInt:50];
    [postDict setObject:pageNumber forKey:@"page"];
    [postDict setObject:page forKey:@"perPage"];
    [postDict setObject:page forKey:@"perPage"];
    NSNumber *categoryNum = [NSNumber numberWithInteger:CategoryOne];
    [postDict setObject:categoryNum forKey:@"Category"];
    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3007/OnePage" progressBlock:^(NSProgress *progress) {
        
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
                    ProducedOnePageModel *model = [ProducedOnePageModel new];
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


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ProducedOnePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    _cell.orderDelegate = self;
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    ProducedOnePageModel *model = self.dataArray[indexPath.section];
    
    [_cell showModel:model];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    ProducedOnePageModel *model = self.dataArray[indexPath.section];
    CGFloat hei = 265;
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
        
    }else {
        
        hei = 215;
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


-(void)postoneStr:(NSString *)tagStr withModel:(ProducedOnePageModel *)model {
    if ([tagStr isEqualToString:@"301"]) {
        if (model.isDisplayDeleteButton) {
            
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
            
            
            
            
        }
    }else if ([tagStr isEqualToString:@"304"] ||[tagStr isEqualToString:@"302"]) {
        if (model.isDisplayEditButton) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
            AddProducedVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddProducedVC"];
            mainVC.idStr = model.k1mf100;
            [self.navigationController pushViewController:mainVC animated:YES];
            
        }else {
            [self getPreviewWithIdStr:model.k1mf100];
        }
    }else if ([tagStr isEqualToString:@"303"]) {
        if (model.isDisplayCommitButton) {
            [self PreviewWithIdStr:model.k1mf100];
            
        }
    }else if ([tagStr isEqualToString:@"302"]) {
        if (model.isDisplayEditButton) {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
            AddProducedVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddProducedVC"];
            mainVC.idStr = model.k1mf100;
            [self.navigationController pushViewController:mainVC animated:YES];
            
        }
    }
    
    
}
/*结案*/

-(void)PreviewWithIdStr:(NSString *)idStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3007/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSDictionary *Dict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [Dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        ProducedOnePageModel *model  = [ProducedOnePageModel new];
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
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                ProducedDetailVC *detail = [storyboard instantiateViewControllerWithIdentifier:@"ProducedDetailVC"];
                detail.idStr = idStr;
               
                detail.typeStr = @"2";
                detail.dataDict = [responseBody valueForKey:@"data"];
                [self.navigationController pushViewController:detail animated:YES];
                
                
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

- (void)GreateWith:(NSDictionary *)dataDic{
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDic valueForKey:@"master"],@"master",postArr,@"detail",nil];
    [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3007/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
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
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3007/Destroy" progressBlock:^(NSProgress *progress) {
        
        
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

-(void)getPreviewWithIdStr:(NSString *)idStr {
    
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3007/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                UIStoryboard *storboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                ProducedVC *detail =[storboard  instantiateViewControllerWithIdentifier:@"ProducedVC"];
                detail.idStr = idStr;
                detail.dataDict = [responseBody valueForKey:@"data"];
                [self.navigationController pushViewController:detail animated:YES];
                
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
                        [self getPreviewWithIdStr:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self getPreviewWithIdStr:idStr];
                            
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
            [self.navigationController popViewControllerAnimated:YES];
            [self dismiss];
            
        }
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
    
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    
    CGRect lineFrame = self.lineView.frame;
    CGFloat oneWidth = kScreenSize.width/2;
    if (sender.tag == 201) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        MainViewController *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"MainViewController"];
        [self.navigationController pushViewController:mainVC animated:YES];
        
        
    }else if (sender.tag == 203){
        lineFrame.origin.x = 0;
      CategoryOne = 0;
        pageIndex = 0;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 204){
        lineFrame.origin.x = oneWidth;
      CategoryOne = 2;
        pageIndex = 0;
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 202){
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
        AddProducedVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddProducedVC"];
        mainVC.typeStr = @"add";
      
        [self.navigationController pushViewController:mainVC animated:YES];
    }
    

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
