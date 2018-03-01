//
//  AddPurchaseVC.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddPurchaseVC.h"
#import "AddPurchaseCell.h"
#import "AddPurchaseModel.h"
#import "BGControl.h"
#import "AFClient.h"
#import "SearchVC.h"
#import "PurchaseDetailVC.h"
#import "orderCountThree.h"
#import "changePrice.h"

@interface AddPurchaseVC ()<UITableViewDelegate,UITableViewDataSource,fanDataDelegate,purchasedelegate,inpuedelegate,changePricedelegate> {
    NSInteger lpdt036;
    NSInteger lpdt042;
    NSInteger lpdt043;
    NSMutableArray *postArr;//点单数组
    NSMutableArray *postOneArr;//回传数组
    NSMutableDictionary *rightDict;//右面tableView数组
    BOOL istrue;
    NSMutableDictionary *aLLdataDict;//整个数据
  
    NSMutableArray *unitsArr;//units数据
    BOOL isSerch;
    NSMutableDictionary *postMastDict;
    NSMutableDictionary *masterDict;
    orderCountThree *orderView;
     changePrice *changeView;
}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;

@end

@implementation AddPurchaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    istrue = false;
    self.view.backgroundColor = kBackGroungColor;
    rightDict = [[NSMutableDictionary alloc] init];
    aLLdataDict = [[NSMutableDictionary alloc] init];
    masterDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    unitsArr = [[NSMutableArray alloc] init];
    self.dataArray = [NSMutableArray array];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt042"] ] integerValue];
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
        self.sumPriceLab.hidden = YES;
    }else{
        self.sumPriceLab.hidden = NO;
    }
    
    
    [self first];

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
-(void)first {
    [self show];
    NSString *urlStr;
    urlStr = @"App/Wbp3004/Edit";
    [[AFClient shareInstance] GetEdit:_idStr withArr:postOneArr withUrl:urlStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            [postArr removeAllObjects];
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                self.dataDict = [responseBody valueForKey:@"data"];
                masterDict = [self.dataDict valueForKey:@"master"];
                if (![[NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
                      self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[masterDict valueForKey:@"k1mf302"]];
                }else{
                    self.sumPriceLab.text = @"";
                }
             
                NSMutableArray *dataArr = [[NSMutableArray alloc] init];
                dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"groupDetail"];
                unitsArr = [[responseBody valueForKey:@"data"] valueForKey:@"units"];
                
                
//                for (int i = 0; i < dataArr.count; i++) {
//                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
//                    if ([titleStr isEqualToString:@"__HIDDEN__"]) {
//                        [dataArr removeObjectAtIndex:i];
//                    }
//                }
                 NSInteger countOne = 0;
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    if ([BGControl isNULLOfString:titleStr]) {
                        titleStr = @"Default";
                    }
                   
                    
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        AddPurchaseModel *model  = [AddPurchaseModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        model.xianStr = @"1";
                        
                        
                        model.keyStr = [NSString stringWithFormat:@"%ld",countOne];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                        model.index = j;
                        model.indexOne = j;
                        model.orderCount =[dictOne valueForKey:@"k1dt101"];
                        model.jijiaOrderCount = [dictOne valueForKey:@"k1dt110"];
                        model.k1dt201Price =[dictOne valueForKey:@"k1dt201"];
                        NSInteger count = 0 ;
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt101"]]]) {
                            model.orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                            
                        }
                        if ([model.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt110"]]]) {
                            model.jijiaOrderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                            
                        }
                        if ([model.jijiaOrderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        
                        
                        
                        [model setValuesForKeysWithDictionary:dictOne];
                        
                        [arr addObject:model];
//                        if (count > 0) {
                            [postArr addObject:model];
//                        }
                    }
                    if (arr.count > 0) {
                         [self.datas addObject:titleStr];
                          [aLLdataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",countOne]];
                         countOne = countOne + 1;
                    }
                  
                    
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = aLLdataDict;
                self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
                [self dismiss];
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
                if (self.datas.count > 0) {
                    [self setBaseTableView];
                }
                
                if (postArr.count > 0) {
                    //  self.sumCountLab.text =  [NSString stringWithFormat:@"%@%ld%@",@"已盘",postArr.count,@"件商品"];
                }
            }else{
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
                        [self first];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            //[postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self first];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                        [self.navigationController popViewControllerAnimated:YES ];
                    }];
                    
                    [alertController addAction:cancelAction];
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

/*
 201 返回
 202 搜索
 203 提交
 */
- (IBAction)buttonClick:(UIButton *)sender {
   
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    if (sender.tag == 201) {
        if (isSerch == true) {
            
            isSerch = NO;
            self.SearchImg.hidden = NO;
            self.searchBth.enabled = YES;
            aLLdataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    AddPurchaseModel *model = arrTwo[j];
                    model.xianStr = @"1";
                    [arr addObject:model];
                    
                }
                [aLLdataDict setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];
            }
            
            
            self.ruleDita = [[NSMutableDictionary alloc] init];
            self.ruleDita = aLLdataDict;
            self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
            [self.rightTableView reloadData];
            [self.leftTableView reloadData];
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
        }else {
        [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (sender.tag == 203) {
        if (postArr.count >0) {
            [self ValidateCart];
        }
    }else if (sender.tag == 202) {
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        }

    

}

-(void)fanDict:(NSMutableDictionary *)dict
{

    isSerch = true;
    self.SearchImg.hidden = YES;
    self.searchBth.enabled = NO;
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            AddPurchaseModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                ;
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            count = count+1;
            [aLLdataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",count-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    
    if (self.datas.count<1) {
        self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
        aLLdataDict = [[NSMutableDictionary alloc] init];
        aLLdataDict = self.ruleDita;
        //        [self Alert:@"没有"]
    }
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dict;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
- (void)ValidateCart{
    
    postMastDict = [[NSMutableDictionary alloc] init];
    postMastDict = [self.dataDict valueForKey:@"master"];
    
    
    NSMutableArray *uploadImgArr = [NSMutableArray array];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    NSMutableArray *detailArr = [NSMutableArray new];
    
    for (int i = 0; i<postArr.count; i++) {
        AddPurchaseModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        NSNumber *imgNum = [NSNumber numberWithInt:model.imge004];
        [modelOne setValue:imgNum forKey:@"imge004"];
     
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
        
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        
        [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
        [modelOne setValue:model.orderCount forKey:@"k1dt101"];
        [modelOne setValue:model.k1dt102 forKey:@"k1dt102"];
        [modelOne setValue:model.k1dt011 forKey:@"k1dt011"];
        [modelOne setValue:model.k1dt011d forKey:@"k1dt011d"];
        [modelOne setValue:model.jijiaOrderCount forKey:@"k1dt110"];
        
        [modelOne setValue:model.k1dt201Price forKey:@"k1dt201"];
        [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
        NSNumber *k1dt402 = [NSNumber numberWithBool:model.k1dt402];
        [modelOne setValue:k1dt402 forKey:@"k1dt402"];
        
        [modelOne setValue:model.k1dt106 forKey:@"k1dt106"];
        [modelOne setValue:model.k1dt503 forKey:@"k1dt503"];
        
        NSNumber *isSameUnit = [NSNumber numberWithBool:model.isSameUnit];
        [modelOne setValue:isSameUnit forKey:@"isSameUnit"];
        [modelOne setValue:model.k1dt011Unit forKey:@"k1dt011Unit"];
        [modelOne setValue:model.k1dt011UnitText forKey:@"k1dt011UnitText"];
        NSComparisonResult res = [model.orderCount compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"0"]]];
        if (res == NSOrderedDescending) {
            [detailArr addObject:modelOne];
        }
      
    }
    [self show];
    [[AFClient shareInstance] postValidateCart:[self.dataDict valueForKey:@"master"] withIdStr:self.idStr detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3004/ValidateCart" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            [self dismiss];
            
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                PurchaseDetailVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseDetailVC"];
                detailVC.dataDict = [responseBody valueForKey:@"data"];
                detailVC.typeStr = @"1";
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
                        [self ValidateCart];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self ValidateCart];
                            
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
        
        NSArray *arr = [aLLdataDict valueForKey:[NSString stringWithFormat:@"%ld",section]];
        return arr.count;
    }
    
    return 0;
    
    
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
        AddPurchaseCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            _twoCell = [[AddPurchaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
        }
        
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.purchaseDelegate = self;
        _twoCell.changeDelegate = self;
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        NSArray *arr = [aLLdataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        AddPurchaseModel *model = arr[indexPath.row];
        _twoCell.inputDelegate = self;
        [_twoCell showModelWith:model];
        return _twoCell;
        
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
        if (kScreenSize.width == 320) {
            return 186;
        }else {
            return 249;
        }
    }
    return 65;
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

-(void)procurementWithModel:(AddPurchaseModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count {
    [self hiddleAllViews];
  
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    AddPurchaseModel *oneModel = oneArr[model.index];
    NSString *idStr = model.k1dt001;
    NSString *countIdStr = model.k1dt005;
    NSString *jijiaCountIdStr = model.k1dt011;
    if (![BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.MaxK1dt101]]) {
        NSComparisonResult compar = [count compare:model.MaxK1dt101];
        if (compar == NSOrderedDescending) {
            count = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.MaxK1dt101]];
            NSString *str = [NSString stringWithFormat:@"%@%@",@"已超过进货数量，最多只能进货",[BGControl notRounding:model.MaxK1dt101 afterPoint:lpdt036]];
            [self Alert:str];
         
        }
    }
    if (tag == 1002 || tag == 1003 || tag == 1004) {
        oneModel.orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
    }
    if (tag == 1005 || tag == 1006 || tag == 1007) {
        oneModel.jijiaOrderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",count]];
    }
    
    NSComparisonResult compar = [oneModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparTwo = [oneModel.jijiaOrderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    
    if (tag == 1002 || tag == 1003 ||tag == 1004) {
        NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        for (int i = 0; i < unitsArr.count ; i++) {
            NSDictionary *unitsDict = unitsArr[i];
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [countIdStr isEqualToString:[unitsDict valueForKey:@"itut003"]]) {
                NSComparisonResult compar = [oneModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar != NSOrderedAscending ) {
                    
                    maxCount = [oneModel.orderCount decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    
                }
                
            }
        }
        for (int i = 0; i < unitsArr.count ; i++) {
            NSDictionary *unitsDict = unitsArr[i];
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [jijiaCountIdStr isEqualToString:[unitsDict valueForKey:@"itut003"]]) {
                NSComparisonResult compar = [oneModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar != NSOrderedAscending ) {
                    
                    maxCount = [maxCount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    oneModel.jijiaOrderCount =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:maxCount afterPoint:lpdt036]];
                }
                
            }
        }
    }
    NSComparisonResult comparOne = [oneModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparThree = [oneModel.jijiaOrderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (AddPurchaseModel *twoModel in postArr) {
        [arr addObject:twoModel.k1dt001];
    }
    
    
    if ([arr containsObject:oneModel.k1dt001]) {
        NSInteger indexone = [arr indexOfObject:oneModel.k1dt001];
        if (comparOne == NSOrderedDescending ||comparThree == NSOrderedDescending ) {
            [postArr replaceObjectAtIndex:indexone withObject:oneModel];
        }else {
            [postArr removeObjectAtIndex:indexone];
        }
        
    }else {
        if (comparOne == NSOrderedDescending ||comparThree == NSOrderedDescending ) {
            [postArr addObject:oneModel];
        }
        
    }
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:oneModel];
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            AddPurchaseModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            countOne = countOne+1;
            [aLLdataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i< postArr.count; i++) {
        AddPurchaseModel *Model = postArr[i];
          NSComparisonResult compar= [Model.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
        if (compar == NSOrderedDescending) {
            NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:@"0"];
            NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.jijiaOrderCount]];
            price = [dec decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt201Price]]];
            sumPrice = [sumPrice decimalNumberByAdding:price];
        }
        
    }
    if (![[NSString stringWithFormat:@"%@",sumPrice] isEqualToString:@"0"]) {
        self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:sumPrice afterPoint:lpdt043]];
    }else{
        self.sumPriceLab.text = @"";
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }

}
-(void)procurementWithModel:(AddPurchaseModel *)model withTag:(NSInteger)tag {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"orderCountThree" owner:self options:nil];
    self.blackButton.hidden = YES;
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
    
    orderView.PurchaseModel = model;
    orderView.typeStr = @"3004";
    orderView.purchaseDelegate = self;
    orderView.tagStr = [NSString stringWithFormat:@"%ld",(long)tag];
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];

}

-(void)blackButtonClick {
    
    [self hiddleAllViews];
}
- (void)hiddleAllViews {

    orderView.hidden = YES;
    changeView.hidden = YES;
    [changeView.orderFile resignFirstResponder];
    [orderView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
}
- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}


#pragma  mark --- 修改单价
-(void)changeWithModel:(AddPurchaseModel *)model {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"changePrice" owner:self options:nil];
    self.blackButton.hidden = YES;
    self.blackButton.hidden = NO;
    changeView = [nib firstObject];
    changeView.clipsToBounds = YES;
    CGRect ipRect = changeView.frame;
    ipRect.size.width = kScreenSize.width - 40;
    [changeView setFrame:ipRect];
    changeView.subMitBth.clipsToBounds = YES;
    changeView.subMitBth.layer.cornerRadius = 10.f;
    changeView.center = self.view.center;
    changeView.bigView.clipsToBounds = YES;
    changeView.bigView.layer.borderColor = [kLineColor CGColor];
    changeView.bigView.layer.cornerRadius = 5.f;
    changeView.bigView.layer.borderWidth = 1.0f;
    changeView.layer.cornerRadius = 5.f;
    
    changeView.PurchModel = model;
    changeView.type = @"3";
    
    changeView.changeDelegate = self;
    
    changeView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [changeView.orderFile becomeFirstResponder];
    [self.view addSubview:changeView];
}
-(void)changePriceModel:(AddPurchaseModel *)model withPrice:(NSDecimalNumber *)price {
    
        [self hiddleAllViews];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    AddPurchaseModel *oneModel = oneArr[model.index];
    
    oneModel.k1dt201Price = price;
    
    
    
    NSComparisonResult comparOne = [oneModel.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparThree = [oneModel.jijiaOrderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (AddProcurementModel *twoModel in postArr) {
        [arr addObject:twoModel.k1dt001];
    }
    
    
    if ([arr containsObject:oneModel.k1dt001]) {
        NSInteger indexone = [arr indexOfObject:oneModel.k1dt001];
        if (comparOne == NSOrderedDescending ||comparThree == NSOrderedDescending ) {
            [postArr replaceObjectAtIndex:indexone withObject:oneModel];
        }else {
            [postArr removeObjectAtIndex:indexone];
        }
        
    }else {
        if (comparOne == NSOrderedDescending ||comparThree == NSOrderedDescending ) {
            [postArr addObject:oneModel];
        }
    }
    
    
    
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:oneModel];
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            AddProcurementModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            countOne = countOne+1;
            [aLLdataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    
    NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i< postArr.count; i++) {
        AddPurchaseModel *Model = postArr[i];
        NSComparisonResult compar= [Model.orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
        if (compar == NSOrderedDescending) {
            NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:@"0"];
            NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.jijiaOrderCount]];
            price = [dec decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt201Price]]];
            sumPrice = [sumPrice decimalNumberByAdding:price];
        }
        
    }
    if (![[NSString stringWithFormat:@"%@",sumPrice] isEqualToString:@"0"]) {
        self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:sumPrice afterPoint:lpdt043]];
    }else{
        self.sumPriceLab.text = @"";
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }
    
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
