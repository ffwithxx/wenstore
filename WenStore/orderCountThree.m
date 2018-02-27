//
//  orderCountThree.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/25.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "orderCountThree.h"
#import "BGControl.h"

@implementation orderCountThree

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
    if ([self.typeStr isEqualToString:@"3022"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_procurementDelegate && [_procurementDelegate respondsToSelector:@selector(procurementWithModel:withTag:withCount:)]) {
            [_procurementDelegate procurementWithModel:_procurementModel withTag:[_tagStr intValue] withCount:numCount];
        }

    }else if ([self.typeStr isEqualToString:@"3004"]) {
    NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_purchaseDelegate && [_purchaseDelegate respondsToSelector:@selector(procurementWithModel:withTag:withCount:)]) {
            [_purchaseDelegate procurementWithModel:_PurchaseModel withTag:[_tagStr intValue] withCount:numCount];
        }

    }else if ([self.typeStr isEqualToString:@"3002"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_scrapDelegate && [_scrapDelegate respondsToSelector:@selector(getOrderCount:withModel:)]) {
            [_scrapDelegate getOrderCount:numCount withModel:_AddScrapModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3003"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_stockDelegate && [_stockDelegate respondsToSelector:@selector(stockWithModel:withTag:with:)]) {
            [_stockDelegate stockWithModel:_StocktaModel withTag:[_tagStr intValue] with:numCount];
        }
        
    }else if ([self.typeStr isEqualToString:@"3023"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_psOnedelegate && [_psOnedelegate respondsToSelector:@selector(pstWithModel:withTag:withCount:)]) {
            [_psOnedelegate pstWithModel:_addPSModel withTag:[_tagStr intValue] withCount:numCount];
        }
        
    }else if ([self.typeStr isEqualToString:@"3005"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_asideDelegate && [_asideDelegate respondsToSelector:@selector(getOrderCount:withModel:)]) {
            [_asideDelegate getOrderCount:numCount withModel:_asideModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3010"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_dialDelegate && [_dialDelegate respondsToSelector:@selector(getdialOrderCount:withModel:)]) {
            [_dialDelegate getdialOrderCount:numCount withModel:_dialModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3007"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_producedDelegate && [_producedDelegate respondsToSelector:@selector(getproducedOrderCount:withModel:)]) {
            [_producedDelegate getproducedOrderCount:numCount withModel:_producedModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3018"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_tryEatDelegate && [_tryEatDelegate respondsToSelector:@selector(getTryEatOrderCount:withModel:)]) {
            [_tryEatDelegate getTryEatOrderCount:numCount withModel:_tryEatModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3019"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_giveAwayCountDelegate && [_giveAwayCountDelegate respondsToSelector:@selector(getGiveAwayOrderCount:withModel:)]) {
            [_giveAwayCountDelegate getGiveAwayOrderCount:numCount withModel:_giveAwayModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3013"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_recipientsCountDelegate && [_recipientsCountDelegate respondsToSelector:@selector(getRecipientsOrderCount:withModel:)]) {
            [_recipientsCountDelegate getRecipientsOrderCount:numCount withModel:_recipientsModel];
        }
        
    }else if ([self.typeStr isEqualToString:@"3011"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_oneBackDelegate && [_oneBackDelegate respondsToSelector:@selector(backWithModel:withTag:withCount:)]) {
            [_oneBackDelegate backWithModel:_editModel withTag:[_tagStr intValue] withCount:numCount];
        }
        
    }else if ([self.typeStr isEqualToString:@"3008"]) {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
        if (_threeDelegate && [_threeDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:)]) {
            [_threeDelegate getOrderCount:numCount withKey:_editModel.keyStr withIndex:_editModel.index withPrice:[NSDecimalNumber decimalNumberWithString:@"0"]];
        }
        
    }




    
    
    
}

@end
