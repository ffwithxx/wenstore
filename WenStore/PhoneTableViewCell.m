//
//  PhoneTableViewCell.m
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PhoneTableViewCell.h"

@implementation PhoneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(NSString *)str {
    self.phoneLab.text = str;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
