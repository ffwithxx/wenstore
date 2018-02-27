//
//  StocktakModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"


@interface StocktakModel : BaseModel
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
@property (nonatomic)NSString *k1dt005;//單位名稱
@property (nonatomic)NSString *k1dt005d;//單位代號
@property (nonatomic)NSString *k1dt011d;//大單位代號
@property (nonatomic)NSString *k1dt011;//大單位名稱
@property (nonatomic)NSDecimalNumber *k1dt011n;//大單位量
@property (nonatomic)NSString *k1dt012d;//中單位代號
@property (nonatomic)NSString *k1dt012;//中單位名稱
@property (nonatomic)NSDecimalNumber *k1dt012n;//中單位量
@property (nonatomic)NSString *k1dt013d;//小單位代號
@property (nonatomic)NSString *k1dt013;//小單位名稱
@property (nonatomic)NSDecimalNumber *k1dt013n;//小單位量
@property (nonatomic)NSDecimalNumber *k1dt101;//盤點數量
@property (nonatomic)NSDecimalNumber *k1dt201;//單價
@property (nonatomic)NSDecimalNumber *k1dt202;//額(後台會重新計算)
@property (nonatomic)BOOL k1dt401;//盤點否
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSDecimalNumber *k1dt011nCount;//大单位
@property (nonatomic)NSDecimalNumber *k1dt012nCount;//中单位
@property (nonatomic)NSDecimalNumber *k1dt013nCount;//小单位
@property (nonatomic)NSDecimalNumber *k1dt101Count;//盘点
@property (nonatomic)BOOL isCancle;//是否取消

@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;
@end
