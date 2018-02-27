//
//  GiveAwayVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "GiveAwayVC.h"
#import "GiveAwayCell.h"
#import "GiveAwayModel.h"
#import "SearchVC.h"
#import "BGControl.h"
#define kCellName @"GiveAwayCell"
@interface GiveAwayVC ()<UITableViewDelegate,UITableViewDataSource,fanDataDelegate>{
    NSInteger lpdt036;
    NSMutableArray *postArr;//点单数组
    NSMutableArray *postOneArr;//回传数组
    NSString *rightorXia;
    NSMutableDictionary *dataDict;//整个数据
    NSMutableDictionary *rightDict;//右面tableView数组
    BOOL istrue;
    BOOL isSerch;
    NSString *billstate;
    
}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;




@end

@implementation GiveAwayVC

- (void)viewDidLoad {
    [super viewDidLoad];
    isSerch = NO;
    istrue = false;
    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray new];
    NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3019lpdt036"] ] integerValue];

    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
    billstate = [NSString stringWithFormat:@"%@",[[self.dataDict valueForKey:@"master"] valueForKey:@"billState"]];
    NSArray *dataArr = [self.dataDict valueForKey:@"groupDetail"];
    
    for (int i = 0; i<dataArr.count; i++) {
        NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
        if ([BGControl isNULLOfString:titleStr]) {
            titleStr = @"default";
        }
        [self.datas addObject:titleStr];
        NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
        NSMutableArray *arr =[NSMutableArray array];
        for (int j = 0; j<dictDetail.count; j++) {
            GiveAwayModel *model  = [GiveAwayModel new];
            NSDictionary *dictOne = dictDetail[j];
            model.xianStr = @"1";
            
            [model setValuesForKeysWithDictionary:dictOne];
            
            [arr addObject:model];
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
    
}
-(void)fanDict:(NSMutableDictionary *)dict
{
    self.searchBth.enabled = NO;
    self.searchImg.hidden = YES;
    isSerch = true;
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            GiveAwayModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                ;
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

#pragma mark - private
- (void)setBaseTableView {
    // leftTableView
    
    
    // rightTableView
    self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 60, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 60);
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
        
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",section]];
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
        // 通过不同标识创建cell实例
        GiveAwayCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:kCellName];
        if (!_twoCell) {
            _twoCell = [[GiveAwayCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
        }
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width - 100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        GiveAwayModel *model = arr[indexPath.row];
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
            return 125;
        }else {
            return 145;
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



- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        if (isSerch == true) {
            self.searchBth.enabled = YES;
            self.searchImg.hidden = NO;
            isSerch = NO;
            dataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    GiveAwayModel *model = arrTwo[j];
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
    }else if (sender.tag == 202) {
        
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
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
