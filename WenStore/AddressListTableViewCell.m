//
//  AddressListTableViewCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddressListTableViewCell.h"
#import "BGControl.h"

@implementation AddressListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(NSString *)addressStr; {
//    CGSize titleSize = [@"王宇" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
//    self.nameLab.frame = CGRectMake(15, 15, titleSize.width+5, 20);
//    self.mobileLab.frame = CGRectMake(40+titleSize.width, 15, self.contentView.frame.size.width -40-titleSize.width, 20);
    //    self.titleLab.backgroundColor = [UIColor yellowColor];

    self.detailLab.text = addressStr;
    //    CGSize detailSize = [self.detailLab.text sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(kScreenSize.width-30, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    self.detailLab = [BGControl setLabelSpace:self.detailLab withValue:self.detailLab.text withFont:[UIFont systemFontOfSize:15]];
    CGFloat height = [BGControl getSpaceLabelHeight:self.detailLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    self.detailLab.frame = CGRectMake(15, 15, self.contentView.frame.size.width-30, height);
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
