//
//  DealtTableViewCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "DealtTableViewCell.h"
#import "BGControl.h"

@implementation DealtTableViewCell {
    groupModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWith:(groupModel *)model withIndex:(NSInteger)index {
    oneModel = model;
    NSArray *arr = model.allTodos;
    self.numLab.text = [NSString stringWithFormat:@"%ld",arr.count];
     CGFloat oneNumWidth = [BGControl labelAutoCalculateRectWith:self.numLab.text FontSize:10 MaxSize:CGSizeMake(20, 20)].width;
     self.numLab.frame = CGRectMake(40, 10, oneNumWidth +4, oneNumWidth+4);
    self.numLab.clipsToBounds = YES;
    self.numLab.layer.cornerRadius = oneNumWidth/2 +2;
    self.titleLab.text = model.groupName;
    if ([model.groupName isEqualToString:@"叫货事项"]) {
        self.headImg.image = [UIImage imageNamed:@"jiaohuo"];
    }else if ([model.groupName isEqualToString:@"采购事项"]) {
        self.headImg.image = [UIImage imageNamed:@"caigou"];
    }else if ([model.groupName isEqualToString:@"调配事项"]) {
        self.headImg.image = [UIImage imageNamed:@"diaopei"];
    }else if ([model.groupName isEqualToString:@"统计事项"]) {
        self.headImg.image = [UIImage imageNamed:@"tongji"];
    }
    NSDictionary *topTodoDict = model.topTodo;
    self.dateLab.text =  [BGControl dateToDateString:[topTodoDict valueForKey:@"billDate"]];
    self.detailLab.text = [topTodoDict valueForKey:@"appMsg"];
    CGFloat twoHei = [BGControl getSpaceLabelHeight:self.detailLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 75];
    self.detailLab =  [BGControl setLabelSpace:self.detailLab withValue:self.detailLab.text withFont:[UIFont systemFontOfSize:15]];
    self.detailLab.numberOfLines = 0;
    CGFloat maxHei = 0;
    if (twoHei <42) {
        
        self.detailLab.frame = CGRectMake(60, 45,kScreenSize.width - 75, twoHei);
        self.detailBth.frame = CGRectMake(60, 45,kScreenSize.width - 75, twoHei);
        if (model.hasMoreTodo == true) {
        self.moreLab.frame = CGRectMake(60, 55+twoHei, kScreenSize.width-75, 20);
        self.MoreBth.frame = CGRectMake(60, 55+twoHei, kScreenSize.width-75, 20);
            self.moreLab.hidden = NO;
            self.MoreBth.enabled = YES;
            maxHei = 45+twoHei+10+20+15;
        }else {
            self.moreLab.hidden = YES;
            self.MoreBth.enabled = NO;
             maxHei = 45+twoHei+15;
        }
   
        self.bigView.frame = CGRectMake(0, 0, kScreenSize.width, maxHei);
    }else {
//        self.twoViewDetail.frame = CGRectMake(60, 45, CGRectGetWidth(self.view.frame) - 75, 42);
        self.detailLab.frame = CGRectMake(60, 45, kScreenSize.width - 75, 42);
        self.detailBth.frame = CGRectMake(60, 45, kScreenSize.width - 75, 42);
        if (model.hasMoreTodo == true) {
            self.moreLab.frame = CGRectMake(60, 55+42, kScreenSize.width-75, 20);
             self.MoreBth.frame = CGRectMake(60, 55+42, kScreenSize.width-75, 20);
            self.moreLab.hidden = NO;
             self.MoreBth.enabled = YES;
            maxHei = 45+42+10+20+15;
        }else {
            self.moreLab.hidden = YES;
            self.MoreBth.enabled = NO;
            maxHei = 45+42+15;
        }
        
        self.bigView.frame = CGRectMake(0, 0, kScreenSize.width, maxHei);

    }
    if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withIndex:)]) {
        [_delegate getMaxHei:maxHei  withIndex:index];
    }
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_dealtDelegate &&[_dealtDelegate respondsToSelector:@selector(postoneStr:withModel:)]) {
        [_dealtDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] withModel:oneModel];
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
