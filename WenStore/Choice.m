//
//  Choice.m
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "Choice.h"

@implementation Choice

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)bthClick:(UIButton *)sender {
    if (_delegate &&[_delegate respondsToSelector:@selector(postChoiceStr:)]) {
        [_delegate postChoiceStr:[NSString stringWithFormat:@"%ld",sender.tag]];
    }
    

}

@end
