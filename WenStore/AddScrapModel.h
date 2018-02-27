//
//  AddScrapModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface AddScrapModel : BaseModel
@property (nonatomic)NSString *priceUnitName;//價格單位名稱
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)BOOL hasProductDesc;//有產品描述
@property (nonatomic)BOOL selected;//
@property (nonatomic)int imge004;//產品圖片版本
@property (nonatomic)NSString *k1dt001;//產品代號
@property (nonatomic)NSString *k1dt002; //產品名稱
@property (nonatomic)NSString *k1dt003;//規格
@property (nonatomic)NSString *k1dt003d;//描述
@property (nonatomic)NSString *k1dt004;//分類
@property (nonatomic)NSString *k1dt005; //單位名稱
@property (nonatomic)NSString *k1dt005d;//單位代號
@property (nonatomic)NSDecimalNumber  *k1dt101;//報廢數量
//@property (nonatomic)NSDecimalNumber  *k1dt102;//配送數量

//@property (nonatomic)NSDecimalNumber  *k1dt103;//收貨數量
//@property (nonatomic)NSDecimalNumber  *k1dt104;//收貨差異數量
//@property (nonatomic)NSDecimalNumber  *k1dt105;//收貨稽核數量
//@property (nonatomic)NSString *k1dt504;//稽核說明
@property (nonatomic)NSDecimalNumber  *k1dt201;//單價
@property (nonatomic)NSDecimalNumber  *k1dt202;//金額
@property (nonatomic)NSString  *k1dt502;//報廢原因
@property (nonatomic)NSString  *k1dt501;//原因類別代號
@property (nonatomic)NSString  *k1dt503;//原因說明
@property (nonatomic)NSDecimalNumber *orderCount;
@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;
@end
