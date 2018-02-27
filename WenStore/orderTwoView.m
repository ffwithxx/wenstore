//
//  orderTwoView.m
//  WenStore
//
//  Created by 冯丽 on 17/9/11.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "orderTwoView.h"
#import "BuyModel.h"

@implementation orderTwoView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(UIButton *)sender {
    
    if ([self.typeStr isEqualToString:@"1"]) {
        NSDecimalNumber *restDec;
        NSMutableArray *promoArr = [NSMutableArray new];
        promoArr = [self.model.promDict valueForKey:@"promoArr"];
        NSDecimalNumber *orderCount;
        NSDecimalNumber *chu;
        for (int i = 0; i<promoArr.count; i++) {
            BuyModel *proModel = promoArr[i];
            if ([self.tag isEqualToString:proModel.k7mf007]) {
                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                   
                                                   decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                   
                                                   scale:0
                                                   
                                                   raiseOnExactness:NO
                                                   
                                                   raiseOnOverflow:NO
                                                   
                                                   raiseOnUnderflow:NO
                                                   
                                                   raiseOnDivideByZero:YES];
               orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.orderCount]];
                
                NSDecimalNumber *bigOrder= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.orderCount]];
                NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf005]];
                NSDecimalNumber *base =  [bigOrder decimalNumberByDividingBy:meijiao];
                NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                NSDecimalNumber *total = [base decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                
                NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf012]] decimalNumberByMultiplyingBy:total];
                NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
               chu =  [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
                NSComparisonResult result = [chu compare:zengText];
                if (result == NSOrderedDescending  ) {
                    restDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",chu]];
                }else {
                    proModel.orderCount = chu;
                    [promoArr replaceObjectAtIndex:i withObject:proModel];
                    
                }
                
            }
        }
        if ( _prooneDelegate && [_prooneDelegate respondsToSelector:@selector(getpro:withIndex:withDec:withYunCount:withNowCount:)]) {
            [_prooneDelegate getpro:promoArr withIndex:self.index withDec:restDec withYunCount:orderCount withNowCount:chu];
        }
  
    }else {
        NSDecimalNumber *restDec;
        NSMutableArray *buyArr = [NSMutableArray new];
        buyArr = [self.model.buyDict valueForKey:@"buyArr"];
        NSDecimalNumber *orderCount;
        NSDecimalNumber *chu;
        for (int i = 0; i<buyArr.count; i++) {
            BuyModel *buyModel = buyArr[i];
            if ([[NSString stringWithFormat:@"%ld",(long)self.tag] isEqualToString:buyModel.k7mf007]) {
                NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                                   
                                                   decimalNumberHandlerWithRoundingMode:NSRoundDown
                                                   
                                                   scale:0
                                                   
                                                   raiseOnExactness:NO
                                                   
                                                   raiseOnOverflow:NO
                                                   
                                                   raiseOnUnderflow:NO
                                                   
                                                   raiseOnDivideByZero:YES];
               orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.orderCount]];
                
                NSDecimalNumber *bigOrder= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",(long)self.model.orderCount]];
                NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.k7mf005]];
                NSDecimalNumber *base =  [bigOrder decimalNumberByDividingBy:meijiao];
                NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
                NSDecimalNumber *total = [base decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
                
                NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.k7mf012]] decimalNumberByMultiplyingBy:total];
                NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
                 chu =  [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
                NSComparisonResult result = [chu compare:zengText];
                if (result == NSOrderedAscending  ) {
                    restDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",zengText]];
                }else {
                    buyModel.orderCount = chu;
                    [buyArr replaceObjectAtIndex:i withObject:buyModel];
                    
                }
                
            }
        }
        if ( _PeiDelegate && [_PeiDelegate respondsToSelector:@selector(getpei:withIndex:withDec:withYunCount:withNowCount:)]) {
            [_PeiDelegate getpei:buyArr withIndex:self.index withDec:restDec withYunCount:orderCount withNowCount:chu];
        }

    }
   }

@end
