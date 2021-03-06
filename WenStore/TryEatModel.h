//
//  TryEatModel.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface TryEatModel : BaseModel
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)BOOL hasProductPicture;//有產品圖片
@property (nonatomic)NSString *k1dt002; //產品名稱
@property (nonatomic)NSString *k1dt001; //品號
@property (nonatomic)NSString *k1dt003; //產品规格
@property (nonatomic)NSString *k1dt004; //類別名稱
@property (nonatomic)NSString *k1dt005; //單位名稱

@property (nonatomic)NSString *k1dt005d; //單位代號
@property (nonatomic)NSDecimalNumber  *k1dt201;//單價
@property (nonatomic)NSDecimalNumber  *k1dt202;//

@property (nonatomic)NSDecimalNumber *k1dt101; //試吃數量
@property (nonatomic)NSDecimalNumber *k1dt102; //生產指示數量
@property (nonatomic)BOOL k1dt401;//生產否
@property (nonatomic)NSDecimalNumber *k1dt103; //差異數量，本欄為等於生產指示數量-生產數量
@property (nonatomic)NSDecimalNumber *k1dt104; //報廢數量

@property (nonatomic)NSString *k1dt011; //计价單位名稱
@property (nonatomic)NSDecimalNumber *k1dt110; //计价数量
@property (nonatomic)NSDecimalNumber *orderCount;
@property (nonatomic)NSString *xianStr;
@property(nonatomic)NSString  *keyStr;
@property(nonatomic)NSInteger  index;
@property (nonatomic)NSString *keyOneStr;
@property(nonatomic)NSInteger indexOne;
@end
