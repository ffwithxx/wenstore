//
//  AddressListVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddressListVC.h"
#import "AddressListTableViewCell.h"
#import "BGControl.h"
#import "AddAddressVC.h"
#import "AppDelegate.h"
#define KCellName @"AddressListTableViewCell"
@interface AddressListVC ()<UITableViewDelegate,UITableViewDataSource> {
    AddressListTableViewCell *_cell;
}

@end

@implementation AddressListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    self.dataArray = self.arr;
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // Do any additional setup after loading the view.
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        AddAddressVC *addressVC = [storyboard instantiateViewControllerWithIdentifier:@"AddAddressVC"];
        
        [self.navigationController pushViewController:addressVC animated:YES];

    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:KCellName];
    if (!_cell) {
        _cell = [[AddressListTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    NSString *address = self.dataArray[indexPath.section];
    //    XyModel *model = self.dataArray[indexPath.row];
    [_cell showModel:address];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        NSString *address = self.dataArray[indexPath.section];
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:address];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,address.length)];
    CGFloat height = [BGControl getSpaceLabelHeight:address withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    
    return 30 + height;
    
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
        NSString *address = self.dataArray[indexPath.section];
    if (_delegate &&[_delegate respondsToSelector:@selector(AddressStr:)]) {
        [_delegate AddressStr:address];
    }
    [self.navigationController popViewControllerAnimated:YES];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
//- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath { // 添加一个删除按钮
//    UITableViewRowAction *deleteRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:Localized(@"删除")handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//        [self Alert:@"删除"];
//    }];
//    deleteRowAction.backgroundColor = kTabBarColor;
//    
//    // 删除一个置顶按钮
//    UITableViewRowAction *topRowAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:Localized(@"编辑")handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
//    
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        AddAddressVC *addressVC = [storyboard instantiateViewControllerWithIdentifier:@"AddAddressVC"];
//        addressVC.nameStr = [NSString stringWithFormat:@"%@",@"王宇"];
//        addressVC.mobileStr = [NSString stringWithFormat:@"%@",@"15656565656"];
//        addressVC.textViewStr = [NSString stringWithFormat:@"%@",@"上海市嘉定区江桥万达"];
//        
//        [self.navigationController pushViewController:addressVC animated:YES];
//    
//    }];
//    
//    topRowAction.backgroundColor = kTextGrayColor;
//      return @[deleteRowAction, topRowAction];
//}
    
   
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
