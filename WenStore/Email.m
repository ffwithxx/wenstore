//
//  Email.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "Email.h"
#import "BGControl.h"

@implementation Email

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(UIButton *)sender {
    if (![BGControl isNULLOfString:self.orderFile.text]) {
        if (_emailDelegate &&[_emailDelegate respondsToSelector:@selector(fanDelegate:)]) {
            [_emailDelegate fanDelegate:self.orderFile.text];
        }
    }
}

@end
