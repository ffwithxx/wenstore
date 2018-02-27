//
//  AddPurchaseModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface AddPurchaseModel : BaseModel

@property (nonatomic)NSString *priceUnitName;//價格單位名稱
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)BOOL hasProductDesc;//有產品描述
@property (nonatomic)BOOL selected;//
@property (nonatomic)int imge004;//產品圖片版本

@property (nonatomic)NSString *k1dt001;//產品代號
@property (nonatomic)NSString *k1dt002; //產品名稱
@property (nonatomic)NSString *k1dt003;//規格
@property (nonatomic)NSString *k1dt004; //類別名稱

@property (nonatomic)NSString *k1dt005; //計數單位
@property (nonatomic)NSString *k1dt005d;//進貨單位代號
@property (nonatomic)NSDecimalNumber *k1dt201Price;//單價
@property (nonatomic)NSDecimalNumber  *k1dt101;//計數數量
@property (nonatomic)NSDecimalNumber  *k1dt102;//採購數量
@property (nonatomic)NSString *k1dt011; //計價單位
@property (nonatomic)NSString *k1dt011d; //計價單位代號
@property (nonatomic)NSDecimalNumber  *k1dt110;//計價數量
@property (nonatomic)NSDecimalNumber  *k1dt201;//單價
@property (nonatomic)NSDecimalNumber  *k1dt202;//金額
@property (nonatomic)BOOL k1dt402;//超收管理
@property (nonatomic)NSDecimalNumber  *k1dt106;//超收比率
@property (nonatomic)NSString *k1dt503;//K1DT503
@property (nonatomic)BOOL isSameUnit;//進貨單位是否與計價單位一樣

@property (nonatomic)NSString *k1dt011Unit;//計價單位代號，如果k1dt011d為null或者空白，則此欄位值為k1dt005d，否則為k1dt011d
@property (nonatomic)NSString *k1dt011UnitText;//k1dt011Unit的單位名稱
@property (nonatomic)NSDecimalNumber *orderCount;
@property (nonatomic)NSDecimalNumber *jijiaOrderCount;
@property (nonatomic)NSDecimalNumber *MaxK1dt101;
@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;


@end
