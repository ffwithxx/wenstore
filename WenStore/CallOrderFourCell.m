//
//  CallOrderFourCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderFourCell.h"
#import "BGControl.h"

@implementation CallOrderFourCell {
    orderModel *oneModel ;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_orderFourDelegate &&[_orderFourDelegate respondsToSelector:@selector(postoneStr:twoStr:withModel:)]) {
        [_orderFourDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:@"2"withModel:oneModel];
    }
    

}
-(void)showModel:(orderModel *)model{
    oneModel = model;
     self.typeLab.text = model.billStateName;
    self.tuihuiDate.text = [BGControl dateToDateString:model.k1mf003];
    self.orderNumLab.text = model.k1mf100;
   NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt043"] ] integerValue];
   NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt036"] ] integerValue];

     self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已退",[BGControl notRounding:model.k1mf303 afterPoint:lpdt036],@"件商品"];
    CGRect sumFrame = self.sumLab.frame;
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.sumLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    sumFrame.size.width = sumWidth;
    self.priceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    self.sumLab.frame = CGRectMake(15, 0, sumWidth, 50);
    self.priceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    self.sumLab.frame = CGRectMake(15, 0, sumWidth, 50);
    self.priceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];

    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.priceLab.attributedText = priceStr;

    self.bianjiBth.layer.cornerRadius = 15.f;
    
    self.hedingBth.layer.cornerRadius = 15.f;
   
    self.submitBth.layer.cornerRadius = 15.f;
    self.submitBth.layer.borderWidth = 1.f;
    self.submitBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    
    if (model.isDisplayCommitButton || model.isDisplayEditButton || model.isDisplayConfirmedButton || model.isDisplayDeleteButton) {
        self.bottomView.hidden = NO;
        CGFloat oneWidth = self.submitBth.frame.size.width;
        CGFloat margin = 10;
        if (model.isDisplayCommitButton) {
            self.submitBth.hidden = NO;
        }else {
            self.submitBth.hidden = YES;
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
        if (model.isDisplayDeleteButton) {
            self.hedingBth.hidden = YES;
            self.deletBth.hidden = NO;
            
        }else{
            self.deletBth.hidden = YES;
        }
        if (model.isDisplayConfirmedButton) {
            self.hedingBth.hidden = NO;
            self.deletBth.hidden = YES;
            CGRect jiheFrame = self.hedingBth.frame;
            jiheFrame.origin.x = kScreenSize.width - 20 - oneWidth;
            [self.hedingBth setFrame:jiheFrame];
        }else{
            self.hedingBth.hidden = YES;
            
        }
    }else{
        self.bottomView.hidden = YES;
        
    }
    
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
    
}
@end
