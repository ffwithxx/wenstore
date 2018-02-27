//
//  orderModel.h
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface orderModel : BaseModel
@property (nonatomic)BOOL doSend;//是否已發貨
@property (nonatomic)BOOL isNeedDeleteConfirmation;//刪除前要進行提示
@property (nonatomic)BOOL isEditable;//是否可編輯
@property (nonatomic)NSString *k1mf000;//作業別代號
@property (nonatomic)NSString *k1mf001;//門市代號
@property (nonatomic)NSDate *k1mf003;//叫貨日期
@property (nonatomic)NSDate *k1mf004;//配送日期
//@property (nonatomic)NSDate *k1mf007;//傳至ERP時間
@property (nonatomic)NSString *k1mf005;//叫貨序號
@property (nonatomic)BOOL k1mf006;//訂單提交
@property (nonatomic)BOOL k1mf008;//ERP建立的單據
@property (nonatomic)NSString *k1mf010;//備註

@property (nonatomic)NSString *k1mf011;//門市名稱
@property (nonatomic)NSString *k1mf100;//單號
@property (nonatomic)NSString *k1mf101;//叫貨對象代號

@property (nonatomic)NSString *k1mf102;//叫貨對象名稱
@property (nonatomic)NSString *k1mf104;//門市地址
@property (nonatomic)NSString *k1mf105;//其他資訊

@property (nonatomic)NSString *k1mf106;//付款帳號
@property (nonatomic)BOOL k1mf109;//是否加急
@property (nonatomic)NSString *k1mf111;//公司名稱
@property (nonatomic)NSString *k1mf112;//門市電話

@property (nonatomic)NSString *k1mf113;//聯絡人
@property (nonatomic)NSString *k1mf201;//提貨方式
@property (nonatomic)NSString *k1mf202;//配送方式

@property (nonatomic)NSDecimalNumber *k1mf301;//附加運費
@property (nonatomic)NSDecimalNumber *k1mf302;//總金額
@property (nonatomic)NSDecimalNumber *k1mf303;//總數量
@property (nonatomic)NSDecimalNumber *k1mf103;//總數量

@property (nonatomic)NSDecimalNumber *k1mf304;//管理費用
@property (nonatomic)NSString *k1mf500;//底稿代號
//@property (nonatomic)NSDate *k1mf600;//提交時間
@property (nonatomic)NSString *k1mf800;//KEY GUID
@property (nonatomic)NSDate *k1mf998;//修改日期
@property (nonatomic)NSString *k1mf999;//修改人

@property (nonatomic)NSDate *createAt;//建立日期
@property (nonatomic)NSDate *k1mf997;//新单据时间
@property (nonatomic)NSString *billStateName;//表單狀態名稱
@property (nonatomic)NSString *billStateShortName;//表單狀態簡稱
@property (nonatomic)int detailCount;//明細筆數
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
@property (nonatomic)NSDate *k1mf600 ;//已提交时间
@property (nonatomic)NSDate *k1mf007 ;//已收單时间
@property (nonatomic)NSDictionary *otherBillState ;//
@end
