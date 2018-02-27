//
//  ReasonView.m
//  WenStore
//
//  Created by 冯丽 on 17/9/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ReasonView.h"
#import "BGControl.h"

@implementation ReasonView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (void)drawRect:(CGRect)rect {
    self.subMitBth.layer.cornerRadius = 20.f;
    self.resonTextFile.clipsToBounds = YES;
    self.resonTextFile.layer.cornerRadius = 5.f;
    self.resonTextFile.layer.borderColor = kTextLighColor.CGColor;
    self.resonTextFile.layer.borderWidth = 1.f;
    self.resonTextFile.keyboardType = UIReturnKeyDone;
    
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (![BGControl isNULLOfString:self.resonTextFile.text]) {
        if (_delegate && [_delegate respondsToSelector:@selector(resonStr:withKey:withIndex:)]) {
            [_delegate resonStr:self.resonTextFile.text withKey:self.keyStr withIndex:self.index];
        }
    }
   
}

@end
