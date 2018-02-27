//
//  AddProcurementModel.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/20.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface AddProcurementModel : BaseModel
@property (nonatomic)NSString *priceUnitName; //價格單位名稱
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)BOOL hasProductDesc;//有產品描述
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSString *k1dt700;//主檔的k1mf800
@property (nonatomic)NSString *k1dt001;//品號
@property (nonatomic)NSString *k1dt002;//品名
@property (nonatomic)NSString *k1dt003;//規格
@property (nonatomic)NSString *k1dt03d;//描述
@property (nonatomic)NSString *k1dt004;//類別名稱
@property (nonatomic)NSString *k1dt005;//計數單位
@property (nonatomic)NSDecimalNumber *k1dt101;//計數數量
@property (nonatomic)NSDecimalNumber *k1dt102;//已進貨數量
@property (nonatomic)NSString *k1dt011;//計價單位
@property (nonatomic)NSString *k1dt011d;//計價單位代號
@property (nonatomic)NSDecimalNumber *k1dt110;//計價數量
@property (nonatomic)NSDecimalNumber *k1dt201;//單價
@property (nonatomic)NSDecimalNumber *k1dt201Price;//單價
@property (nonatomic)NSDecimalNumber *k1dt202;//額(後台會重新計算)
@property (nonatomic)int k1dt301;//結案狀態
@property (nonatomic)NSString *k1dt011Unit;//計價單位代號，如果k1dt011d為null或者空白，則此欄位值為k1dt005d，否則為k1dt011d
@property (nonatomic)NSString *k1dt011UnitText;//k1dt011Unit的單位名稱
@property (nonatomic)BOOL isSameUnit;//採購單位是否與計價單位一樣
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSDecimalNumber *k1dt101Count;//计数
@property (nonatomic)NSDecimalNumber *k1dt110Count;//计价

@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;
@end
