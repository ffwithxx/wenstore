//
//  DialAddNewVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/2.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "DialAddNewVC.h"
#import "DialAddNewCell.h"
#import "DialModel.h"
#import "orderCountThree.h"
#import "SearchVC.h"
#import "BGControl.h"
#define kCellName @"DialAddNewCell"
@interface DialAddNewVC ()<UITableViewDelegate,UITableViewDataSource,TanDelegate,orderCountDelegate,fanDataDelegate,dialDelegate> {
    NSMutableArray *arrOne;
    NSMutableArray *two;
    NSMutableDictionary *mastDict;
    NSMutableDictionary *dataDict;
    NSMutableDictionary *rightDict;
    NSMutableDictionary *postMastDict;
    NSMutableArray *postArr;
    NSInteger lpdt036;//数量
    NSInteger lpdt042;//单价
    NSInteger lpdt043;//总价
    NSMutableArray *postOneArr;
    orderCountThree *orderView;
    NSDecimalNumber *orderCount;
    NSDecimalNumber *priceNumber;
    BOOL isSerch;;
}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;

@end

@implementation DialAddNewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isSerch = NO;
    postMastDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    rightDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray arrayWithArray:self.datas];
    postArr = [NSMutableArray array];
    [self first];
    
    [self firstOne];
    // Do any additional setup after loading the view.
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
                    DialModel *model = arrTwo[j];
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
        if (_zengdelegate && [_zengdelegate respondsToSelector:@selector(zengDict:withArr:)]) {
            [_zengdelegate zengDict:self.dataDict withArr:self.dataArray];
        }
        
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 202) {
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        }
        
    }

-(void)first{
    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    
    postOneArr = [NSMutableArray array];
    postArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3010lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3010lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3010lpdt042"] ] integerValue];
    
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

-(void)firstOne{
    mastDict = [self.headDict valueForKey:@"master"];
    rightDict = self.headDict;
    NSArray *dataArr = [self.headDict valueForKey:@"units"];
    NSInteger count = 0;
     NSInteger countOne = 0;
    for (int i = 0; i<dataArr.count; i++) {
    NSString *titleStr = [dataArr[i] valueForKey:@"k1dt004"];
        
        DialModel *model  = [DialModel new];
        NSDictionary *dictOne = dataArr[i];
        model.orderCount = [dictOne valueForKey:@"k1dt101"];
        
        model.xianStr = @"1";
        [model setValuesForKeysWithDictionary:dictOne];
        if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
            model.keyStr = [NSString stringWithFormat:@"%ld",(long)count];
            model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)count];
            model.index = countOne;
            model.indexOne = countOne;
            countOne = countOne+1;
            [postArr addObject:model];
       
        }

        if ([self.datas containsObject:titleStr]) {
            NSInteger indexNum = [self.datas indexOfObject:titleStr] ;
            NSMutableArray *arr = [[NSMutableArray  alloc] init];
            arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexNum]];
            [arr addObject:model];
             [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)indexNum]];
        }else {
            [self.datas addObject:titleStr];
            NSInteger count = self.datas.count;
            NSMutableArray *arr = [[NSMutableArray  alloc] init];
        
            [arr addObject:model];
            [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)count-1]];
            
        }
       
        
    }
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dataDict;
    self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
    
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }
    
    
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
        DialAddNewCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            
            _twoCell = [[DialAddNewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
            __weak __typeof(&*_twoCell) weakCell = _twoCell;
            //weakCell.block = ^(NSInteger nCount, BOOL boo){
               // weakCell.orderCountLab.text = [NSString stringWithFormat:@"%ld",nCount];
            
        }
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        DialModel *model = arr[indexPath.row];
        _twoCell.orderDelegate = self;
        _twoCell.TanDelegate = self;
        [_twoCell showModel:model];
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
    }
    if (kScreenSize.width == 320) {
        return 134;
    }
    return 154;
    
}

-(void) getdialOrderCount:(NSDecimalNumber *)count withModel:(DialModel *)model {
    [self hilldeAll];
    
    model.orderCount = count;
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:model];
    NSInteger dataindex = [model.keyOneStr integerValue];
    NSString *titleStr = self.datas[dataindex];
    if ([self.dataArray containsObject:titleStr]) {
        NSInteger indexOne =  [self.dataArray indexOfObject:titleStr];
        NSMutableArray *arrone = [NSMutableArray array];
        arrone = [self.dataDict valueForKey:[NSString stringWithFormat:@"%ld",indexOne]];
        NSMutableArray *arr = [NSMutableArray new];
        for (DialModel *oneModel in arrone) {
            [arr addObject:oneModel.k1dt001];
        }
        if ([arr containsObject:model.k1dt001]) {
            NSInteger indexTree = [arr indexOfObject:model.k1dt001];
            [[self.dataDict valueForKey:[NSString stringWithFormat:@"%ld",indexOne]] replaceObjectAtIndex:indexTree withObject:model];
        }else {
            [arrone addObject:model];
            [self.dataDict setObject:arrone forKey:[NSString stringWithFormat:@"%ld",indexOne]];
        }
        
    }else {
        [self.dataArray addObject:titleStr];
        NSMutableArray *arrTwo = [NSMutableArray array];
        [arrTwo addObject:model];
        NSInteger count = self.dataArray.count-1;
        [self.dataDict setObject:arrTwo forKey:[NSString stringWithFormat:@"%ld",count]];
        
    }
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            DialModel *model = arrTwo[j];
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
    for (DialModel *oneModel in postArr) {
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
        DialModel *modelTwo = postArr[i];
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
-(void)scrapwithModel:(DialModel *)model{
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
    
    orderView.dialModel = model;
    orderView.typeStr = @"3010";
    orderView.dialDelegate = self;
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];
    
    
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
            DialModel *model = arrTwo[j];
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
