//
//  NewModel.h
//  WenStore
//
//  Created by 冯丽 on 17/8/29.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface NewModel : BaseModel
@property (nonatomic)BOOL hasLimiteInfo;
@property (nonatomic)bool hasFree;//有赠送
@property (nonatomic)BOOL hasBuyTogether;//有必配
@property (nonatomic)BOOL hasPromo;//有促銷
@property (nonatomic)BOOL hasPric;//有促銷
@property (nonatomic)NSDecimalNumber *maxQuality;//上限數量
@property (nonatomic)NSDecimalNumber *minQuality;//下限數量

@property (nonatomic)NSDecimalNumber *multipleBase;//叫貨倍數
@property (nonatomic)NSDecimalNumber *originalK1dt201;//原單價(未分量計價過的單價)
@property (nonatomic)NSDecimalNumber *originaltest;//原單價(未分量計價過的單價)

@property (nonatomic)NSString *priceUnitName;//價格單位名稱
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)BOOL hasProductDesc;//有產品描述
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)NSString *k1dt001;//產品代號
@property (nonatomic)NSString *k1dt002; //產品名稱
@property (nonatomic)NSString *k1dt003;//規格
@property (nonatomic)NSString *k1dt004;//分類
@property (nonatomic)NSString *k1dt005; //單位名稱
@property (nonatomic)NSString *k1dt005d;//單位代號
@property (nonatomic)NSDecimalNumber  *k1dt101;//預測叫貨量
@property (nonatomic)NSDecimalNumber  *k1dt102;//叫貨數量
@property (nonatomic)NSDecimalNumber  *k1dt103;//上限數量(同maxQuality)
@property (nonatomic)NSDecimalNumber  *k1dt104;//下限數量(同minQuality)
@property (nonatomic)NSDecimalNumber  *k1dt105;//訂貨時庫存量
@property(nonatomic)NSString  *sys001Text;

@property (nonatomic)NSDecimalNumber  *k1dt201;//單價
@property (nonatomic)NSDecimalNumber  *k1dt202;//小計
@property (nonatomic)NSDecimalNumber  *k1dt301;//叫貨倍數(同multipleBase)
@property (nonatomic)int  k1dt302;//叫貨類型
@property (nonatomic)BOOL  k1dt401;//分量計價
@property (nonatomic)BOOL  k1dt402;//暫不供貨
@property (nonatomic)NSInteger  maxHei;
@property (nonatomic)NSInteger  bottomHei;
@property (nonatomic)NSDecimalNumber *orderCount;
@property (nonatomic)NSDecimalNumber *sys001;
@property (nonatomic)NSInteger  jiCount;

@property(nonatomic)NSMutableDictionary *freeDict;
@property(nonatomic)NSMutableDictionary *buyDict;
@property (nonatomic)NSMutableDictionary *promDict;
@property (nonatomic)NSDecimalNumber  *sumPrice;
@property (nonatomic)NSString *xianStr;
@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *keyOneStr;
@property (nonatomic)NSString *remindStr;
@property(nonatomic)NSInteger indexOne;
@property(nonatomic)NSInteger ispei;
@property(nonatomic)NSDecimalNumber *minPei;
@end
