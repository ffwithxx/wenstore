//
//  ScrapModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface ScrapModel : BaseModel
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)NSString *k1dt002; //產品名稱
@property (nonatomic)NSString *k1dt001; //
@property (nonatomic)NSString *k1dt003; //產品规格
@property (nonatomic)NSDecimalNumber  *k1dt201;//單價

@property (nonatomic)NSString *k1dt005; //單位名稱
@property (nonatomic)NSDecimalNumber *k1dt101; //報廢數量
@property (nonatomic)NSString *k1dt011; //计价單位名稱
@property (nonatomic)NSDecimalNumber *k1dt110; //计价数量
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSString *priceUnitName; //價格單位名稱
@property (nonatomic)NSString *k1dt501; //原因類別代號
@property (nonatomic)NSString *k1dt502; //報廢原因
@property (nonatomic)NSString *k1dt503; //原因說明
@end
