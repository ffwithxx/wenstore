//
//  ScrapOnePageCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ScrapOnePageCell.h"
#import "BGControl.h"

@implementation ScrapOnePageCell{
    PurchaseOnePageModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    //301删除 302编辑  303提交  304全部
    if (_ScrapDelegate &&[_ScrapDelegate respondsToSelector:@selector(postoneStr:twoStr:withModel:)]) {
        [_ScrapDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:@"2"withModel:oneModel];
    }
}
-(void)showModel:(PurchaseOnePageModel *)model {
    oneModel = model;
   self.tuiDate.text = [BGControl dateToDateString:model.k1mf003];
    self.orderNumLab.text = model.k1mf100;
    NSInteger lpdt036 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt036"] ] integerValue];
    self.orderCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"报废",[BGControl notRounding:model.k1mf303 afterPoint:lpdt036],@"件商品"];
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.orderCountLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.orderCountLab.frame;
    sumFrame.size.width = sumWidth;
    self.sumPriceLab.frame = CGRectMake(15 + sumWidth , 0, self.contentView.frame.size.width-30-sumWidth, 50);
    self.orderCountLab.frame = CGRectMake(15, 0, sumWidth, 50);
   
    NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt043"] ] integerValue];;
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    //    self.sumLab.frame = CGRectMake(0, 0, sumWidth, 50);
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.sumPriceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.sumPriceLab.attributedText = priceStr;
    
    self.typeLab.text = model.billStateName;
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
        
        if (model.isDisplayDeleteButton) {
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
    self.subMitBth.layer.cornerRadius = 15.f;
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.subMitBth.layer.borderWidth = 1.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    
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
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
