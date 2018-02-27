//
//  BuyModel.h
//  WenStore
//
//  Created by 冯丽 on 17/9/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface BuyModel : BaseModel
@property (nonatomic)NSString *k7mf004;//品號(促發活動的產品代號)
@property (nonatomic)NSDecimalNumber *k7mf005; //每叫貨數量
@property (nonatomic)int k7mf006; //活動類別. 1: 贈送; 2: 必配; 3: 促銷
@property (nonatomic)NSString *k7mf007;//關聯品號(活動的產品代號)
@property (nonatomic)NSString *k7mf008;//關聯品名
@property (nonatomic)NSString *k7mf009;//關聯規格
@property (nonatomic)NSString *k7mf010;//關聯單位
@property (nonatomic)NSString *k7mf011;//關聯單位名稱
@property (nonatomic)NSDecimalNumber *k7mf012;//關聯數量
@property (nonatomic)NSString *k7mf016;//活動說明
@property (nonatomic)NSDecimalNumber *k7mf017;//促销价钱
@property (nonatomic)int imge004;//產品圖片API Path
@property (nonatomic)NSDecimalNumber *orderCount;
@end
