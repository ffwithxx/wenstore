//
//  StoreNameCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StoreNameCell.h"

@implementation StoreNameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(NSDictionary *)dict {
    self.storeNameLab.text = [dict valueForKey:@"text"];
    self.numLab.text = [dict valueForKey:@"value"];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
