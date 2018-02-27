//
//  ProcurementOrderOnePagModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface ProcurementOrderOnePagModel : BaseModel
@property (nonatomic)NSDate *isStockImport;//已轉出到進貨單
@property (nonatomic)NSDate *exported;//已轉出到進貨單，跟isStockImport相同
@property (nonatomic)NSDate *exportedDate;//轉出的進貨單日期
@property (nonatomic)BOOL exportedAndConfirmed;//有已轉出並且確認的進貨單
@property (nonatomic)BOOL exportedAndConfirmedDate;//已轉出，並且已確認的進貨單的日期

@property (nonatomic)BOOL isNeedDeleteConfirmation;//刪除前要進行提示
@property (nonatomic)BOOL isEditable;//是否可編輯
@property (nonatomic)NSString *k1mf000;//作業別代號
@property (nonatomic)NSString *k1mf001;//門市代號
@property (nonatomic)NSDate *k1mf003;//採購日期
@property (nonatomic)NSDate *k1mf004;//預交日期
@property (nonatomic)int *k1mf005;//進貨序號
@property (nonatomic)BOOL k1mf006;//採購確認
@property (nonatomic)NSDate *k1mf007;//收单时间

@property (nonatomic)NSString *k1mf010;//備註
@property (nonatomic)NSString *k1mf011;//門市名稱
@property (nonatomic)NSDate *k1mf600;//提交日期
@property (nonatomic)NSString *k1mf100;//單號
@property (nonatomic)NSString *k1mf101;//廠商名稱
@property (nonatomic)NSString *k1mf105;//課稅別代號
@property (nonatomic)NSString *k1mf106;//課稅別名稱

@property (nonatomic)NSString *k1mf107;// 進貨廠商代號
@property (nonatomic)BOOL k1mf108;//已付款

@property (nonatomic)NSString *k1mf111;//公司名稱
@property (nonatomic)NSString *k1mf112;//門市電話


@property (nonatomic)NSDecimalNumber *k1mf302;//總金額
@property (nonatomic)NSDecimalNumber *k1mf303;//總數量
@property (nonatomic)NSDecimalNumber *k1mf304;//整張金額

@property (nonatomic)NSString *k1mf500;//底稿代號

@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSString *k1mf996;//建立人員
@property (nonatomic)NSDate *k1mf997;//新單據建立日期
@property (nonatomic)NSString *k1mf998;//修改人員
@property (nonatomic)NSDate *k1mf999;//修改日期



@property (nonatomic)NSString *billStateName;//表單狀態名稱
@property (nonatomic)NSString *billStateShortName;//表單狀態簡稱

@property (nonatomic)int billState;//表單狀態

@property (nonatomic)NSDictionary *otherBillState ;//
@end
