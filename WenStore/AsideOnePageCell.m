//
//  AsideOnePageCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AsideOnePageCell.h"
#import "BGControl.h"

@implementation AsideOnePageCell{
    AsideOnePageModel *oneModel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(postoneStr:withModel:)]) {
        [_orderDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] withModel:oneModel ];
    }

}
-(void)showModel:(AsideOnePageModel *)model {
    oneModel = model;
    CGFloat oneWidth = self.DeletBth.frame.size.width;
    self.dateLab.text = [BGControl dateToDateString:model.k1mf003];
    self.typeLab.text = model.billStateName;
   
   
    NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt043"] ] integerValue];
    self.storeNameLab.text = model.k1mf011;
    self.RemarkLab.text = model.k1mf010;
    self.orderNumLab.text = model.k1mf100;
    self.SumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",model.k1mf303,@"件商品"];
    
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.SumCountLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.SumCountLab.frame;
    sumFrame.size.width = sumWidth;
    [self.SumCountLab setFrame:sumFrame];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.SumPriceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    CGRect priceFrame = self.SumPriceLab.frame;
    priceFrame.size.width =self.contentView.frame.size.width -sumWidth-30;
    self.SumPriceLab.frame = CGRectMake(sumWidth +15, 0, priceFrame.size.width, 50);
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.SumPriceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.SumPriceLab.attributedText = priceStr;
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
         self.bottomView.hidden = NO;
        CGFloat oneWidth = self.SubMitBth.frame.size.width;
        CGFloat margin = CGRectGetMinX(self.SubMitBth.frame) -CGRectGetMaxX(self.bianjiBth.frame);
        if (model.isDisplayCommitButton) {
            self.SubMitBth.hidden = NO;
        }else {
            self.SubMitBth.hidden = YES;
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
            self.DeletBth.hidden = NO;
        }else{
            self.DeletBth.hidden = YES;
            
        }
    }else{
        self.bottomView.hidden = YES;
    }

    
    self.DeletBth.layer.cornerRadius = 15.f;
    self.DeletBth.layer.borderWidth = 1.f;
    self.DeletBth.layer.borderColor = kTabBarColor.CGColor;
    self.SubMitBth.layer.cornerRadius = 15.f;
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.SubMitBth.layer.borderWidth = 1.f;
    self.SubMitBth.layer.borderColor = kTabBarColor.CGColor;
    
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
        self.SumPriceLab.hidden = YES;
    }else{
        self.SumPriceLab.hidden = NO;
    }
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
