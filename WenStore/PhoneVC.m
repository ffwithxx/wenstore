//
//  PhoneVC.m
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PhoneVC.h"
#import "PhoneTableViewCell.h"
#import "BGControl.h"
#import "AppDelegate.h"
#define  KCellName @"PhoneTableViewCell"

@interface PhoneVC ()<UITableViewDelegate,UITableViewDataSource> {
    PhoneTableViewCell *_cell;
}


@end

@implementation PhoneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    self.dataArray = [NSMutableArray new];
    self.dataArray = self.arr;
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)isIphoneX {
    if (kiPhoneX) {
        
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftImg.frame = CGRectMake(15, 51, 22, 19);

        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:KCellName];
    if (!_cell) {
        _cell = [[PhoneTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    NSString *nameStr = self.dataArray[indexPath.section];
    [_cell showModel:nameStr];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
    
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
    NSString *nameStr = self.dataArray[indexPath.section];
    if (_delegate &&[_delegate respondsToSelector:@selector(PhoneStr:)]) {
        [_delegate PhoneStr:nameStr];
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
