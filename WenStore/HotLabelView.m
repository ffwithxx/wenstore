//
//  HotLabelView.m
//  Miao
//
//  Created by 指南猫 on 15/12/2.
//  Copyright © 2015年 ZNM. All rights reserved.
//

#import "HotLabelView.h"
//#import "UIView+Tools.h"
#import "NSString+Tools.h"
#import "UIView+Common.h"



#define kSpacing 15.0
#define kHotLabelHeight 20.0
#define kHotLabelWidth 60.0
#define kButtonHeight 30.0
#define kHotLabelFont [UIFont systemFontOfSize:13]
#define kButtonFont [UIFont systemFontOfSize:14]

@interface HotLabelView () {
    
    NSInteger _lastIndex;
    NSInteger _currentIndex;
}

@end

@implementation HotLabelView

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        _lastIndex = -1;
        _currentIndex = 0;
    }
    return self;
}

- (void)setLabelArray:(NSArray *)labelArray {
    _labelArray = labelArray;
    
    if (self.subviews.count > 0) {
        
        for (UIView *view in self.subviews) {
            [view removeFromSuperview];
        }
        
    }
    NSLog(@"lastInfdex是%ld",_lastIndex);
    
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(hideclick) name:@"hide" object:nil ];
    NSInteger count = _labelArray.count;
    CGFloat lengthLimit = self.frame.size.width;
    CGFloat buttonH = kButtonHeight;
    CGFloat buttonX = kSpacing;
    CGFloat buttonY = kSpacing;
    CGFloat buttonW = 0.0;
    for (NSInteger i = 0; i < count; i++) {
        
        NSString *title = _labelArray[i];
        CGSize titleSize = [title sizeWithFont:kButtonFont andMaxSize:CGSizeMake(lengthLimit, buttonH)];
        buttonW = titleSize.width + kSpacing * 2;
        //button.tag = 200+i;
        
        if (buttonX >= (lengthLimit - buttonW - kSpacing)) {
            
            buttonX = kSpacing;
            buttonY += (buttonH + kSpacing);
        }
        
        
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        _button.tag = i +200;
        _button.selected = NO;
        _button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        [_button setTitle:title forState:UIControlStateNormal];
        [_button setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        _button.layer.borderWidth = 1.f;
        _button.layer.borderColor = [kTextGrayColor CGColor];
        _button.backgroundColor = [UIColor whiteColor];
        
        _button.layer.cornerRadius = 15;
        _button.titleLabel.font = [UIFont systemFontOfSize:15];
        _button.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_button];
        
        if (i == _currentIndex) {
            
            _button.selected = YES;
        }
        if (i < count - 1) {
            [_button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
            if (_button.selected == YES) {
//                [_button setBackgroundColor:kTabBarColor];
                [_button setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            }
            // [_button setBackgroundImage:[UIImage imageNamed:@"A7D65620-2286-49B6-88F2-DD0BEB1207B6"] forState:UIControlStateSelected ];
            
        } else if (i == count - 1) {
            
            [_button addTarget:self action:@selector(addButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        }
        
        
        buttonX += (buttonW + kSpacing);
        
    }
    
    CGFloat height ;
    if (_button.tag == 200 +_labelArray.count - 1) {
        height = maxY(_button) +30;
    }
    _button.layer.borderWidth = 1.f;
//    _button.layer.borderColor = [kTabBarColor CGColor];
    
    NSString *str = [NSString stringWithFormat:@"%f",height];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str,@"buttonHeight", nil];
 [[NSNotificationCenter defaultCenter] postNotificationName:@"height" object:nil userInfo:dict];
}

- (void)hideclick {
    
//    self.button.hidden = YES;
    _lastIndex = _currentIndex +1;
//    _currentIndex = _labelArray.count - 2;
    NSString *str = [NSString stringWithFormat:@"%ld",_currentIndex];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:str,@"currId", nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"change" object:nil userInfo:dict];
    //    if (_delegate && [_delegate respondsToSelector:@selector(hotLabelViewHotLabelClick:lastIndex:currentIndex:)]) {
    //        [_delegate hotLabelViewHotLabelClick:self lastIndex:_lastIndex currentIndex:_currentIndex];
    //    }
    //
    
    
}
- (void)addButtonClick:(UIButton *)button {
    NSLog(@"添加%ld",button.tag);
    _lastIndex = _currentIndex;
    _currentIndex = button.tag - 200;
    if (_delegate && [_delegate respondsToSelector:@selector(hotLabelViewHotLabelClick:lastIndex:currentIndex:)]) {
        [_delegate hotLabelViewHotLabelClick:self lastIndex:_lastIndex currentIndex:_currentIndex];
        
    }
}

- (void)buttonClick:(UIButton *)button {
    _lastIndex = _currentIndex;
    
    UIButton *lastButton = (UIButton *)[self viewWithTag:_lastIndex + 200];
    lastButton.selected = NO;
    lastButton.backgroundColor = [UIColor whiteColor];
    [lastButton setTitleColor:kTextGrayColor forState:UIControlStateNormal];
    _currentIndex = button.tag -200;
    button.selected = YES;
//    button.backgroundColor = kTabBarColor;
    if (_delegate && [_delegate respondsToSelector:@selector(hotLabelViewHotLabelClick:lastIndex:currentIndex:)]) {
        [_delegate hotLabelViewHotLabelClick:self lastIndex:_lastIndex currentIndex:_currentIndex];
    }
    
}
@end
