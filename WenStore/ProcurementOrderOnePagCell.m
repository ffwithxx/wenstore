//
//  ProcurementOrderOnePagCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProcurementOrderOnePagCell.h"
#import "BGControl.h"

@implementation ProcurementOrderOnePagCell {
ProcurementOrderOnePagModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(ProcurementOrderOnePagModel *)model withDict:(NSMutableDictionary *)dict{
    oneModel = model;
    CGFloat oneWidth = self.deletBth.frame.size.width;
    CGFloat margin = CGRectGetMinX(self.subMitBth.frame) -CGRectGetMaxX(self.bianjiBth.frame);
    
    self.caigouDate.text = [BGControl dateToDateString:model.k1mf003];
    self.yujiaoDate.text = [BGControl dateToDateString:model.k1mf004];
    self.typeLab.text = model.billStateName;
    
    //    if ([model.billStateName isEqualToString:@"新单据"]) {
    //         self.otherLab.textColor = kTabBarColor;
    //          self.deletBth.hidden = NO;
    //          self.timeLab.hidden = YES;
    //          [self.subMitBth setTitle:@"提交" forState:UIControlStateNormal];
    //    }else {
    //
    //        self.otherLab.textColor = kTextGrayColor;
    //        self.deletBth.hidden = YES;
    //        self.timeLab.hidden = NO;
    //        [self.subMitBth setTitle:@"支付" forState:UIControlStateNormal];
    //    }

    NSInteger lpdt043 =  [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt043"] ] integerValue];
    self.nameLab.text = model.k1mf101;
    self.remarkLab.text = model.k1mf010;
    self.orderIdLab.text = model.k1mf100;
    self.orderNum.text = [NSString stringWithFormat:@"%@%@%@",@"已购",model.k1mf303,@"件商品"];
    
    
    
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.orderNum.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.orderNum.frame;
    sumFrame.size.width = sumWidth;
    [self.orderNum setFrame:sumFrame];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    CGRect priceFrame = self.sumLab.frame;
    priceFrame.size.width =self.contentView.frame.size.width -sumWidth-30;
    self.sumLab.frame = CGRectMake(sumWidth +15, 0, priceFrame.size.width, 50);
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.sumLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.sumLab.attributedText = priceStr;
    

      self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.subMitBth.layer.borderWidth = 1.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    self.subMitBth.layer.cornerRadius = 15.f;
    //    self.deletBth.hidden = YES;
    self.lastView.hidden = NO;
    if (model.billState == 0) {
         self.lastView.hidden = NO;
        self.deletBth.hidden = NO;
        self.bianjiBth.hidden = NO;
        self.subMitBth.hidden = NO;
        [self.subMitBth setTitle:@"提交" forState:UIControlStateNormal];
        [self.deletBth setTitle:@"删除" forState:UIControlStateNormal];
        [self.bianjiBth setTitle:@"编辑" forState:UIControlStateNormal];
    }else if (model.billState == 10) {
         self.lastView.hidden = NO;
        [self.deletBth setTitle:@"发送邮件" forState:UIControlStateNormal];
        [self.bianjiBth setTitle:@"编辑" forState:UIControlStateNormal];
        [self.subMitBth setTitle:@"转出" forState:UIControlStateNormal];
        self.deletBth.hidden = NO;
        self.bianjiBth.hidden = NO;
        self.subMitBth.hidden = NO;
    }else if (model.billState == 30 || model.billState == 40) {
        self.lastView.hidden = NO;
        [self.deletBth setTitle:@"发送邮件" forState:UIControlStateNormal];
        [self.bianjiBth setTitle:@"转出" forState:UIControlStateNormal];
        [self.subMitBth setTitle:@"结案" forState:UIControlStateNormal];
        self.deletBth.hidden = NO;
        self.bianjiBth.hidden = NO;
        self.subMitBth.hidden = NO;
    }else if (model.billState ==50) {
        self.lastView.hidden = NO;
        self.deletBth.hidden = YES;
        self.bianjiBth.hidden = NO;
        self.subMitBth.hidden = NO;
        [self.bianjiBth setTitle:@"转出" forState:UIControlStateNormal];
        [self.subMitBth setTitle:@"结案" forState:UIControlStateNormal];
    }
    else{
        self.lastView.hidden = YES;
       
    }
    
    
    
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(postoneStr:twoStr:withCount:withModel:)]) {
        [_orderDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:oneModel.k1mf100 withCount:oneModel.k1mf303 withModel:oneModel ];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
