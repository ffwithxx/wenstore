//
//  StocktakOnePageModel.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface StocktakOnePageModel : BaseModel
@property (nonatomic)BOOL isNeedDeleteConfirmation;//刪除前要進行提示
@property (nonatomic)BOOL isEditable;//是否可編輯
@property (nonatomic)NSString *k1mf000;//作業別代號
@property (nonatomic)NSString *k1mf001;//門市代號
@property (nonatomic)NSDate *k1mf003;//盤點日期
@property (nonatomic)BOOL k1mf006;//盘点确认
@property (nonatomic)NSDate *k1mf007;//收单时间



@property (nonatomic)NSString *k1mf100;//單號

@property (nonatomic)NSString *k1mf102;//盤點類型



@property (nonatomic)NSDecimalNumber *k1mf302;//總金額
@property (nonatomic)NSDecimalNumber *k1mf303;//總數量


@property (nonatomic)NSString *k1mf500;//底稿代號

@property (nonatomic)NSString *k1mf800;//KEY GUID

@property (nonatomic)NSDate *k1mf997;//建立日期




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
