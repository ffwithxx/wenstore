//
//  ProcurementVC.m
//  WenStore
//
//  Created by 冯丽 on 17/10/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProcurementVC.h"
#import "ProcurementCell.h"
#import "BGControl.h"
#import "ProcurementOrderVC.h"
#define kCellName @"ProcurementCell"

@interface ProcurementVC ()<UITableViewDelegate,UITableViewDataSource> {
    ProcurementCell *_cell;
}

@end

@implementation ProcurementVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ProcurementCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    //    XyModel *model = self.dataArray[indexPath.row];
    [_cell showModel];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    //    CGSize detailSize = [@"2017年春季新商品已经上架相关活动DM已寄出请各店注意查收哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(kScreenSize.width-30, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
//    NSString *string = @"2017年春季新商品已经上架相关活动DM已寄出请各店注意查收哈哈哈哈哈哈哈";
//    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:string];
//    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
//    [paragraphStyle setLineSpacing:4];
//    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string.length)];
//    CGFloat height = [BGControl getSpaceLabelHeight:string withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
//    
    return 70;
    
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
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  
        ProcurementOrderVC *callOrder = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
        [self.navigationController pushViewController:callOrder animated:YES];

    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 10;
    
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
