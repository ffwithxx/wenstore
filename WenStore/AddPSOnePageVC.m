//
//  AddPSOnePageVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddPSOnePageVC.h"
#import "AddPSOnePageCell.h"
#import "PSDetailVC.h"
#import "AddPSModel.h"
#import "AFClient.h"
#import "BGControl.h"
#import "SearchVC.h"
#import "PSOnePageVC.h"
#import "orderCountThree.h"
#import "MainViewController.h"
#import "changePrice.h"

@interface AddPSOnePageVC ()<UITableViewDelegate,UITableViewDataSource,fanDataDelegate,psdelegate,inputdelegate,psOnedelegate,changedelegate,changePricedelegate> {
    AddPSOnePageCell *_cell;
    NSInteger lpdt036;
    NSInteger lpdt043;
    NSMutableArray *postArr;//点单数组
    NSMutableArray *postOneArr;//回传数组
    NSString *rightorXia;
    NSMutableDictionary *aLLdataDict;//整个数据
    NSMutableDictionary *rightDict;//右面tableView数组
    BOOL istrue;
    NSMutableArray *unitsArr;//units数据
    BOOL isSerch;
    CGFloat callTaleHei;
    changePrice *changeView;
    NSMutableDictionary *postMastDict;
    orderCountThree *orderView;
    NSString *psTypeStr;

}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;

@end

@implementation AddPSOnePageVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IsIphoneX];
    rightorXia = @"right";
    istrue = false;
    isSerch = NO;
    
    
    rightDict = [[NSMutableDictionary alloc] init];
    aLLdataDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3023lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3023lpdt036"] ] integerValue];
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
        self.sumpriceLab.hidden = YES;
    }else{
        self.sumpriceLab.hidden = NO;
    }
    
    
    [self first];

}
- (void)IsIphoneX {
    if (kiPhoneX) {
    
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
            self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftTableView.frame = CGRectMake(0, kNavHeight, 100, kScreenSize.height-kNavHeight-50);
        self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), kNavHeight, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 50-kNavHeight);
        self.leftImg.frame = CGRectMake(15, 49, 22, 19);
        self.searchImg.frame = CGRectMake(kScreenSize.width-32, 50, 17, 17);
        
        
    }
}
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        //for (NSInteger i = 1; i <= 5; i++) {
        //   [_datas addObject:[NSString stringWithFormat:@"第%zd分区", i]];
        //}
    }
    return _datas;
}

-(void)first {
    [self show];
    NSString *urlStr;
    
    if ([self.typeStr isEqualToString:@"add"]) {
        urlStr = @"App/Wbp3023/New";
        psTypeStr = @"add";
    }else {
        urlStr = @"App/Wbp3023/Edit";
        psTypeStr = @"edit";
    }
    [[AFClient shareInstance] GetEdit:self.idStr withArr:postOneArr withUrl:urlStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            [postArr removeAllObjects];
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                self.dataDict = [responseBody valueForKey:@"data"];
                if (![[NSString stringWithFormat:@"%@",[[self.dataDict valueForKey:@"master"] valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
                     self.sumpriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:[[self.dataDict valueForKey:@"master"] valueForKey:@"k1mf302"] afterPoint:lpdt043]];
                }else{
                    self.sumpriceLab.text = @"";
                }
                
                NSMutableArray *dataArr = [[NSMutableArray alloc] init];
                dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"groupDetail"];
                unitsArr = [[responseBody valueForKey:@"data"] valueForKey:@"units"];
                 NSInteger countOne = 0;
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    if ([BGControl isNULLOfString:titleStr]) {
                        titleStr = @"Default";
                    }
                   
                    
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        AddPSModel *model  = [AddPSModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        model.xianStr = @"1";
                        model.keyStr = [NSString stringWithFormat:@"%ld",countOne];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                        model.index = j;
                        model.indexOne = j;
                        model.k1dt201Price =[dictOne valueForKey:@"k1dt201"];
                        model.k1dt110Count =[dictOne valueForKey:@"k1dt110"];
                        model.k1dt101Count = [dictOne valueForKey:@"k1dt101"];
                        NSInteger count = 0 ;
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt110"]]]) {
                            model.k1dt110Count = [NSDecimalNumber decimalNumberWithString:@"0"];
                            
                        }
                        if ([model.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]] == NSOrderedDescending) {
                            count = count + 1;
                        }
                        
                        if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt101"]]]) {
                            model.k1dt101Count = [NSDecimalNumber decimalNumberWithString:@"0"];
                            
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
//                      self.sumCountLab.text =  [NSString stringWithFormat:@"%@%ld%@",@"已盘",postArr.count,@"件商品"];
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


- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        if (isSerch == true) {
            
            isSerch = NO;
            self.searchImg.hidden = NO;
            self.searchBth.enabled = YES;
            aLLdataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    AddPSModel *model = arrTwo[j];
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
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
           PSOnePageVC  *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"PSOnePageVC"];
            [self.navigationController pushViewController:mainVC animated:YES];
        }
    }else if (sender.tag == 202) {
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        
        
    }else if (sender.tag == 203) {
         [self ValidateCart];
    
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
        AddPSModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        NSNumber *imgNum = [NSNumber numberWithInt:model.imge004];
        [modelOne setValue:imgNum forKey:@"imge004"];
        [modelOne setValue:model.k1mf800 forKey:@"k1mf800"];
        [modelOne setValue:model.k1dt700 forKey:@"k1dt700"];
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
        
       
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        [modelOne setValue:model.k1dt101Count forKey:@"k1dt101"];
        [modelOne setValue:model.k1dt102 forKey:@"k1dt102"];
        [modelOne setValue:model.k1dt103 forKey:@"k1dt103"];
        [modelOne setValue:model.k1dt106 forKey:@"k1dt106"];
        NSNumber *k1dt402 = [NSNumber numberWithBool:model.k1dt402];
         [modelOne setValue:k1dt402 forKey:@"k1dt402"];
        [modelOne setValue:model.k1dt011 forKey:@"k1dt011"];
        [modelOne setValue:model.k1dt011d forKey:@"k1dt011d"];
        [modelOne setValue:model.k1dt110Count forKey:@"k1dt110"];
        NSNumber *isSameUnit = [NSNumber numberWithBool:model.isSameUnit];
        [modelOne setValue:isSameUnit forKey:@"isSameUnit"];
        [modelOne setValue:model.k1dt201Price forKey:@"k1dt201"];
        [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
        [modelOne setValue:model.k1dt601 forKey:@"k1dt601"];
        [modelOne setValue:model.k1dt800 forKey:@"k1dt800"];
        NSComparisonResult res = [model.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"0"]]];
        if (res == NSOrderedDescending) {
            [detailArr addObject:modelOne];
        }
       
    }
    [self show];
    [[AFClient shareInstance] postValidateCart:[self.dataDict valueForKey:@"master"] withIdStr:self.idStr detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3023/ValidateCart" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            [self dismiss];
            
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                PSDetailVC *detail = [storyboard instantiateViewControllerWithIdentifier:@"PSDetailVC"];
                detail.typeStr = psTypeStr;
                detail.k1mf107 =[[self.dataDict valueForKey:@"master"] valueForKey:@"k1mf107"];
                detail.k1mf101 =[[self.dataDict valueForKey:@"master"] valueForKey:@"k1mf101"];
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
-(void)fanDict:(NSMutableDictionary *)dict
{

    isSerch = true;
    self.searchImg.hidden = YES;
    self.searchBth.enabled = NO;
    aLLdataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            AddPSModel *model = arrTwo[j];
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
-(void)blackButtonClick {
    
    [self hiddleAllViews];
}
- (void)hiddleAllViews {
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    changeView.hidden = YES;
    [changeView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
}
- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - private
- (void)setBaseTableView {
    // leftTableView
    
    
    // rightTableView
     self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), kNavHeight, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 50-kNavHeight);
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
    
    return postArr.count;
    
    
    
    
}


//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return nil;
//    return self.datas[section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == self.leftTableView){
        static NSString *ID = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell)
            
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
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
        AddPSOnePageCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            _twoCell = [[AddPSOnePageCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            
        }
        
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.psDelegate = self;
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _twoCell.inputDelegate = self;
         _twoCell.changeDelegate = self;
        NSArray *arr = [aLLdataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        AddPSModel *model = arr[indexPath.row];
        //
        //        [_twoCell showModel:model withDict:self.dict widtRight:rightDict withKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section] withIndex:indexPath.row];
        //        _twoCell.delegate = self;
        //        _twoCell.orderDelegate = self;
        //        _twoCell.TanDelegate = self;
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

- (void)pstWithModel:(AddPSModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count {
    [self hiddleAllViews];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    AddPSModel *oneModel = oneArr[model.index];
    NSString *idStr = model.k1dt001;
    NSString *countIdStr = model.k1dt005;
    NSString *jijiaCountIdStr = model.k1dt011;
    if (tag == 1002 || tag == 1003 || tag == 1004) {
        oneModel.k1dt101Count = count;
    }
    if (tag == 1005 || tag == 1006 || tag == 1007) {
        oneModel.k1dt110Count = count;
    }
    
    NSComparisonResult compar = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparTwo = [oneModel.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    
    if (tag == 1002 || tag == 1003 ||tag == 1004) {
        NSDecimalNumber *maxCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        for (int i = 0; i < unitsArr.count ; i++) {
            NSDictionary *unitsDict = unitsArr[i];
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [countIdStr isEqualToString:[unitsDict valueForKey:@"itut003"]]) {
                NSComparisonResult compar = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar != NSOrderedAscending ) {
                    
                    maxCount = [oneModel.k1dt101Count decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    
                }
                
            }
        }
        for (int i = 0; i < unitsArr.count ; i++) {
            NSDictionary *unitsDict = unitsArr[i];
            if ([idStr isEqualToString: [unitsDict valueForKey:@"itut001"]] && [jijiaCountIdStr isEqualToString:[unitsDict valueForKey:@"itut003"]]) {
                NSComparisonResult compar = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar != NSOrderedAscending ) {
                    
                    maxCount = [maxCount decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[unitsDict valueForKey:@"itut006"]]]];
                    oneModel.k1dt110Count =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:maxCount afterPoint:lpdt036]];
                }
                
            }
        }
    }
    NSComparisonResult comparOne = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparThree = [oneModel.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (AddPSModel *twoModel in postArr) {
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
            AddPSModel *model = arrTwo[j];
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
    callTaleHei = 0;
    NSDecimalNumber *sumPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i< postArr.count; i++) {
        AddPSModel *Model = postArr[i];
        NSComparisonResult compar= [Model.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
        if (compar == NSOrderedDescending) {
            NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:@"0"];
            
            price = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt110Count]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt201Price]]];
            sumPrice = [sumPrice decimalNumberByAdding:price];
            callTaleHei = callTaleHei +65;
        }
        
    }
    if (![[NSString stringWithFormat:@"%@",sumPrice] isEqualToString:@"0"]) {
       self.sumpriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:sumPrice afterPoint:lpdt043]];
    }else{
        self.sumpriceLab.text = @"";
    }
    
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }
    
}
-(void)pstWithModel:(AddPSModel *)model withTag:(NSInteger)tag {
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
    
    orderView.addPSModel = model;
    orderView.typeStr = @"3023";
    orderView.psOnedelegate = self;
    orderView.tagStr = [NSString stringWithFormat:@"%ld",(long)tag];
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];
    
}
- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
}


-(void)changeWithModel:(AddPSModel *)model {
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
    
    changeView.PSModel = model;
    changeView.type = @"2";
    
    changeView.changeDelegate = self;
    
    changeView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [changeView.orderFile becomeFirstResponder];
    [self.view addSubview:changeView];
}
-(void)changePriceModel:(AddPSModel *)model withPrice:(NSDecimalNumber *)price {
    
   
        
        [self hiddleAllViews];
  
    
    NSMutableArray *oneArr= [self.ruleDita valueForKey:model.keyStr];
    AddPSModel *oneModel = oneArr[model.index];
    
    oneModel.k1dt201Price = price;
    
    
    
    NSComparisonResult comparOne = [oneModel.k1dt101Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSComparisonResult comparThree = [oneModel.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
    NSMutableArray *arr = [NSMutableArray new];
    for (AddPSModel *twoModel in postArr) {
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
            AddPSModel *model = arrTwo[j];
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
        AddPSModel *Model = postArr[i];
        NSComparisonResult compar= [Model.k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
        if (compar == NSOrderedDescending) {
            NSDecimalNumber *price = [NSDecimalNumber decimalNumberWithString:@"0"];
            
            price = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt110Count]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",Model.k1dt201Price]]];
            sumPrice = [sumPrice decimalNumberByAdding:price];
            callTaleHei = callTaleHei +65;
        }
        
    }
    if (![[NSString stringWithFormat:@"%@",sumPrice] isEqualToString:@"0"]) {
        self.sumpriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:sumPrice afterPoint:lpdt043]];
    }else{
        self.sumpriceLab.text = @"";
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
