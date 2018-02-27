//
//  PurchaseOnePageModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface PurchaseOnePageModel : BaseModel
@property (nonatomic)BOOL isNeedDeleteConfirmation;//刪除前要進行提示
@property (nonatomic)BOOL isEditable;//是否可編輯
@property (nonatomic)NSString *k1mf000;//作業別代號
@property (nonatomic)NSString *k1mf001;//門市代號
@property (nonatomic)NSDate *k1mf003;//盤點日期
@property (nonatomic)int *k1mf005;//進貨序號
@property (nonatomic)BOOL k1mf006;//盘点确认
@property (nonatomic)NSDate *k1mf007;//收单时间
@property (nonatomic)BOOL k1mf008;//ERP建立的單據
@property (nonatomic)NSString *k1mf010;//備註
@property (nonatomic)NSString *k1mf011;//訂單編號

@property (nonatomic)NSString *k1mf100;//單號
@property (nonatomic)NSString *k1mf101;//廠商名稱
@property (nonatomic)NSString *k1mf105;//課稅別代號
@property (nonatomic)NSString *k1mf106;//課稅別名稱

@property (nonatomic)NSString *k1mf107;// 進貨廠商代號
@property (nonatomic)BOOL k1mf108;//已付款

@property (nonatomic)NSString *k1mf116;//發票類別代號
@property (nonatomic)NSString *k1mf117;//發票類別名稱
@property (nonatomic)NSString *k1mf118;//發票號碼
@property (nonatomic)NSString *k1mf119;//統一編號

@property (nonatomic)NSDecimalNumber *k1mf302;//總金額
@property (nonatomic)NSDecimalNumber *k1mf303;//總數量
@property (nonatomic)NSDecimalNumber *k1mf304;//整張金額

@property (nonatomic)NSString *k1mf500;//底稿代號

@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSString *k1mf996;//建立人員
@property (nonatomic)NSDate *k1mf997;//建立日期
@property (nonatomic)NSString *k1mf998;//修改人員
@property (nonatomic)NSDate *k1mf999;//修改日期



@property (nonatomic)NSString *billStateName;//表單狀態名稱
@property (nonatomic)NSString *billStateShortName;//表單狀態簡稱

@property (nonatomic)int billState;//表單狀態
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
