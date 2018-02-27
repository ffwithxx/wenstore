//
//  PurchaseOnePageCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PurchaseOnePageCell.h"
#import "BGControl.h"

@implementation PurchaseOnePageCell{
    PurchaseOnePageModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(PurchaseOnePageModel *)model {
    oneModel = model;
    self.jinhuoDate.text = [BGControl dateToDateString:model.k1mf003];
    self.nameLab.text = model.k1mf101;
    self.orderNumLab.text = model.k1mf100;
    if ([BGControl isNULLOfString:model.k1mf010]) {
        self.remarkView.hidden = YES;
        self.lineImg.hidden = NO;
        self.bottomView.frame = CGRectMake(0, 165, kScreenSize.width, 50);
         self.lastView.frame = CGRectMake(0, 215, kScreenSize.width, 50);
    }else {
        self.remarkView.hidden = NO;
        self.lineImg.hidden = YES;
      
        self.remarkLab.text = model.k1mf010;
        self.remarkLab = [BGControl setLabelSpace:self.remarkLab withValue:self.remarkLab.text withFont:[UIFont systemFontOfSize:15]];
        CGFloat height = [BGControl getSpaceLabelHeight:self.remarkLab.text withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 110];
        CGFloat hei;
        if (height<50) {
            hei= 50;
        }else{
            hei = height;
        }
        self.remarkLab.frame = CGRectMake(95, 0, self.contentView.frame.size.width-110, hei);
        self.remarkNameLab.frame = CGRectMake(15, 0, 65, hei);
        self.remarkView.frame = CGRectMake(0, 165, kScreenSize.width, hei);
    
        self.remarkLab.numberOfLines = 0;
        self.bottomView.frame = CGRectMake(0, 165+hei, kScreenSize.width, 50);
         self.lastView.frame = CGRectMake(0, 215+hei, kScreenSize.width, 50);
    }
    NSInteger lpdt036 = [[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] integerValue];
    self.orderCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已进货",[BGControl notRounding:model.k1mf303 afterPoint:lpdt036],@"件商品"];
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.orderCountLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.orderCountLab.frame;
    sumFrame.size.width = sumWidth;
    self.sumPriceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    self.orderCountLab.frame = CGRectMake(15, 0, sumWidth, 50);
   
    NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt043"] ] integerValue];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    //    self.sumLab.frame = CGRectMake(0, 0, sumWidth, 50);
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.sumPriceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.sumPriceLab.attributedText = priceStr;

    self.billSateLab.text = model.billStateName;
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
        self.lastView.hidden = NO;
        CGFloat oneWidth = self.subMitBth.frame.size.width;
        CGFloat margin = CGRectGetMinX(self.subMitBth.frame) -CGRectGetMaxX(self.bianjiBth.frame);
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
            self.deletBth.hidden = NO;
        }else{
            self.deletBth.hidden = YES;
            
        }
    }else{
        self.lastView.hidden = YES;
    }
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.subMitBth.layer.borderWidth = 1.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.subMitBth.layer.cornerRadius = 15.f;
    
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
        self.sumPriceLab.hidden = YES;
    }else{
        self.sumPriceLab.hidden = NO;
    }
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    //301删除 302编辑  303提交  304订单
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(postoneStr:withModel:)]) {
        [_orderDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] withModel:oneModel ];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
