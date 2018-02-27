//
//  orderCountView.m
//  WenStore
//
//  Created by 冯丽 on 17/9/11.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "orderCountView.h"
#import "BGControl.h"

@implementation orderCountView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
-(void) drawRect:(CGRect)rect {
    self.bigView.layer.cornerRadius = 5.f;
    self.bigView.clipsToBounds = YES;
    self.bigView.layer.borderColor = kLineColor.CGColor;
    self.bigView.layer.borderWidth = 1.f;
    self.subMitBth.layer.cornerRadius = 5.f;
}
- (IBAction)buttonClick:(UIButton *)sender {
   NSInteger lpdt036 =  [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    NSString *desStr;
    if (![self.typeStr isEqualToString:@"order"]) {
        
   
    NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSString *fileText = self.orderFile.text;
    orderCount = [NSDecimalNumber decimalNumberWithString:fileText];
    NSArray *arr = [self.dict valueForKey:@"pricConfigs"];
    NSDecimalNumber *price;
    NSMutableArray *murableArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        [murableArr addObject:[dict valueForKey:@"k1dt001"]];
    }
    
    if ([murableArr containsObject:self.model.k1dt001]) {
        NSInteger indexStr = [murableArr indexOfObject:self.model.k1dt001];
        NSArray *arrone = [arr[indexStr] valueForKey:@"prics"];
        for (int i = 0; i<arrone.count; i++) {
            NSDecimalNumber *str = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]]];
             NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",orderCount]] compare:str];
            if (i == 0) {
                if (result == NSOrderedAscending) {
                    price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.originalK1dt201]];
                }
            }
            if (result == NSOrderedDescending ||result == NSOrderedSame) {
                price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric003"]]];
            }
            
        }
        
    }else {
        price = self.model.originaltest;
    }
         if ( ![BGControl isNULLOfString:self.orderFile.text]) {
             NSDecimalNumber *fanDec = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
            
             NSString *minStr = [NSString stringWithFormat:@"%@",_model.minQuality];
             int minNum =  [minStr intValue];
             NSString *beiStr = [NSString stringWithFormat:@"%@",_model.multipleBase];
             int beiNum =  [beiStr intValue];
             int shang = minNum/beiNum;
             int yu = minNum%beiNum;
             int count = 0;
             if (yu == 0) {
                 count = shang *beiNum;
             }else{
                 count = (shang+1)*beiNum;
             }
             NSComparisonResult numRes = [fanDec compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]]];
             if (numRes == NSOrderedAscending) {
                 fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
                desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]] afterPoint:lpdt036],self.model.k1dt005];
             }
             NSDecimalNumber *numOne = [NSDecimalNumber decimalNumberWithString:@"100000"];
             NSDecimalNumber *shuru = [[NSDecimalNumber decimalNumberWithString:self.orderFile.text] decimalNumberByMultiplyingBy:numOne];
             NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",_model.multipleBase]];
             if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",_model.multipleBase]]) {
                 num = [NSDecimalNumber decimalNumberWithString:@"0"];
             }
             NSDecimalNumber *beishu = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",num]] decimalNumberByMultiplyingBy: numOne];
             NSInteger jieguo = [[NSString stringWithFormat:@"%@",shuru] integerValue]/[[NSString stringWithFormat:@"%@",beishu] integerValue];
             NSUInteger yushu = [[NSString stringWithFormat:@"%@",shuru] integerValue]%[[NSString stringWithFormat:@"%@",beishu] integerValue];
           
             if (yushu != 0) {
                 NSDecimalNumber *jie = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",jieguo+1]];
                 fanDec = [jie decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",num]]];
             }else{
                   fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",jieguo]];
                 fanDec = [fanDec decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",num]]];
                
             }
             
             NSString *isFan;
//              NSDecimalNumber *fanDec = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
              NSComparisonResult bijiaoRes = [fanDec compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]]];
             if (bijiaoRes == NSOrderedAscending) {
                 
                 if ([[NSString stringWithFormat:@"%@",fanDec] isEqualToString:@"0"]) {
                      fanDec = [NSDecimalNumber decimalNumberWithString:@"0"];
                     desStr = @"";
                 }else{
                        fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
                        desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]] afterPoint:lpdt036],self.model.k1dt005];

                 }
     
                 
                 isFan = @"no";
                               }
              NSComparisonResult bijiaoResOne = [fanDec compare:self.model.maxQuality];
             if (bijiaoResOne == NSOrderedDescending) {
                 if (![[NSString stringWithFormat:@"%@",self.model.maxQuality] isEqualToString:@"0"]) {
                     fanDec = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:self.model.maxQuality afterPoint:lpdt036]];
                     isFan = @"yes";
                     desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最多可购买",[BGControl notRounding:self.model.maxQuality afterPoint:lpdt036],self.model.k1dt005];
                 }
             }
             NSDecimalNumber *numone = fanDec;
             if (![[NSString stringWithFormat:@"%@",self.model.sys001Text] isEqualToString:@"0"]&& ![[NSString stringWithFormat:@"%@",self.model.sys001Text] isEqualToString:@"无货"]&&![[NSString stringWithFormat:@"%@",self.model.sys001Text] isEqualToString:@"有货"]) {
                 numone = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.sys001Text]];
                 
             }
             NSComparisonResult res = [fanDec compare:numone];
             if (res == NSOrderedDescending) {
                 fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.sys001Text]];
                 desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"可定量最多为",[BGControl notRounding:numone afterPoint:lpdt036],self.model.k1dt005];
                 
                 
             }
//             if ([[NSDecimalNumber decimalNumberWithString:self.orderFile.text] compare:self.model.minQuality] == NSOrderedAscending) {
//                 if ([[NSString stringWithFormat:@"%@",self.orderFile.text] isEqualToString:@"0"]) {
//                     desStr = @"";
//                 }else{
//                 desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:self.model.minQuality afterPoint:lpdt036],self.model.k1dt005];
//                 }
//             }
             
        if (_OrderDelegate &&[_OrderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:withStr:)]) {
            [_OrderDelegate getOrderCount:fanDec withKey:self.keyStr withIndex:self.index withPrice:price withStr:desStr ];
        }
         }

    }else{
        if ( ![BGControl isNULLOfString:self.orderFile.text]) {
            
            NSDecimalNumber *fanDec = [NSDecimalNumber decimalNumberWithString:self.orderFile.text];
            
            NSString *minStr = [NSString stringWithFormat:@"%@",_model.minQuality];
            int minNum =  [minStr intValue];
            NSString *beiStr = [NSString stringWithFormat:@"%@",_model.multipleBase];
            int beiNum =  [beiStr intValue];
            int shang = minNum/beiNum;
            int yu = minNum%beiNum;
            int count = 0;
            if (yu == 0) {
                count = shang *beiNum;
            }else{
                count = (shang+1)*beiNum;
            }
            NSComparisonResult numRes = [fanDec compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]]];
            if (numRes == NSOrderedAscending) {
                fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
                desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]] afterPoint:lpdt036],self.model.k1dt005];
            }
            NSDecimalNumber *numOne = [NSDecimalNumber decimalNumberWithString:@"100000"];
            NSDecimalNumber *shuru = [[NSDecimalNumber decimalNumberWithString:self.orderFile.text] decimalNumberByMultiplyingBy:numOne];
            NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",_model.multipleBase]];
            if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",_model.multipleBase]]) {
                num = [NSDecimalNumber decimalNumberWithString:@"0"];
            }
             NSDecimalNumber *beishu = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",num]] decimalNumberByMultiplyingBy: [NSDecimalNumber decimalNumberWithString:@"100000"]];
            NSInteger jieguo = [[NSString stringWithFormat:@"%@",shuru] integerValue]/[[NSString stringWithFormat:@"%@",beishu] integerValue];
            NSUInteger yushu = [[NSString stringWithFormat:@"%@",shuru] integerValue]%[[NSString stringWithFormat:@"%@",beishu] integerValue];
            if (yushu != 0) {
                NSDecimalNumber *jie = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",jieguo+1]];
                fanDec = [jie decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",num]]];
            }else{
                fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",jieguo]];
                
            }

            if (![BGControl isNULLOfString:self.model.sys001Text]) {
                NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:@"0"];
                if (![[NSString stringWithFormat:@"%@",self.model.sys001Text] isEqualToString:@"0"]&& ![[NSString stringWithFormat:@"%@",self.model.sys001Text] isEqualToString:@"无货"]) {
                    num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.sys001Text]];
                    
                }
                NSComparisonResult res = [[NSDecimalNumber decimalNumberWithString:self.orderFile.text] compare:num];
                if (res == NSOrderedDescending) {
                    fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.model.sys001Text]];
                    desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"可定量最多为",[BGControl notRounding:num afterPoint:lpdt036],self.model.k1dt005];
                    
                    
                }
            }
            NSString *isFan;
            NSComparisonResult bijiaoRes = [fanDec compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]]];
            if (bijiaoRes == NSOrderedAscending) {
             
                if ([[NSString stringWithFormat:@"%@",fanDec] isEqualToString:@"0"]) {
                    fanDec = [NSDecimalNumber decimalNumberWithString:@"0"];
                    desStr = @"";
                }else{
                       fanDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
                   desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]] afterPoint:lpdt036],self.model.k1dt005];

                }
                
                             }
            NSComparisonResult bijiaoResOne = [fanDec compare:self.model.maxQuality];
            if (bijiaoResOne == NSOrderedDescending) {
                if (![[NSString stringWithFormat:@"%@",self.model.maxQuality] isEqualToString:@"0"]) {
                    isFan = @"yes";
                    fanDec = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:self.model.maxQuality afterPoint:lpdt036]];
                    desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最多可购买",[BGControl notRounding:self.model.maxQuality afterPoint:lpdt036],self.model.k1dt005];
                }
            }
            
      
            
            
            if ([[NSDecimalNumber decimalNumberWithString:self.orderFile.text] compare:self.model.minQuality] == NSOrderedAscending) {
                if ([[NSString stringWithFormat:@"%@",self.orderFile.text] isEqualToString:@"0"]) {
                    desStr = @"";
                }else{
                desStr = [NSString stringWithFormat:@"%@%@%@%@",self.model.k1dt002,@"最低购买量为",[BGControl notRounding:self.model.minQuality afterPoint:lpdt036],self.model.k1dt005];
                }
            }
            if (_OrderDelegate &&[_OrderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:withStr:)]) {
                [_OrderDelegate getOrderCount:fanDec withKey:self.keyStr withIndex:self.index withPrice:[NSDecimalNumber decimalNumberWithString:@"0"] withStr:desStr ];
            }
        }
        

    }
    }
@end
