//
//  IP.m
//  WenStore
//
//  Created by 冯丽 on 17/8/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "IP.h"

@implementation IP

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (IBAction)buttonClick:(UIButton *)sender {
    NSString *ipStr;
    if (sender.tag == 201) {
        
        NSArray *arr = @[@"hiddle",@"hiddle"];
        self.getIpBlock(arr);
    }else{
        NSArray *arr = @[self.ipText.text,@"hiddle"];
        self.getIpBlock(arr);
    }
}

@end
