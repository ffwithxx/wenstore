//
//  PSOnePageModel.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface PSOnePageModel : BaseModel
//@property (nonatomic)BOOL isStockImport;//已轉出到進貨單
//@property (nonatomic)BOOL exported;//已轉出到進貨單，跟isStockImport相同
//@property (nonatomic)NSDate *exportedDate;//轉出的進貨單日期
//@property (nonatomic)BOOL exportedAndConfirmed;//有已轉出並且確認的進貨單
//@property (nonatomic)BOOL exportedAndConfirmedDate;//已轉出，並且已確認的進貨單的日期
@property (nonatomic)BOOL isNeedDeleteConfirmation;//刪除前要進行提示
@property (nonatomic)BOOL isEditable;//是否可編輯
@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSString *k1mf000;//作業別代號
@property (nonatomic)NSString *k1mf001;//門市代號
@property (nonatomic)NSDate *k1mf003;//進貨日期

@property (nonatomic)int k1mf005;//進貨序號
@property (nonatomic)BOOL k1mf006;//進貨確認
@property (nonatomic)NSDate *k1mf600;//提交日期
@property (nonatomic)NSDate *k1mf007;//傳至ERP時間
@property (nonatomic)NSString *k1mf010;//備註
@property (nonatomic)NSString *k1mf011;//門市名稱
@property (nonatomic)NSString *k1mf100;//訂單編號
@property (nonatomic)NSString *k1mf101;//廠商名稱
@property (nonatomic)NSString *k1mf105;//課稅別代號
@property (nonatomic)NSString *k1mf106;//課稅別名稱
@property (nonatomic)NSString *k1mf107;//採購廠商代號
@property (nonatomic)BOOL k1mf108;//已付款
@property (nonatomic)BOOL k1mf109;//總部採購


@property (nonatomic)NSString *k1mf116;//發票類別代號
@property (nonatomic)NSString *k1mf117;//發票類別名稱
@property (nonatomic)NSString *k1mf118;//發票號碼
@property (nonatomic)NSString *k1mf119;//統一編號
@property (nonatomic)int k1mf201;//結案狀態


@property (nonatomic)NSDecimalNumber *k1mf302;//總金額
@property (nonatomic)NSDecimalNumber *k1mf303;//總數量
@property (nonatomic)NSString *K1mf996;//建立人員
@property (nonatomic)NSDate *k1mf997;//建立日期
@property (nonatomic)NSString *k1mf998;//修改人員
@property (nonatomic)NSDate *k1mf999;//修改日期
@property (nonatomic)NSString *billStateName;//表單狀態名稱
@property (nonatomic)NSString *billStateShortName;//表單狀態簡稱

@property (nonatomic)int billState;//表單狀態
@property (nonatomic)int detailCount;//明細筆數
@property (nonatomic)BOOL isDisplayEditButton;//是否顯示編輯按鈕
@property (nonatomic)BOOL isDisplayDeleteButton;//是否顯示刪除按鈕
@property (nonatomic)BOOL isDisplayCommitButton;//是否顯示提交按鈕
@property (nonatomic)BOOL isDisplayPayBillButton;//是否顯示支付按鈕
@property (nonatomic)BOOL isDisplayCheckedButton;//是否顯示稽核按鈕
@property (nonatomic)BOOL isDisplayConfirmedButton;//是否顯示核定按鈕
@property (nonatomic)BOOL isDisplayTransferButton;//是否顯示轉出按鈕
@property (nonatomic)BOOL isDisplayCaseClosedButton;//是否顯示結案按鈕
@property (nonatomic)BOOL isDisplaySendMailButton;//是否顯示發郵件按鈕

@end
