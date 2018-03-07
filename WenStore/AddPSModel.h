//
//  AddPSModel.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface AddPSModel : BaseModel
@property (nonatomic)NSString *priceUnitName; //價格單位名稱
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)BOOL hasProductDesc;//有產品描述
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSString *k1dt700;//主檔的k1mf800
@property (nonatomic)NSString *k1dt001;//品號
@property (nonatomic)NSString *k1dt002;//品名
@property (nonatomic)NSString *k1dt003;//規格

@property (nonatomic)NSString *k1dt004;//計數單位代號
@property (nonatomic)NSString *k1dt005;//計數單位
@property (nonatomic)NSDecimalNumber *k1dt101;//計數數量
@property (nonatomic)NSDecimalNumber *k1dt102;//採購數量
@property (nonatomic)NSDecimalNumber *k1dt103;//已進貨數量
@property (nonatomic)NSDecimalNumber *k1dt106;//超收率
@property (nonatomic)BOOL k1dt402;//超收管理

@property (nonatomic)NSString *k1dt011;//計價單位
@property (nonatomic)NSString *k1dt011d;//計價單位代號
@property (nonatomic)NSDecimalNumber *k1dt110;//計價數量
@property (nonatomic)NSDecimalNumber *k1dt201;//單價
@property (nonatomic)NSDecimalNumber *k1dt201Price;//單價
@property (nonatomic)NSDecimalNumber *k1dt202;//金額(後台會重新計算)

@property (nonatomic)BOOL isSameUnit;//採購單位是否與計價單位一樣
@property (nonatomic)NSString *xianStr;
@property (nonatomic)NSDecimalNumber *k1dt101Count;//计数
@property (nonatomic)NSDecimalNumber *k1dt110Count;//计价

@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;

@property (nonatomic)NSString *k1dt601;//
@property (nonatomic)NSString *k1dt800;//
@end
