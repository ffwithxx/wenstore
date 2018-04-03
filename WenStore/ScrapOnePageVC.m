//
//  ScrapOnePageVC.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ScrapOnePageVC.h"
#import "ScrapOnePageCell.h"
#import "AddScrapVC.h"
#import "ScrapVC.h"
#import "AFClient.h"
#import "PurchaseOnePageModel.h"
#import "BGControl.h"
#import "ScrapDetailVC.h"
#import <MJRefresh/MJRefresh.h>
#define kCellName @"ScrapOnePageCell"
@interface ScrapOnePageVC ()<UITableViewDataSource,UITableViewDelegate,ScrapDelegate>{
    ScrapOnePageCell *_cell;
    NSMutableArray *postOneArr;
    NSMutableDictionary *postDict;
    int pageIndex;
    BOOL k1mf006Yes;
    BOOL k1mf006No;
    NSString *bthTagStr;
    NSString *urlString;
     int CategoryOne;
    NSMutableArray *postArr;
}


@end

@implementation ScrapOnePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IsIphoneX];
    postArr = [[NSMutableArray alloc] init];
    self.dataArray = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    postDict = [[NSMutableDictionary alloc] init];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    bthTagStr = @"0";
     CategoryOne = 0;
    [self first];
}
- (void)IsIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        
        
        self.leftImg.frame = CGRectMake(15, 51, 22, 19);
        self.rightImg.frame = CGRectMake(kScreenSize.width-32, 52, 17, 17);
        self.oneView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, 40);
        self.bigTableView.frame = CGRectMake(0, kNavHeight+40, kScreenSize.width, kScreenSize.height-40-kNavHeight);
        
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    CGRect lineFrame = self.lineView.frame;
    CGFloat oneWidth = (kScreenSize.width-1)/2;
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 202) {
        AddScrapVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"AddScrapVC"];
        callOneVC.reasonsArr = self.reasonsArr;
        callOneVC.typeStr = @"add";
        
        [self.navigationController pushViewController:callOneVC animated:YES];
    }else if (sender.tag == 203){
        lineFrame.origin.x = 0;
        CategoryOne = 0;
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        [self first];
    }else if (sender.tag == 204){
         CategoryOne = 1;
        lineFrame.origin.x = oneWidth+1;
        bthTagStr = [NSString stringWithFormat:@"%ld",sender.tag];
        [self.lineView setFrame:lineFrame];
        [self first];
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
        NSNumber *categoryNum = [NSNumber numberWithInteger:CategoryOne];
        [postDict setObject:categoryNum forKey:@"Category"];
  
    
    [self show];
    [[AFClient shareInstance] OnePage:postDict withArr:postOneArr withUrl:@"App/Wbp3002/OnePage" progressBlock:^(NSProgress *progress) {
        
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
                    PurchaseOnePageModel *model = [PurchaseOnePageModel new];
                    [model setValuesForKeysWithDictionary:dict];
                    //                    model.k1mf010 = @"呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪呢喃你那次可能全文你哪科去哪";
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

//-(void)getDataWithUrl:(NSString *)url {
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//    [self show];
//    [[AFClient shareInstance] GetNewWithArr:postOneArr withUrl:urlString progressBlock:^(NSProgress *progress) {
//        
//    } success:^(id responseBody) {
//        
//        if ([[responseBody valueForKey:@"status"] integerValue]== 200) {
//            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
//            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
//                AddPurchaseVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPurchaseVC"];
//                addVC.dataDict = [responseBody valueForKey:@"data"];
//                [self.navigationController pushViewController:addVC animated:YES];
//                
//                
//            }else {
//                
//                [self dismiss];
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
//                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                    }];
//                    [alertController addAction:cancelAction];
//                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                        [postOneArr removeAllObjects];
//                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
//                        [self getDataWithUrl:urlString];
//                        ;
//                    }];
//                    [alertController addAction:confirmAction];
//                    
//                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
//                    NSArray *options = [userResponseDict valueForKey:@"options" ];
//                    for (int i = 0; i < options.count; i++) {
//                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                            [postOneArr removeAllObjects];
//                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
//                            [self getDataWithUrl:urlString];
//                            
//                            ;
//                        }];
//                        [alertController addAction:home1Action];
//                    }
//                    //取消style:UIAlertActionStyleDefault
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
//                }
//                //添加取消到UIAlertController中
//                
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            
//        }else {
//            NSString *str = [responseBody valueForKey:@"errors"][0];
//            [self Alert:str];
//            
//        }
//        
//        [self dismiss];
//        
//    } failure:^(NSError *error) {
//        
//        [self dismiss];
//    }];
//    
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ScrapOnePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    _cell.ScrapDelegate = self;
    PurchaseOnePageModel *model = self.dataArray[indexPath.section];
    [_cell showModel:model];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    PurchaseOnePageModel *model = self.dataArray[indexPath.section];
    CGFloat hei = 215;
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
        
    }else {
        
        hei = 165;
    }
    
    return hei ;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PurchaseOnePageModel *model = self.dataArray[indexPath.section];
    
    if (model.isEditable == false) {
        
//        [self getPreviewWithIdStr:model.k1mf100];
        
    }
    
}

//-(void)getPreviewWithIdStr:(NSString *)idStr {
//    
//    [self show];
//    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3004/Preview" progressBlock:^(NSProgress *progress) {
//        
//    } success:^(id responseBody) {
//        if ([responseBody[@"status"] integerValue] == 200) {
//            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
//            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
//                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                PurchaseVC *purchase = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseVC"];
//                purchase.idStr = idStr;
//                purchase.dataDict = [responseBody valueForKey:@"data"];
//                [self.navigationController pushViewController:purchase animated:YES];
//                
//            }else{
//                [self dismiss];
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
//                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                    }];
//                    [alertController addAction:cancelAction];
//                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                        [postOneArr removeAllObjects];
//                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
//                        [self getDataWithUrl:idStr];
//                        ;
//                    }];
//                    [alertController addAction:confirmAction];
//                    
//                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
//                    NSArray *options = [userResponseDict valueForKey:@"options" ];
//                    for (int i = 0; i < options.count; i++) {
//                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
//                            [postOneArr removeAllObjects];
//                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
//                            [self getDataWithUrl:idStr];
//                            
//                            ;
//                        }];
//                        [alertController addAction:home1Action];
//                    }
//                    //取消style:UIAlertActionStyleDefault
//                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
//                }
//                //添加取消到UIAlertController中
//                
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            
//        }else{
//            NSString *str = [responseBody valueForKey:@"errors"][0];
//            [self Alert:str];
//            [self.navigationController popViewControllerAnimated:YES];
//            [self dismiss];
//            
//        }
//        [self dismiss];
//    } failure:^(NSError *error) {
//        [self dismiss];
//    }];
//    
//    
//    
//}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
-(void)postoneStr:(NSString *)idStr twoStr:(NSString *)str withModel:(PurchaseOnePageModel *)model {
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
            
        }
        
    }else if ([idStr isEqualToString:@"304"]  ){
        if (model.isDisplayEditButton) {
            AddScrapVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"AddScrapVC"];
            callOneVC.reasonsArr = self.reasonsArr;
            callOneVC.idStr = model.k1mf100;
            
            [self.navigationController pushViewController:callOneVC animated:YES];
        }else {
//            ScrapVC *scrapVC = [storyboard instantiateViewControllerWithIdentifier:@"ScrapVC"];
//            scrapVC.idStr = model.k1mf100;
//            [self.navigationController pushViewController:scrapVC animated:YES];
            [self getPreviewWithIdStr:model.k1mf100];
            
        }
        
        
    }else if ([idStr isEqualToString:@"303"]) {
        if (model.isDisplayCommitButton) {
            [self PreviewWithIdStr:model.k1mf100];
            
        }
        
    }else if ([idStr isEqualToString:@"302"]) {
        if (model.isDisplayEditButton) {
            AddScrapVC *callOneVC = [storyboard instantiateViewControllerWithIdentifier:@"AddScrapVC"];
            callOneVC.idStr = model.k1mf100;
            
            [self.navigationController pushViewController:callOneVC animated:YES];
        }
        
    }
    
}
-(void)PreviewWithIdStr:(NSString *)idStr{
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3002/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                NSDictionary *Dict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [Dict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                         PurchaseOnePageModel*model  = [PurchaseOnePageModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        
                        
                            [postArr addObject:dictOne];
                        }
                }
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                ScrapDetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"ScrapDetailVC"];
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
    [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3002/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
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
-(void)getPreviewWithIdStr:(NSString *)idStr {
    
    [self show];
    [[AFClient shareInstance] WBP3008Preview:idStr withArr:postOneArr withUrl:@"App/Wbp3002/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                ScrapVC *scrapVC = [storyboard instantiateViewControllerWithIdentifier:@"ScrapVC"];
                scrapVC.idStr = idStr;
                 scrapVC.dataDict = [responseBody valueForKey:@"data"];
                [self.navigationController pushViewController:scrapVC animated:YES];
              
                
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

-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3002/Destroy" progressBlock:^(NSProgress *progress) {
        
        
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
