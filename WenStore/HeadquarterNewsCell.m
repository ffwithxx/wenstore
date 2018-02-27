//
//  HeadquarterNewsCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "HeadquarterNewsCell.h"
#import "BGControl.h"

@implementation HeadquarterNewsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)layoutSubviews {
    self.readView.clipsToBounds = YES;
    self.readView.layer.cornerRadius = 3.f;
    [super layoutSubviews];
     self.detailLab.numberOfLines = 0;
//    self.contentView.backgroundColor = kTabBarColor;
}
- (void)drawRect:(CGRect)rect {
//    self.readView.clipsToBounds = YES;
//    self.readView.layer.cornerRadius = 3.f;
    
}

- (void)showModel:(NSDictionary *)dict{
    self.titleLab.text = [dict valueForKey:@"bmsg008"];
    CGSize titleSize = [self.titleLab.text sizeWithFont:[UIFont systemFontOfSize:17] constrainedToSize:CGSizeMake(MAXFLOAT, 20)];
    self.titleLab.frame = CGRectMake(30, 15, titleSize.width+5, 20);
    self.timeLab.frame = CGRectMake(titleSize.width+35, 15, self.contentView.frame.size.width -50-titleSize.width, 20);
    self.timeLab.text =[BGControl dateToDateString:[dict valueForKey:@"bmsg005"]];
    self.detailLab.text = [dict valueForKey:@"bmsg009"];
    self.detailLab = [BGControl setLabelSpace:self.detailLab withValue:self.detailLab.text withFont:[UIFont systemFontOfSize:15]];
    CGFloat height = [BGControl getSpaceLabelHeight:self.detailLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    self.detailLab.frame = CGRectMake(15, 45, self.contentView.frame.size.width-30, height);

   
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
