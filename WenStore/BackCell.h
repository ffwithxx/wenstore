//
//  BackCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/6.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EditModel.h"
@protocol inputOnedelegate <NSObject>

@optional

-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag ;

@end

@protocol backDelegate <NSObject>

@optional

-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end
@interface BackCell : UITableViewCell
- (void)showModelWithModel:(EditModel *)model;

@property (weak,nonatomic) id<backDelegate > backDelegate;
@property (weak,nonatomic) id<inputOnedelegate > inputOnedelegate;
@end
