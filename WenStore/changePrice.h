//
//  changePrice.h
//  WenStore
//
//  Created by 冯丽 on 2017/12/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProcurementModel.h"
#import "AddPSModel.h"
#import "AddPurchaseModel.h"

@protocol changePricedelegate <NSObject>

@optional

-(void) changePriceModel:(AddProcurementModel *)model  withPrice:(NSDecimalNumber *)price;

@end



@interface changePrice : UIView
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *orderFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (weak,nonatomic) id<changePricedelegate > changeDelegate;
@property (strong, nonatomic) AddProcurementModel *Model;
@property (strong, nonatomic) AddPSModel *PSModel;
@property (strong, nonatomic) AddPurchaseModel *PurchModel;
@property (strong, nonatomic) NSString *type;//1 为3022 2为 3023 3 为3004
@end
