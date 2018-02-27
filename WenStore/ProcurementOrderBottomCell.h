//
//  ProcurementOrderBottomCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProcurementModel.h"

@protocol bottomDelegate <NSObject>

@optional

-(void)procurementWithModel:(AddProcurementModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end

@interface ProcurementOrderBottomCell : UITableViewCell
- (void)showModelWithModel:(AddProcurementModel *)model;
@property (weak,nonatomic) id<bottomDelegate > bottomDelegate;
@end
