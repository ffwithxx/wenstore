//
//  Forecast.m
//  WenStore
//
//  Created by 冯丽 on 17/8/25.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "Forecast.h"
@interface Forecast ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource> {
    NSArray *numArr;
    NSString *strNum;
    
}
@end
@implementation Forecast

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


-(void) drawRect:(CGRect)rect {
    self.changeBth.layer.cornerRadius = 5.f;
    self.litterView.hidden = YES;
    self.ciView.hidden = YES;
    self.submitBth.layer.cornerRadius = 20.f;
    self.changeBth.layer.borderColor = kTabBarColor.CGColor;
    self.changeBth.layer.borderWidth = 1.f;
    self.ciButton.layer.cornerRadius = 5.f;
     self.ciButton.layer.borderWidth = 1.f;
    self.beginBth.layer.borderColor = kTabBarColor.CGColor;
    self.beginBth.layer.borderWidth = 1.f;
    self.beginBth.layer.cornerRadius = 5.f;
    
    self.endBth.layer.borderColor = kTabBarColor.CGColor;
    self.endBth.layer.borderWidth = 1.f;
    self.endBth.layer.cornerRadius = 5.f;
    numArr = @[@"1",@"2",@"3",@"4",@""];
        self.ciPicker.delegate = self;
    self.ciPicker.hidden = YES;
    CGRect ciFrame = self.ciView.frame;
    ciFrame.size.height = 50;
    self.dateBigView.hidden = YES;
    [self.ciView setFrame:ciFrame];
    self.ciPicker.delegate = self;
    self.ciPicker.dataSource = self;
    self.ciPicker.showsVerticalScrollIndicator = NO;
 
    self.ciPicker.separatorStyle = UITableViewCellSelectionStyleNone;
   
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(postForecastStr:)]) {
        [_delegate postForecastStr:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cellId";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
    
    cell.textLabel.text = numArr[indexPath.section];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = kTextGrayColor;
    cell.textLabel.highlightedTextColor = kTabBarColor;
    cell.textLabel.font = [UIFont systemFontOfSize:15];
    cell.textLabel.backgroundColor = [UIColor clearColor];
    cell.backgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.backgroundView.backgroundColor = [UIColor whiteColor];
    cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
    cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
    
    cell.textLabel.numberOfLines = 0;
    return cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
        return 35;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
      self.ciFile.text = numArr[indexPath.section];
    self.ciPicker.hidden = YES;
    self.ciView.layer.borderColor = [UIColor clearColor].CGColor;
    self.ciButton.layer.borderColor = kTabBarColor.CGColor;
    CGRect frame = self.frame;
    frame.size.height = 270;
    [self setFrame:frame];
    CGRect ciFrame = self.ciView.frame;
    ciFrame.size.height = 50;
    self.ciPicker.hidden = YES;
    [self.ciView setFrame:ciFrame];
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return numArr.count;
    
}



@end
