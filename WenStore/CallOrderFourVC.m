//
//  CallOrderFourVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderFourVC.h"
#import "CallOrderFourDetailTwoVC.h"
#import "CallOrderFourDetailThreeVC.h"
#import "CallOrderFourDetailOneVC.h"
#import "CallOrderFourCell.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#import "BGControl.h"
#import "AFClient.h"
#import "orderModel.h"
#import "EditModel.h"
#import "DetailVC.h"
#define kCellName @"CallOrderFourCell"
@interface CallOrderFourVC () <UITableViewDelegate,UITableViewDataSource,orderFourDelegete> {
   CallOrderFourCell *_cell;
    NSMutableDictionary *postDict;
    NSMutableArray *postOneArr;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    NSString *bthTagStr;
     int CategoryOne;
    NSMutableArray *postArr;
}

@end

@implementation CallOrderFourVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IsIphoneX];
    CategoryOne = 0;
    postArr = [[NSMutableArray  alloc] init];
    self.dataArray = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    postDict = [[NSMutableDictionary alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    bthTagStr = @"0";
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self first];
}
- (void)IsIphoneX {
    if (kiPhoneX) {
       
         self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
       self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftImg.frame = CGRectMake(15, 51, 22, 19);
        self.rightImg.frame = CGRectMake(kScreenSize.width-32, 52, 17, 17);
        self.oneView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, 40);
        self.noDataView.frame = CGRectMake(0, kNavHeight+40, kScreenSize.width, kScreenSize.height-40-kNavHeight);
         self.bigTableView .frame = CGRectMake(0, kNavHeight+40, kScreenSize.width, kScreenSize.height-40-kNavHeight);
    }
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
   
    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3011/OnePage" progressBlock:^(NSProgress *progress) {
        
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
    CGFloat oneWidth = (kScreenSize.width)/3;
    if (sender.tag == 201) {
        
       [[NSNotificationCenter defaultCenter] postNotificationName:@"Main" object:nil];
    }else if (sender.tag == 204){
        lineFrame.origin.x = 0;
        [self.lineView setFrame:lineFrame];
         bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        CategoryOne = 0;
         [self first];
    }else if (sender.tag == 205){
        lineFrame.origin.x = oneWidth+1;
        [self.lineView setFrame:lineFrame];
          bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
         CategoryOne = 1;
         [self first];
    }else if (sender.tag == 206){
        lineFrame.origin.x = oneWidth*2;
        [self.lineView setFrame:lineFrame];
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
         CategoryOne = 2;
        [self first];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[CallOrderFourCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    _cell.orderFourDelegate = self;
    orderModel *model = self.dataArray[indexPath.section];
    [_cell showModel:model];
    return _cell;
    
    
}

-(void)postoneStr:(NSString *)idStr twoStr:(NSString *)str withModel:(orderModel *)model {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if ([idStr isEqualToString:@"301"]) {
        CallOrderFourDetailTwoVC *callVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailTwoVC"];
        callVC.idStr = model.k1mf100;
        callVC.typeStr = @"2";
        [self.navigationController pushViewController:callVC animated:YES];


    }else if ([idStr isEqualToString:@"304"]){
        if (model.billState == 0 ||model.billState == 10) {
            CallOrderFourDetailOneVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailOneVC"];
            callOneVC.idStr = model.k1mf100;
            callOneVC.reasonsArr = self.reasonsArr;
            [self.navigationController pushViewController:callOneVC animated:YES];
        }else {
                CallOrderFourDetailTwoVC *callVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailTwoVC"];
                callVC.idStr = model.k1mf100;
            callVC.typeStr = @"1";
                [self.navigationController pushViewController:callVC animated:YES];

        }
        

    }else if ([idStr isEqualToString:@"303"]) {
        [self PreviewWithIdStr:model.k1mf100];
        
    }else if ([idStr isEqualToString:@"302"]) {
        CallOrderFourDetailOneVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailOneVC"];
        callOneVC.idStr = model.k1mf100;
        callOneVC.reasonsArr = self.reasonsArr;
        [self.navigationController pushViewController:callOneVC animated:YES];
        
    }else if ([idStr isEqualToString:@"305"]) {
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
            
        }
        
    }
    
}


-(void)PreviewWithIdStr:(NSString *)idStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3011/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSDictionary *Dict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [Dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        EditModel *model  = [EditModel new];
                        NSDictionary *dictOne = dictDetail[j];
                   
                            [postArr addObject:dictOne];
                       
                        
                        
                        
                    }
                }
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                DetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
                addVC.datDict = responseBody[@"data"];
                
                addVC.typeStr = @"2";
                
                [self.navigationController pushViewController:addVC animated:YES];
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
    [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3011/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
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
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3011/Destroy" progressBlock:^(NSProgress *progress) {
        
        
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
    if (model.isDisplayCommitButton || model.isDisplayEditButton || model.isDisplayConfirmedButton || model.isDisplayDeleteButton) {
        
        return 215;
    }else {
        
        return 165;
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
- (IBAction)FourAddVC:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    CallOrderFourDetailOneVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailOneVC"];
     callOneVC.typeStr = @"add";
    callOneVC.reasonsArr = self.reasonsArr;
    [self.navigationController pushViewController:callOneVC animated:YES];
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
