//
//  AddStocktakVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddStocktakVC.h"
#import "AddStocktakVCCell.h"
#import "StocktakModel.h"
#import "AFClient.h"
#import "BGControl.h"
#define kCellName @"AddStocktakVCCell"
#import "SearchVC.h"
#import "StocktakDetailVC.h"
#import "orderCountThree.h"
@interface AddStocktakVC ()<UITableViewDelegate,UITableViewDataSource,fanDataDelegate,cancleDelegate,stockDelegate,inputDelegate,stockOneDelegate> {
    NSInteger lpdt036;
    NSMutableArray *postArr;//点单数组
    NSMutableArray *postOneArr;//回传数组
    NSString *rightorXia;
    NSMutableDictionary *aLLdataDict;//整个数据
    NSMutableDictionary *rightDict;//右面tableView数组
    BOOL istrue;
    BOOL isSerch;
    NSMutableDictionary *postMastDict;
    NSString *allChoice;
    AddStocktakVCCell *_twoCell;
    NSMutableArray *unitsArr;//units数据
    orderCountThree *orderView;
}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;


@end

@implementation AddStocktakVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [super viewDidLoad];
    allChoice = @"1";//1为未全盘  2 为全盘
    isSerch = NO;
    istrue = false;
    rightDict = [[NSMutableDictionary alloc] init];
    aLLdataDict = [[NSMutableDictionary alloc] init];
    self.dataDict = [[NSMutableDictionary alloc] init];
    unitsArr = [[NSMutableArray alloc] init];
    _ruleArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray new];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    [self first];

}

- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        //                for (NSInteger i = 1; i <= 5; i++) {
        //                    [_datas addObject:[NSString stringWithFormat:@"第%zd分区", i]];
        //                }
    }
    return _datas;
}

-(void)first {
    [self show];
    [[AFClient shareInstance] GetEdit:self.idStr withArr:postOneArr withUrl:self.urlStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            [postArr removeAllObjects];
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                self.dataDict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"groupDetail"];
                unitsArr = [[responseBody valueForKey:@"data"] valueForKey:@"units"];
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    [self.datas addObject:titleStr];
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        StocktakModel *model  = [StocktakModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        model.xianStr = @"1";
              
                        model.isCancle = YES;
                        model.keyStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.index = j;
                        model.indexOne = j;
                        model.k1dt011nCount =[dictOne valueForKey:@"k1dt011n"];
                        model.k1dt012nCount =  [dictOne valueForKey:@"k1dt012n"]  ;
                        model.k1dt013nCount = [dictOne valueForKey:@"k1dt013n"];
                        model.k1dt101Count = [dictOne valueForKey:@"k1dt101"];
                        NSInteger count = 0 ;
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt011n"]]]) {
                             model.k1dt011nCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                            
                        }
                        if ([model.k1dt011nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                             count = count + 1;
                        }
                        
                            if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt012n"]]]) {
                            model.k1dt012nCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                             count = count + 1;
                        }
                        
                        if ([model.k1dt012nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt013n"]]]) {
                            model.k1dt013nCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                             count = count + 1;
                        }
                        if ([model.k1dt013nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt101"]]]) {
                            model.k1dt101Count = [NSDecimalNumber decimalNumberWithString:@"0"];
                             count = count + 1;
                        }
                        if ([model.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        
                        [model setValuesForKeysWithDictionary:dictOne];
                        
                        [arr addObject:model];
                        if (count > 0) {
                            [postArr addObject:model];
                        }
                    }
                    
                    [aLLdataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)i]];
                    
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
                     self.sumCountLab.text =  [NSString stringWithFormat:@"%@%ld%@",@"已盘",postArr.count,@"件商品"];
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
    if (self.datas.count >0) {
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
        _twoCell = [tableView dequeueReusableCellWithIdentifier:kCellName];
        if (!_twoCell) {
            _twoCell = [[AddStocktakVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
            
            
        }
        
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _twoCell.cancleDelegate = self;
        _twoCell.stockDelegate = self;
        _twoCell.inputDelegate = self;
        NSArray *arr = [aLLdataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        StocktakModel *model = arr[indexPath.row];
        [_twoCell showModel:model withType:allChoice];
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
            return 170;
        }else {
            return 200;
        }
    }
    return 65;
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 重新选中一下当前选中的行数，不然会有bug
    if (self.currentSelectIndexPath) self.currentSelectIndexPath = nil;
}



-(void)fanDict:(NSMutableDictionary *)dict
{

    isSerch = true;
    self.searchBth.enabled = NO;
    self.searchImg.hidden = YES;
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            StocktakModel *model = arrTwo[j];
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





- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        if (isSerch == true) {
            isSerch = NO;
            self.searchBth.enabled = YES;
            self.searchImg.hidden = NO;
            aLLdataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    StocktakModel *model = arrTwo[j];
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
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        
        
    }else if (sender.tag == 202) {
       
        for (int i = 0; i< self.datas.count; i++) {
            NSMutableArray *arr = [[NSMutableArray alloc] init];
            arr = [aLLdataDict valueForKey:[NSString stringWithFormat:@"%d",i]];
            
            for (int j = 0; j < arr.count; j++) {
               StocktakModel *model = arr[j];
                model.isCancle = NO;
            
                
                [arr replaceObjectAtIndex:j withObject:model];
            }
            [aLLdataDict setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];

        }
        
        
        [self.leftTableView reloadData];
        [self.rightTableView reloadData];
        if (self.datas.count > 0) {
            [self setBaseTableView];
        }
       
    }else if (sender.tag == 204) {
        if (postArr.count >0) {
              [self ValidateCart];
        }
      
    }


}

- (void)ValidateCart{

        postMastDict = [[NSMutableDictionary alloc] init];
        postMastDict = [self.dataDict valueForKey:@"master"];


    NSMutableArray *uploadImgArr = [NSMutableArray array];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    NSMutableArray *detailArr = [NSMutableArray new];

        for (int i = 0; i<postArr.count; i++) {
            StocktakModel *model = postArr[i];
            NSMutableDictionary *modelOne = [NSMutableDictionary new];
            NSNumber *imgNum = [NSNumber numberWithInt:model.imge004];
            [modelOne setValue:imgNum forKey:@"imge004"];
             [modelOne setValue:model.k1dt700 forKey:@"k1dt700"];
            [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
            [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
            [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
            
            [modelOne setValue:model.k1dt03d forKey:@"k1dt03d"];
            [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
            [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
            
            [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
            [modelOne setValue:model.k1dt011d forKey:@"k1dt011d"];
            [modelOne setValue:model.k1dt011 forKey:@"k1dt011"];
            
            [modelOne setValue:model.k1dt011nCount forKey:@"k1dt011n"];
            [modelOne setValue:model.k1dt012d forKey:@"k1dt012d"];
            [modelOne setValue:model.k1dt012 forKey:@"k1dt012"];
            
            [modelOne setValue:model.k1dt012nCount forKey:@"k1dt012n"];
            [modelOne setValue:model.k1dt012d forKey:@"k1dt012nCount"];
            [modelOne setValue:model.k1dt013d forKey:@"k1dt013d"];
            
            [modelOne setValue:model.k1dt013 forKey:@"k1dt013"];
            [modelOne setValue:model.k1dt013nCount forKey:@"k1dt013n"];
            [modelOne setValue:model.k1dt101Count forKey:@"k1dt101"];
            NSNumber *k1dt401 = [NSNumber numberWithBool:model.k1dt401];
            [modelOne setValue:k1dt401 forKey:@"k1dt401"];
             [modelOne setValue:model.k1dt201 forKey:@"k1dt201"];
            [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
            [detailArr addObject:modelOne];
        }
        [self show];
        [[AFClient shareInstance] postValidateCart:[self.dataDict valueForKey:@"master"] withIdStr:self.idStr detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3003/ValidateCart" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                [self dismiss];
                
                NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                   
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    StocktakDetailVC *detailVC = [storyboard instantiateViewControllerWithIdentifier:@"StocktakDetailVC"];
                    detailVC.dataDict = [responseBody valueForKey:@"data"];
                    detailVC.typeStr = self.typeStr;
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
/* delegate*/

- (void)cancle:(StocktakModel *)model {
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    StocktakModel *oneModel = oneArr[model.index];
    oneModel.k1dt011nCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    oneModel.k1dt012nCount = [NSDecimalNumber decimalNumberWithString:@"0"];;
    oneModel.k1dt013nCount = [NSDecimalNumber decimalNumberWithString:@"0"];;
    oneModel.k1dt101Count = [NSDecimalNumber decimalNumberWithString:@"0"];;
    oneModel.isCancle = YES;
  [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:oneModel];
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            StocktakModel *model = arrTwo[j];
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
    
    NSMutableArray *arr = [NSMutableArray new];
    for (StocktakModel *twoModel in postArr) {
        [arr addObject:twoModel.k1dt001];
    }
    if ([arr containsObject:oneModel.k1dt001]) {
        NSInteger indexone = [arr indexOfObject:oneModel.k1dt001];
        [postArr removeObjectAtIndex:indexone];
    }
  self.sumCountLab.text =  [NSString stringWithFormat:@"%@%ld%@",@"已盘",postArr.count,@"件商品"];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }


}

- (void)stockWithModel:(StocktakModel *)model withTag:(NSInteger)tag with:(NSDecimalNumber *)count {
    [self hiddleAllViews];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    StocktakModel *oneModel = oneArr[model.index];
    NSString *stocktakIdStr = model.k1dt005d;
    NSString *idStr = model.k1dt001;
    NSString *maxIdStr = model.k1dt011d;
    NSString *middleStr = model.k1dt012d;
    NSString *minStr = model.k1dt013d;
    NSString *panStr = model.k1dt005d;
    oneModel.isCancle = NO;
    if (tag == 1002 || tag == 1003 || tag == 1004) {
        if ([BGControl isNULLOfString:model.k1dt011d]) {
             oneModel.k1dt101Count = count;
        }else {
        oneModel.k1dt011nCount = count;
        }
        
    }
    if (tag == 1005 || tag == 1006 || tag == 1007) {
        oneModel.k1dt012nCount = count;
    }
    if (tag == 1008 || tag == 1009 || tag == 1010) {
        oneModel.k1dt013nCount = count;
    }
    NSDecimalNumber *allCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSInteger countNum = 0;
    for (int i = 0; i < unitsArr.count ; i++) {
        NSDictionary *unitsDict = unitsArr[i];
        
      
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [maxIdStr isEqualToString:[unitsDict valueForKey:@"itut002"]]) {
                NSComparisonResult compar = [oneModel.k1dt011nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar == NSOrderedDescending ) {
                    NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                    maxCount = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@",oneModel.k1dt011nCount]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    allCount = [maxCount decimalNumberByAdding:allCount];
                    countNum = countNum + 1;
                }
                
            }
 
       
        
       
        
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [middleStr isEqualToString:[unitsDict valueForKey:@"itut002"]]) {
                 NSComparisonResult k1dt012compar = [oneModel.k1dt012nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (k1dt012compar == NSOrderedDescending ) {
                    NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                    maxCount = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@",oneModel.k1dt012nCount]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    allCount = [maxCount decimalNumberByAdding:allCount];
                    countNum = countNum + 1;

                }
            }

        
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [minStr isEqualToString:[unitsDict valueForKey:@"itut002"]]) {
                  NSComparisonResult compar = [oneModel.k1dt013nCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                  if (compar == NSOrderedDescending ) {
            NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
            maxCount = [  [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@",oneModel.k1dt013nCount]]]  decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
            allCount = [maxCount decimalNumberByAdding:allCount];
            countNum = countNum + 1;
        }
        }
        
        if (countNum == 0)  {
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [panStr isEqualToString:[unitsDict valueForKey:@"itut002"]]) {
                NSComparisonResult compar = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar == NSOrderedDescending ) {
                    NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
                    maxCount = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%@",oneModel.k1dt101Count]]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    allCount = [maxCount decimalNumberByAdding:allCount];
                    countNum = countNum + 1;
                }
            }

        }

    }
    
    NSMutableArray *arr = [NSMutableArray new];
    for (StocktakModel *twoModel in postArr) {
        [arr addObject:twoModel.k1dt001];
    }
    if ([arr containsObject:oneModel.k1dt001]) {
         NSInteger indexone = [arr indexOfObject:oneModel.k1dt001];
        if (countNum > 0) {
            [postArr replaceObjectAtIndex:indexone withObject:oneModel];
        }else {
            [postArr removeObjectAtIndex:indexone];
        }
    
    }else {
        if (countNum > 0) {
            [postArr addObject:oneModel];
        }
    }
    
    self.sumCountLab.text =  [NSString stringWithFormat:@"%@%ld%@",@"已盘",postArr.count,@"件商品"];
    oneModel.k1dt101Count = allCount;
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:oneModel];
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            StocktakModel *model = arrTwo[j];
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
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }


}
- (void)stockWithModel:(StocktakModel *)model withTag:(NSInteger)tag{
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
    
    orderView.StocktaModel = model;
    orderView.typeStr = @"3003";
    orderView.stockDelegate = self;
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
    [orderView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
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
