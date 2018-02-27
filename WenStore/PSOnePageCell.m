//
//  PSOnePageCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PSOnePageCell.h"
#import "BGControl.h"

@implementation PSOnePageCell {
    PSOnePageModel *oneModel;
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
-(void)showModel:(PSOnePageModel *)model {
    oneModel = model;
    CGFloat oneWidth = self.deletBth.frame.size.width;
    
   
    NSString *dateString = [BGControl dateWithString:[NSString stringWithFormat:@"%@",model.k1mf003]];
    if ([BGControl isNULLOfString:dateString]) {
        dateString = [BGControl dateToDateString:model.k1mf003];
    }


    
    
    
    
    self.dateLab.text = dateString;
    self.typeLab.text = model.billStateName;
   

    NSInteger lpdt043 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3023lpdt043"] ] integerValue];
    self.nameLab.text = model.k1mf101;
    self.remarkLab.text = model.k1mf010;
    self.idStrLab.text = model.k1mf100;
    self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已进货",model.k1mf303,@"件商品"];
    
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.sumCountLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.sumCountLab.frame;
    sumFrame.size.width = sumWidth;
    [self.sumCountLab setFrame:sumFrame];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    CGRect priceFrame = self.sumPriceLab.frame;
    priceFrame.size.width =self.contentView.frame.size.width -sumWidth-30;
    self.sumPriceLab.frame = CGRectMake(sumWidth +15, 0, priceFrame.size.width, 50);
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.sumPriceLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
    self.sumPriceLab.attributedText = priceStr;
    
    
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.subMitBth.layer.borderWidth = 1.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    
      self.subMitBth.layer.cornerRadius = 15.f;
   if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
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
       
       if (model.isDisplayDeleteButton) {
           self.deletBth.hidden = NO;
       }else{
           self.deletBth.hidden = YES;
           
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
