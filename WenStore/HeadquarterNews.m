//
//  HeadquarterNews.m
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "HeadquarterNews.h"
#import "HeadquarterNewsCell.h"
#import "BGControl.h"
#import "AFClient.h"
#import <MJRefresh/MJRefresh.h>
#import "MJRefreshComponent.h"
#define kCellName @"HeadquarterNewsCell"

@interface HeadquarterNews ()<UITableViewDelegate,UITableViewDataSource> {
    HeadquarterNewsCell *_cell;
     int pageIndex;
}

@end

@implementation HeadquarterNews

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.dataArray = [[NSMutableArray alloc] init];
    [self first];
    // Do any additional setup after loading the view.
}

-(void)first{
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
    NSMutableDictionary *postDict = [[NSMutableDictionary alloc] init];
    NSNumber *pageNumber = [NSNumber numberWithInt:pageIndex];
    NSNumber *page = [NSNumber numberWithInt:50];
    [postDict setObject:pageNumber forKey:@"page"];
    [postDict setObject:page forKey:@"perPage"];
    [self show];
    [[AFClient shareInstance] GetNewswithUrl:@"App/Setting/GetNews" withDict:postDict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
         if ([[responseBody valueForKey:@"status"] integerValue]== 200) {
           NSArray *dataArr = [[responseBody valueForKey:@"data"] valueForKey:@"data"];
        for (int i = 0; i<dataArr.count; i++) {
            NSDictionary *dict  = dataArr[i];
            [self.dataArray addObject:dict];
        }
         }else {
             [self Alert:@"请求失败"];
             
         }
        [self.bigTableView reloadData];
        [self.bigTableView.mj_header endRefreshing];
        [self.bigTableView.mj_footer endRefreshing];
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[HeadquarterNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    NSDictionary *dict = self.dataArray[indexPath.section];
    
    [_cell showModel:dict];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGSize detailSize = [@"2017年春季新商品已经上架相关活动DM已寄出请各店注意查收哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(kScreenSize.width-30, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    NSString *string = [self.dataArray[indexPath.row] valueForKey:@"bmsg009"];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string.length)];
    CGFloat height = [BGControl getSpaceLabelHeight:string withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    
    return 55 + height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}
-
(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
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
