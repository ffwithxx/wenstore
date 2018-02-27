//
//  StoreNameVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StoreNameVC.h"
#import "BGControl.h"
#import "StoreNameCell.h"
#define KCellName @"StoreNameCell"

@interface StoreNameVC ()<UITableViewDelegate,UITableViewDataSource> {
    StoreNameCell *_cell;
}

@end

@implementation StoreNameVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataArray = [NSMutableArray new];
    self.dataArray = [NSMutableArray arrayWithArray:self.detpsArr];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;

}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
       // AddAddressVC *addressVC = [storyboard instantiateViewControllerWithIdentifier:@"AddAddressVC"];
        
        //[self.navigationController pushViewController:addressVC animated:YES];
        
    }

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:KCellName];
    if (!_cell) {
        _cell = [[StoreNameCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    NSDictionary *storeDict = self.dataArray[indexPath.section];
    //    XyModel *model = self.dataArray[indexPath.row];
    [_cell showModel:storeDict];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 60;
    
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
    NSDictionary *storeDict = self.dataArray[indexPath.section];
    if (_delegate &&[_delegate respondsToSelector:@selector(StoreNameDict:)]) {
        [_delegate StoreNameDict:storeDict];
    }
    [self.navigationController popViewControllerAnimated:YES];
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
