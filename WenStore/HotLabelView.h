//
//  HotLabelView.h
//  Miao
//
//  Created by 指南猫 on 15/12/2.
//  Copyright © 2015年 ZNM. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HotLabelView;

@protocol HotLabelViewDelegate <NSObject>

@optional

- (void)hotLabelViewHotLabelClick:(HotLabelView *)hotLabelView lastIndex:(NSInteger )lastIndex currentIndex:(NSInteger)currentIndex;
@end

@interface HotLabelView : UIView

@property (nonatomic, weak) id<HotLabelViewDelegate> delegate;

@property (nonatomic, strong) NSArray *labelArray;
//@property (nonatomic, assign) NSInteger bthIndex;
@property (nonatomic, strong) UIButton *button;
//@property (nonatomic, strong)NSMutableArray *buttonArray;
@end
