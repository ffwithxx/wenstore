//
//  changePrice.m
//  WenStore
//
//  Created by 冯丽 on 2017/12/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "changePrice.h"
#import "BGControl.h"

@implementation changePrice

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(UIButton *)sender {
    if ([BGControl isNULLOfString:self.orderFile.text] || [self.orderFile.text isEqualToString:@"0"]) {
        return;
    }
    
    NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
    if (_changeDelegate &&[_changeDelegate respondsToSelector:@selector(changePriceModel:withPrice:)]) {
        if ( [self.type isEqualToString:@"1"]) {
             [_changeDelegate changePriceModel:_Model withPrice:numCount];
        }else    if ( [self.type isEqualToString:@"2"]) {
            [_changeDelegate changePriceModel:_PSModel withPrice:numCount];
        }else{
            [_changeDelegate changePriceModel:_PurchModel withPrice:numCount];
        }
       
    }
}

@end
