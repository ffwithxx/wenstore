//
//  AddProducedVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddProducedVC.h"
#import "AddProducedCell.h"
#import "ProducedModel.h"
#import "AFClient.h"
#import "BGControl.h"
#define kCellName @"AddProducedCell"
#import "SearchVC.h"
#import "ProducedDetailVC.h"
#import "orderCountThree.h"
@interface AddProducedVC ()<UITableViewDelegate,UITableViewDataSource,fanDataDelegate,asideDelegate,orderCountDelegate,TanDelegate,producedDelegate> {
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
    
    NSMutableArray *unitsArr;//units数据
    orderCountThree *orderView;
    NSMutableDictionary *headDict;
    NSMutableDictionary *dataDict;
    NSMutableDictionary *mastDict;
    NSInteger lpdt042;//单价
    NSInteger lpdt043;//总价
    NSDecimalNumber *orderCount;
    NSDecimalNumber *priceNumber;
    NSMutableDictionary *updateDict;;
}

@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;
@end

@implementation AddProducedVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isSerch = NO;
    headDict = [[NSMutableDictionary alloc] init];
    postMastDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    rightDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray arrayWithArray:self.datas];
    postArr = [NSMutableArray array];
    [self firstOne];
    [self first];
    
}

- (void)first {
    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    self.dataArray = [NSMutableArray array];
    postOneArr = [NSMutableArray array];
    postArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3007lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3007lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3007lpdt042"] ] integerValue];
    
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        
    }
    return _datas;
}
-(void)firstOne {
    NSString *urlStr;
    if ([self.typeStr isEqualToString:@"add"]) {
        urlStr = @"App/Wbp3007/New";
    }else{
    urlStr = @"App/Wbp3007/Edit";
    }
    [self show];
    
    [[AFClient shareInstance] GetEdit:self.idStr withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                headDict = responseBody[@"data"];
                NSDictionary *dict = responseBody[@"data"];
                mastDict = [dict valueForKey:@"master"];
                self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已选",[BGControl notRounding:[mastDict valueForKey:@"k1mf303"] afterPoint:lpdt036],@"件商品"];
                priceNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf302"]]];
                orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf303"]]];
                rightDict = responseBody[@"data"];
                NSArray *dataArr = [dict valueForKey:@"groupDetail"];
                //                NSInteger count = 0;
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    [self.datas addObject:titleStr];
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        ProducedModel *model  = [ProducedModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        
                        
                        model.orderCount =[dictOne valueForKey:@"k1dt101"];
                        model.keyStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)i];
                        
                        model.xianStr = @"1";
                        model.index = j;
                        model.indexOne = j;
                        [model setValuesForKeysWithDictionary:dictOne];
                        
                        [arr addObject:model];
                        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
                            [postArr addObject:model];
                            
                        }
                    }
                    
                    [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)i]];
                    
                    
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = dataDict;
                self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
                
                [self dismiss];
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
                if (self.datas.count > 0) {
                    [self setBaseTableView];
                }
                
                
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
        }else{
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
            
            [self dismiss];
        }
        
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}



-(void)jiaoyan {
    
    NSMutableArray *uploadImgArr = [NSMutableArray array];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    postMastDict = [[NSMutableDictionary alloc] init];
    postMastDict = mastDict;
    [postMastDict setObject:priceNumber forKey:@"k1mf302"];
    [postMastDict setObject:orderCount forKey:@"k1mf303"];
    if (![self.typeStr isEqualToString:@"add"]) {
        [postMastDict setObject:self.idStr forKey:@"k1mf100"];
    }
    
    NSMutableArray *detailArr = [NSMutableArray new];
    for (int i = 0; i<postArr.count; i++) {
        ProducedModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
        //        [modelOne setValue:model.k1dt003d forKey:@"k1dt003d"];
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt201"];
        [modelOne setValue:model.orderCount forKey:@"k1dt101"];
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"0"]] forKey:@"k1dt102"];
        [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
        
        
        NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
        
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
        
        
        
        //        [modelOne setValue:model.k1dt103 forKey:@"k1dt103"];
        //        [modelOne setValue:model.k1dt104 forKey:@"k1dt104"];
        [detailArr addObject:modelOne];
    }
    [self show];
    
    [[AFClient shareInstance] postValidateCart:mastDict detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3007/ValidateCart" withjsob001:@"" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            [self dismiss];
            
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                updateDict = [[NSMutableDictionary alloc] init];
                [updateDict setObject:[dict valueForKey:@"master"] forKey:@"master"];
                [updateDict setObject:[dict valueForKey:@"detail"] forKey:@"detail"];
                ProducedDetailVC *detail = [storyboard instantiateViewControllerWithIdentifier:@"ProducedDetailVC"];
                detail.idStr = self.idStr;
                detail.masterDict = mastDict;
                detail.typeStr = self.typeStr;
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
-(void)fanDict:(NSMutableDictionary *)dict
{
 
    isSerch = true;
    self.searchBth.enabled = NO;
    self.searchImg.hidden = YES;
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            ProducedModel *model = arrTwo[j];
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
        //        [self Alert:@"没有"]
    }
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dict;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
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
        return 0;
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView){
        return self.datas.count;
    }else if (tableView == self.rightTableView){
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)section]];
        return arr.count ;
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
    else {
        
        // 通过不同标识创建cell实例
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        AddProducedCell  * _CellTwo = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_CellTwo) {
            _CellTwo = [[AddProducedCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        CGRect cellFrame = _CellTwo.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_CellTwo.contentView setFrame:cellFrame];
        
        _CellTwo.orderDelegate = self;
        _CellTwo.TanDelegate = self;
        _CellTwo.selectedBackgroundView=[[UIView alloc]initWithFrame:_CellTwo.frame];
        _CellTwo.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _CellTwo.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        ProducedModel *model = arr[indexPath.row];
        
        [_CellTwo showModel:model];
        
        return _CellTwo;
        
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果点击的是右边的tableView，不做任何处理
    if (tableView == self.rightTableView)
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
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
    }else{
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        ProducedModel *model = arr[indexPath.row];
        
        return 160;
        
        
    }
    
    return 0;
}

-(void) getproducedOrderCount:(NSDecimalNumber *)count withModel:(ProducedModel *)model {
    [self hilldeAll];
    
    model.orderCount = count;
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:model];
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            ProducedModel *model = arrTwo[j];
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
    
    NSMutableArray *arr = [NSMutableArray new];
    for (ProducedModel *oneModel in postArr) {
        [arr addObject:oneModel.k1dt001];
    }
    
    if ([arr containsObject:model.k1dt001]) {
        NSInteger index = [arr indexOfObject:model.k1dt001];
        model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        [postArr replaceObjectAtIndex:index withObject:model];
    }else{
        model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        [postArr addObject:model];
    }
    orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i <postArr.count; i++) {
        ProducedModel *modelTwo = postArr[i];
        NSString *countStr = [BGControl notRounding:modelTwo.orderCount afterPoint:lpdt036];
        orderCount = [orderCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:countStr]];
        orderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:orderCount afterPoint:lpdt036]];
        NSString *priceStr = [BGControl notRounding:modelTwo.k1dt201 afterPoint:lpdt042];
        NSDecimalNumber *zongPrice = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:priceStr]];
        priceNumber = [priceNumber decimalNumberByAdding:zongPrice];
        priceNumber = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    }
    self.sumCountLab.text =[NSString stringWithFormat:@"%@%@%@",@"已购",[BGControl notRounding:orderCount afterPoint:lpdt036],@"件商品"];
    [self.rightTableView reloadData];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return 0;
//    return 30;
//}


-(void)scrapwithModel:(ProducedModel *)model{
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
    
    orderView.producedModel = model;
    orderView.typeStr = @"3007";
    orderView.producedDelegate = self;
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];
    
    
}




-(void)blackButtonClick {
    [self hilldeAll];
}
-(void)hilldeAll {
    self.blackButton.hidden = YES;
    
    [orderView removeFromSuperview];
    
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 重新选中一下当前选中的行数，不然会有bug
    if (self.currentSelectIndexPath) self.currentSelectIndexPath = nil;
}



- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 201) {
        if (isSerch == true) {
            
            isSerch = NO;
            self.searchBth.enabled = YES;
            self.searchImg.hidden = NO;
            dataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    ProducedModel *model = arrTwo[j];
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
            
        }else {
        [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (sender.tag == 203){
        if (postArr.count>0) {
            [self jiaoyan];
        }
        
        
        
        
        
    }else if (sender.tag == 204){
        if (postArr.count>0) {
            [self jiaoyan];
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
