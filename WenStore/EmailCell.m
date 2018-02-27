//
//  EmailCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "EmailCell.h"

@implementation EmailCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWithDic:(NSDictionary *)dic {
    self.detailLab.text = [dic valueForKey:@"mail"];
    NSString *xianShi = [dic valueForKey:@"xianshi"];
    if ([xianShi isEqualToString:@"1"]) {
        self.detailLab.textColor = kBlackTextColor;
    }else {
        self.detailLab.textColor = kTabBarColor;
    }
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
