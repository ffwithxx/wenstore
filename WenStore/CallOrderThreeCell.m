//
//  CallOrderThreeCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeCell.h"
#import "BGControl.h"

@implementation CallOrderThreeCell{
    orderModel *oneModel ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_orderthreeDelegate && [_orderthreeDelegate respondsToSelector:@selector(postoneStr:twoStr:withModel:)]) {
        [_orderthreeDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:@"2" withModel:oneModel];
    }
    
    

    
}
- (void)layoutSubviews {
        [super layoutSubviews];
}

-(void)showModel:(orderModel *)model{
    oneModel = model;
    self.jiImg.hidden = YES;
    NSArray *peiTimeArr =[[BGControl dateToDateStringTwo:model.k1mf003] componentsSeparatedByString:@" "];
     self.peiLab.text = peiTimeArr[0];
     NSArray *jiaoTimeArr =[[BGControl dateToDateStringTwo:model.k1mf004] componentsSeparatedByString:@" "];
     self.jiaohuoLab.text = jiaoTimeArr[0];
    self.typeLab.text = model.billStateName;
    self.orderNum.text = model.k1mf100;
     NSInteger lpdt036 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
     self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已收",[BGControl notRounding:model.k1mf303 afterPoint:lpdt036],@"件商品"];
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.sumLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.sumLab.frame;
    sumFrame.size.width = sumWidth;
     self.priceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    self.sumLab.frame = CGRectMake(15, 0, sumWidth, 50);
    
    NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt043"] ] integerValue];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
  self.priceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    //    self.sumLab.frame = CGRectMake(0, 0, sumWidth, 50);
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.priceLab.attributedText = priceStr;
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
       
    }
   
    if (!isPrice) {
        self.priceLab.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
    }
    
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayCheckedButton) {
        self.bottomView.hidden = NO;
        CGFloat oneWidth = self.subMitBth.frame.size.width;
        CGFloat margin = 10;
        if (model.isDisplayCommitButton) {
            self.subMitBth.hidden = NO;
        }else {
            self.subMitBth.hidden = YES;
        }
        if (model.isDisplayEditButton) {
            self.bianjiBth.hidden = NO;
            if (!model.isDisplayCommitButton) {
                CGRect bianjiFrame = self.bianjiBth.frame;
                bianjiFrame.origin.x = kScreenSize.width - 20 - oneWidth;
                [self.bianjiBth setFrame:bianjiFrame];
            }else {
                CGRect bianjiFrame = self.bianjiBth.frame;
                bianjiFrame.origin.x = kScreenSize.width - 20 - oneWidth*2 - margin;
                [self.bianjiBth setFrame:bianjiFrame];
                
            }
        }else {
            self.bianjiBth.hidden = YES;
            
        }
        if (model.isDisplayCheckedButton) {
            self.jiheBth.hidden = NO;
            CGRect jiheFrame = self.jiheBth.frame;
            jiheFrame.origin.x = kScreenSize.width - 20 - oneWidth;
            [self.jiheBth setFrame:jiheFrame];
        }else{
            self.jiheBth.hidden = YES;
            
        }
    }else{
        self.bottomView.hidden = YES;
        
    }
    self.bianjiBth.layer.cornerRadius = 15.f;
   
    self.jiheBth.layer.cornerRadius = 15.f;
    self.jiheBth.layer.borderWidth = 1.f;
    self.jiheBth.layer.borderColor = kTabBarColor.CGColor;
    self.subMitBth.layer.cornerRadius = 15.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    self.subMitBth.layer.borderWidth = 1.f;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
