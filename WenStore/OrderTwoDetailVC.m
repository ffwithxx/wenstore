//
//  OrderTwoDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OrderTwoDetailVC.h"
#import "OrderTwoDetailCell.h"
#import "BGControl.h"
#import "AddressListVC.h"
#import "RemarkVC.h"
#import "OrderTwoVC.h"
#import "PayViewController.h"
#import "AFClient.h"
#import "NewModel.h"
#import "OrderTwoVC.h"
#import "EditVC.h"
#import "CallOrderOneVC.h"
#import "kantuViewController.h"

#define kCellName @"OrderTwoDetailCell"

@interface OrderTwoDetailVC ()<AddressDelegate,RemarkDelegate,UITableViewDelegate,TwoHeiDelegate,UITextViewDelegate,UITextFieldDelegate>{
    OrderTwoDetailCell *_cell;
    NSMutableDictionary *dataDict;
    NSMutableArray *selfArr;
    NSInteger lpdt042;
    NSInteger lpdt043;
    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
    UIImageView *_imageview;
    UIButton *_button;
    
    NSMutableArray *chongArr;
    NSMutableArray *_images;
    NSMutableArray *_array;

    NSInteger _viewTag ;
    NSMutableArray *posImgArr;
    NSMutableArray *getArr;
    NSString *typeStr;
    NSInteger num;
    NSString *bthStr;

    NSString *isShan;
    NSMutableArray *uploadImages;
     NSString *isEnablePayment;
    NSInteger lpdt036;
    NSString *jsob001Str;
}


@end

@implementation OrderTwoDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];

     isEnablePayment = [[NSUserDefaults standardUserDefaults] valueForKey:@"isEnablePayment"];
    dataDict = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray new];
    _array = [NSMutableArray new];
    _imageview = [UIImageView new];
    posImgArr = [NSMutableArray new];
    getArr = [NSMutableArray new];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];;
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    
    self.bigTableVIew.showsVerticalScrollIndicator = NO;
    self.bigTableVIew.separatorStyle = UITableViewCellSelectionStyleNone;
      self.jiImgView.hidden = YES;
    
    self.bigTableVIew.showsVerticalScrollIndicator = NO;
    self.bigTableVIew.separatorStyle = UITableViewCellSelectionStyleNone;
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    self.oneMoreBth.layer.cornerRadius = 15.f;
    self.oneMoreBth.layer.borderWidth = 1.f;
    self.oneMoreBth.layer.borderColor = kTabBarColor.CGColor;
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.bianjiBth.layer.borderWidth = 1.f;
    self.bianjiBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.sumbitBth.layer.cornerRadius = 15.f;
    self.sumbitBth.layer.borderWidth = 1.f;
    self.sumbitBth.layer.borderColor = kTabBarColor.CGColor;

    [self Progress];
    [self setBottomView];
    [self first];

    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}
- (void)isIphoneX {
    if (kiPhoneX) {
        
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftImg.frame = CGRectMake(15, 51, 22, 19);
        
        
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
      
        
    }
}
-(void)setBottomView {
    CGFloat oneWidth = self.deletBth.frame.size.width;
    CGFloat margin = CGRectGetMinX(self.sumbitBth.frame) -CGRectGetMaxX(self.bianjiBth.frame);
    NSInteger countNum = 4;
    if (self.orderModel.isDisplayCommitButton  || self.orderModel.isDisplayPayBillButton) {
        self.sumbitBth.hidden = NO;
        if (self.orderModel.isDisplayCommitButton) {
            [self.sumbitBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
            [self.sumbitBth setBackgroundColor:[UIColor whiteColor]];
            [self.sumbitBth setTitle:@"提交" forState:UIControlStateNormal];
        }else if (self.orderModel.isDisplayPayBillButton){
            [self.sumbitBth setBackgroundColor:kTabBarColor];
            [self.sumbitBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.sumbitBth setTitle:@"支付" forState:UIControlStateNormal];
        }
    }else{
        self.sumbitBth.hidden = YES;
        countNum = countNum - 1;
    }
    
    
    CGFloat marginOne = CGRectGetMinX(self.sumbitBth.frame)-CGRectGetMaxX(self.bianjiBth.frame);
    CGFloat widthOne = CGRectGetWidth(self.sumbitBth.frame);
    if (self.orderModel.isDisplayDeleteButton) {
    
        self.deletBth.hidden = NO;
        
        
    }else{
        
        self.deletBth.hidden = YES;
        countNum = countNum - 1;
        
    }
    if (self.orderModel.isDisplayEditButton) {
        self.bianjiBth.hidden = NO;
        [self.sumbitBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
        [self.sumbitBth setBackgroundColor:[UIColor whiteColor]];
    }else {
        self.bianjiBth.hidden = YES;
        countNum = countNum - 1;
        
    }
    if (self.orderModel.billState == 0) {
        self.oneMoreBth.hidden = YES;
    }else{
        self.oneMoreBth.hidden = NO;
    }
    self.oneMoreBth.frame = CGRectMake(kScreenSize.width-15 - (oneWidth + margin)*countNum , 10, widthOne, 30);
    if (self.orderModel.isDisplayEditButton || self.orderModel.isDisplayDeleteButton || self.orderModel.isDisplayCommitButton || self.orderModel.isDisplayPayBillButton) {
        
    }else{
        if (self.orderModel.billState == 0) {
           
        }else {
            [self.oneMoreBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.oneMoreBth setBackgroundColor:kTabBarColor];
           
        }
        
    }
    
    if (self.tag == 304) {
        
    }else if (self.tag == 305){
        self.sumbitBth.hidden = YES;
        self.deletBth.hidden = YES;
        self.bianjiBth.hidden = YES;
        self.oneMoreBth.frame = self.sumbitBth.frame;
        self.oneMoreBth.backgroundColor = kTabBarColor;
        [self.oneMoreBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if (self.tag == 301){
        self.sumbitBth.hidden = YES;
        self.oneMoreBth.hidden = YES;
        self.bianjiBth.hidden = YES;
        self.deletBth.frame = self.sumbitBth.frame;
        self.deletBth.backgroundColor = kTabBarColor;
        [self.deletBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    }else if (self.tag == 302){
        self.sumbitBth.hidden = YES;
        self.oneMoreBth.hidden = YES;
        self.deletBth.hidden = YES;
        self.bianjiBth.frame = self.sumbitBth.frame;
        self.bianjiBth.backgroundColor = kTabBarColor;
        [self.bianjiBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
    }else if (self.tag == 303){
        self.bianjiBth.hidden = YES;
        self.oneMoreBth.hidden = YES;
        self.deletBth.hidden = YES;
        self.sumbitBth.backgroundColor = kTabBarColor;
        [self.sumbitBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
       
        
    }
}
#pragma mark --- 点击事件
- (IBAction)bottomClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 302) {
        if (self.orderModel.isNeedDeleteConfirmation == true) {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"是否删除此订单？" preferredStyle:UIAlertControllerStyleAlert ];
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
            }];
            [alertController addAction:cancelAction];
            UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                [postOneArr removeAllObjects];
                [self delet:self.orderModel.k1mf100];
                
            }];
            [alertController addAction:confirmAction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }else {
            [self delet:self.orderModel.k1mf100];
        }
        
    }else if(sender.tag == 304) {
        
        if (self.orderModel.billState == 10 || self.orderModel.billState == 30 || self.orderModel.billState == 40) {
            PayViewController *payVC = [storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
            payVC.k1mf100 = self.orderModel.k1mf100;
            NSDecimalNumber *sumPrice = [self.orderModel.k1mf302 decimalNumberByAdding:self.orderModel.k1mf301];
            payVC.sumPrice =sumPrice;
            [self.navigationController pushViewController:payVC animated:YES];
        }else{
            //提交
             [self tijiaoClient];
            
            
        }
        
    }else if (sender.tag == 303) {
        
        EditVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
        editVC.idStr = self.orderModel.k1mf100;
        editVC.dict = self.myDict;
        editVC.countStr = [NSString stringWithFormat:@"%@",self.orderModel.k1mf303];
        [self.navigationController pushViewController:editVC animated:YES];
    }else if (sender.tag == 301) {
        CallOrderOneVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderOneVC"];
        editVC.K1mf100 = self.orderModel.k1mf100;
        [self.navigationController pushViewController:editVC animated:YES];
    }
}
- (void)Progress {
    NSString *oneDateStr = [BGControl dateToDateStringTwo:_orderModel.k1mf997];
    NSArray *oneTimeArr = [oneDateStr componentsSeparatedByString:@" "];
    self.oneDateLab.text = oneTimeArr[0];
    self.oneTimeLab.text = oneTimeArr[1];
    self.oneImg.image = [UIImage imageNamed:@"greeQuan.png"];
    
    NSString *twoDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf600 ];
    if ([BGControl isNULLOfString:twoDateStr]) {
        self.twoImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.twoImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateArr = [twoDateStr componentsSeparatedByString:@" "];
        self.twoDateLab.text = dateArr[0];
        self.twoTimeLab.text = dateArr[1];
    }
    NSString *fourDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf007 ];
    if ([BGControl isNULLOfString:fourDateStr]) {
        self.fourImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.fourImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateArr = [fourDateStr componentsSeparatedByString:@" "];
        self.fourDateLab.text = dateArr[0];
        self.fourTimeLab.text = dateArr[1];
    }
    NSDictionary *otherBillStateDict = _orderModel.otherBillState;
    NSString *threeDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s20" ]];
     NSString *fiveDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s40" ]];
     NSString *sixDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s60" ]];
     NSString *sevenDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s90" ]];
    
    if ([BGControl isNULLOfString:fiveDateStr]) {
        self.fiveImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.fiveImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateoneArr = [fiveDateStr componentsSeparatedByString:@" "];
        self.fiveDateLab.text = dateoneArr[0];
        self.fiveTimeLab.text = dateoneArr[1];
    }
    if ([BGControl isNULLOfString:threeDateStr]) {
        self.threeImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.threeImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateoneArr = [threeDateStr componentsSeparatedByString:@" "];
        self.threeDateLab.text = dateoneArr[0];
        self.threeTimeLab.text = dateoneArr[1];
    }
    
    if ([BGControl isNULLOfString:sixDateStr]) {
        self.sixImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.sixImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateoneArr = [sixDateStr componentsSeparatedByString:@" "];
        self.sixDateLab.text = dateoneArr[0];
        self.sixTimeLab.text = dateoneArr[1];
    }
    if ([BGControl isNULLOfString:sevenDateStr]) {
        self.sevenImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.sevenImg.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateoneArr = [sevenDateStr componentsSeparatedByString:@" "];
        self.sevenDateLab.text = dateoneArr[0];
        self.sevenTimeLab.text = dateoneArr[1];
    }
}
-(void)first {
    [self show];
    [[AFClient shareInstance] WBP3008Preview:self.idStr withArr:postOneArr withUrl:@"App/Wbp3001/preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                dataDict = [responseBody valueForKey:@"data"];
                jsob001Str = [[responseBody valueForKey:@"data"] valueForKey:@"jsob001"];
                NSArray *dataArr = [dataDict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        NewModel *model  = [NewModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt102"]]];
                        NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                        if (compar == NSOrderedDescending) {
                            [model setValuesForKeysWithDictionary:dictOne];
                            [self.dataArray addObject:model];
                            [postArr addObject:dictOne];
                        }
                        
                        
                        
                    }
                }
                [self.bigTableVIew setTableFooterView:self.footerView];
                [self.bigTableVIew reloadData];
                [self setdata];
  
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self first];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self first];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                }
                //添加取消到UIAlertController中
                
                [self presentViewController:alertController animated:YES completion:nil];
                

            }
                    }else {
                        
                        
            [self Alert:[responseBody valueForKey:@"errors"][0]];
                        [self.navigationController popViewControllerAnimated:YES];
        }
        
        
        [self dismiss];
    } failure:^(id errrorresponseBody) {
       // [self Alert:[errrorresponseBody valueForKey:@"errors"][0]];
        [self dismiss]; 
    }];
    
}

-(void)setdata {

    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPhone= false;
    BOOL isPrice = false;
    BOOL isName = false;
    BOOL isAddress = false;
    BOOL isPei = false;
    BOOL isyun = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1DT201"]) {
            isPrice = true;
        }
        if ([visiableFieldsStr isEqualToString:@"K1MF201"]) {
            isPei = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF113"]) {
            isName = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF104"]) {
            isAddress = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF112"]) {
            isPhone = true;
        }
        if ([visiableFieldsStr isEqualToString:@"K1MF301"]) {
            isyun = true;
        }
    }
    
    /*判断姓名 电话、地址、配送方式是否显示*/
    CGFloat maxHei = 0;
    CGFloat oneHei = 0;
    oneHei = CGRectGetHeight(self.topViewOne.frame);
    int num = 0;
    if (!isName) {
        num ++;
        self.nameView.hidden = YES;
    }
    
//    if (!isPhone) {
//        num++;
//        self.phoneView.hidden = YES;
//    }else{
//
//        self.phoneView.frame = CGRectMake(0,250-num*50, kScreenSize.width, 50);
//    }
    if (!isAddress) {
        num++;
        self.addressView.hidden = YES;
    }else{
        self.addressView.frame = CGRectMake(0, 230-num*50, kScreenSize.width, 50);
    }
    self.topViewOne.frame = CGRectMake(0, 295-50*num, kScreenSize.width, 310);
    if (!isPei) {
        num  = num + 1;
        self.peiView.hidden = YES;
        self.beiView.frame = CGRectMake(0, 165-50, kScreenSize.width, 50);
        self.zhuanView.frame = CGRectMake(0, 230-50, kScreenSize.width, 80);
        self.topViewOne.frame = CGRectMake(0, 295-50*(num - 1), kScreenSize.width, 260);
        oneHei = oneHei-50;
    }
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 617-50*num);
    
    
  
    uploadImages = [NSMutableArray array];
    uploadImages = [dataDict valueForKey:@"uploadImages"];
    if (uploadImages.count<1) {
        maxHei = CGRectGetHeight(self.topView.frame) - 80;
        self.topView.frame = CGRectMake(0, 0, kScreenSize.width, maxHei);
        [self.bigTableVIew setTableHeaderView:self.topView];
        self.zhuanView.hidden = YES;
        CGRect oneView = self.topViewOne.frame;
        CGFloat hei = oneView.size.height;
        oneView.size.height = hei -80;
        [self.topViewOne setFrame:oneView];
        oneHei = oneHei - 0;
    }else{
        maxHei = CGRectGetHeight(self.topView.frame);
        self.topView.frame = CGRectMake(0, 0, kScreenSize.width, maxHei);
        [self.bigTableVIew setTableHeaderView:self.topView];
        self.zhuanView.hidden = NO;
        CGRect oneView = self.topViewOne.frame;
        CGFloat hei = oneView.size.height;
        oneView.size.height = hei;
        oneHei = hei;
        [self.topViewOne setFrame:oneView];
    }

    NSDictionary *masterDict = [dataDict valueForKey:@"master"];
    self.nameFile.text = [NSString stringWithFormat:@"%@    %@",[masterDict valueForKey:@"k1mf113"],[masterDict valueForKey:@"k1mf112"]];
   
    self.addressFile.text = [masterDict valueForKey:@"k1mf104"];
    if (![BGControl isNULLOfString:[masterDict valueForKey:@"k1mf104"]]) {
        self.addressFile = [BGControl setLabelSpace:self.addressFile withValue:self.addressFile.text withFont:[UIFont systemFontOfSize:14]];
        CGFloat height = [BGControl getSpaceLabelHeight:self.addressFile.text withFont:[UIFont systemFontOfSize:14] withWidth:kScreenSize.width-30] +10;
        
        if (height<50) {
            self.addressFile.frame = CGRectMake(15, 0, kScreenSize.width-30, 50);
        }else{
            CGRect addressLadFrame = self.addressFile.frame;
            addressLadFrame.size.height = height;
            [self.addressFile setFrame:addressLadFrame];
            
            CGRect addressViewFrame = self.addressView.frame;
            addressViewFrame.size.height = height;
            [self.addressView setFrame:addressViewFrame];
            CGRect topOneFrame = self.topViewOne.frame;
            topOneFrame.origin.y = CGRectGetMaxY(self.addressView.frame) +15;
            [self.topViewOne setFrame:topOneFrame];
            self.topView.frame = CGRectMake(0, 0, kScreenSize.width, maxHei-50+height);
            [self.bigTableVIew setTableHeaderView:self.topView];
            
        }
 
    }
//    if (maxHei == 647) {
    
//        CGRect oneView = self.topViewOne.frame;
//        oneView.size.height = oneHei;
//        [self.topViewOne setFrame:oneView];
//    }else {
    CGRect oneView = self.topViewOne.frame;
    oneView.size.height = oneHei;
    if (uploadImages.count<1) {
         oneView.size.height = oneHei - 80;
    }
        [self.topViewOne setFrame:oneView];
    
//    }
    
    self.beizhuFile.text = [masterDict valueForKey:@"k1mf010"];

    if (![BGControl isNULLOfString:self.beizhuFile.text]) {
        self.beizhuFile = [BGControl setLabelSpace:self.beizhuFile withValue:self.beizhuFile.text withFont:[UIFont systemFontOfSize:14]];
        CGFloat heightone = [BGControl getSpaceLabelHeight:self.beizhuFile.text withFont:[UIFont systemFontOfSize:14] withWidth:kScreenSize.width-110] +10;
        
        if (heightone<50) {
            self.beizhuFile.frame = CGRectMake(95, 0, kScreenSize.width-110, 50);
        }else{
            CGRect beizhuFile = self.beizhuFile.frame;
            beizhuFile.size.height = heightone;
            [self.beizhuFile setFrame:beizhuFile];
            
            CGRect beizhuTitleFrame = self.beiTitle.frame;
            beizhuTitleFrame.size.height = heightone;
            [self.beiTitle setFrame:beizhuTitleFrame];
            CGRect beiViewFrame = self.beiView.frame;
            beiViewFrame.size.height = heightone;
            [self.beiView setFrame:beiViewFrame];
            CGRect zhuanFrame = self.zhuanView.frame;
            zhuanFrame.origin.y = CGRectGetMaxY(self.beiView.frame)+15;
            [self.zhuanView setFrame:zhuanFrame];
            CGRect topOneFrame = self.topView.frame;
            topOneFrame.size.height = oneHei-50+heightone;
            
            self.topView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetHeight(self.topView.frame)-50+heightone);
            [self.bigTableVIew setTableHeaderView:self.topView];
            CGRect oneView = self.topViewOne.frame;
            oneView.size.height = oneHei-50+heightone;
            [self.topViewOne setFrame:oneView];
            
            
            
        }

    }
//    self.topView.backgroundColor = kTabBarColor;
    self.jiaoDateFile.text = [BGControl dateToDateString:[masterDict valueForKey:@"k1mf003"]];
    self.peiDateFile.text = [BGControl dateToDateString:[masterDict valueForKey:@"k1mf004"]];
    int peiType = [[masterDict valueForKey:@"k1mf201"] intValue];
    if (peiType == 0) {
        self.peiType.text = @"自提";
    }else if (peiType == 1) {
        self.peiType.text = @"货运";
    }
    
    NSString *orderCountStr = [NSString stringWithFormat:@"%@",[BGControl notRounding:[masterDict valueForKey:@"k1mf303"] afterPoint:lpdt036]];
    self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",orderCountStr,@"件商品"];
    
    self.yunLab.text = [NSString stringWithFormat:@"%@%@",@"运费: ￥", [BGControl notRounding:[masterDict valueForKey:@"k1mf301"] afterPoint:lpdt043]];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.yunLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,pricelenght-5)];
    self.yunLab.attributedText = priceStr;
    NSString *zongpriceStr = [BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043];
    
    NSDecimalNumber *yunDec = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[masterDict valueForKey:@"k1mf301"] afterPoint:lpdt043]];
    NSString *zongji = [BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:zongpriceStr] decimalNumberByAdding:yunDec] afterPoint:lpdt043];
    if (![[NSString stringWithFormat:@"%@",[[NSDecimalNumber decimalNumberWithString:zongpriceStr] decimalNumberByAdding:yunDec]] isEqualToString:@"0"]) {
        self.zongjiLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ￥",zongji ];
        NSMutableAttributedString *zongStr = [[NSMutableAttributedString alloc] initWithString:self.zongjiLab.text];
        NSInteger zonglenght = zongStr.length;
        [zongStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
        [zongStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,zonglenght-5)];
        self.zongjiLab.attributedText = zongStr;
        
        self.zongLab.text = [NSString stringWithFormat:@"%@%@",@"合计: ￥", zongpriceStr];
        NSMutableAttributedString *buyStr = [[NSMutableAttributedString alloc] initWithString:self.zongLab.text];
        NSInteger buylenght = buyStr.length;
        [buyStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 4)];
        [buyStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,buylenght-5)];
        self.zongLab.attributedText = buyStr;
    }else{
       self.zongjiLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ",@"" ];
        self.zongLab.text = [NSString stringWithFormat:@"%@%@",@"合计: ", @""];
    }
    
    
   
   
    self.idLab.text = [masterDict valueForKey:@"k1mf100"];
    self.xiadanName.text = [masterDict valueForKey:@"k1mf996"];
    self.storeName.text = [masterDict valueForKey:@"k1mf011"];
    self.storeId.text = [masterDict valueForKey:@"k1mf001"];
//    NSString  *isji = [[masterDict valueForKey:@"k1mf006"] stringValue];
   
    
    if (self.isji==true) {
        self.jiImgView.hidden = NO;
    }else {
        self.jiImgView.hidden = YES;
    }
    
   
    
        UIView *BJView = [[UIView alloc] init];
        BJView.tag = 500;
//            BJView.backgroundColor = [UIColor redColor];
        CGRect workingFrame = CGRectMake(self.view.center.x-30, self.view.center.y-30, 60, 60);
        workingFrame.origin.x = 0;
        workingFrame.origin.y = 10;
        CGFloat maxWidth = 0;
        if (uploadImages.count >0) {
            
            
            for (int i = 0; i<uploadImages.count; i++) {
//                UIImage *image = _images[i];
                _imageview = [[UIImageView alloc] init];
                NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
                 [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"FileCenter/StoreAttachment/ExportXsmall",@"pict001=",[uploadImages[i] valueForKey:@"pict001"],@"imageSize=",30]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
                NSLog(@"%@", [NSString stringWithFormat:@"%@?%@%@",@"https://fc.winton.com.cn/FileCenter/StoreAttachment/ExportMedium",@"pict001=",[uploadImages[i] valueForKey:@"systemFileName"]]);
                _imageview.tag = 200+i;
                            _imageview.backgroundColor = kTextGrayColor;
                _imageview.contentMode = UIViewContentModeScaleAspectFill;
                _imageview.autoresizingMask = UIViewAutoresizingNone;
                _imageview.clipsToBounds = YES;
                _imageview.frame = workingFrame;
                _button = [BGControl creatButtonWithFrame:_imageview.frame target:self sel:@selector(deletImg:) tag:100+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
                [BJView addSubview:_imageview];
                [BJView addSubview:_button];
                [self.bigScrollView setPagingEnabled:YES];
                
                workingFrame.origin.x = workingFrame.origin.x + 5 + workingFrame.size.width;
                
                
            }
            maxWidth = workingFrame.origin.x + 5 ;
            [self.bigScrollView setContentSize:CGSizeMake(uploadImages.count*60+(uploadImages.count-1)*5 +65, workingFrame.size.height)];
            BJView.frame = CGRectMake(0, 0, uploadImages.count*60+(uploadImages.count-1)*5, 80);
        }
     
       
    
        [self.bigScrollView addSubview:BJView];
/*判断金额是否显示*/
    NSInteger priceNum = 0;
    if (!isPrice) {
        priceNum++;
        self.zongLab.hidden = YES;
        self.allPriceView.hidden = YES;
       
        
    }
    if (!isyun) {
        priceNum ++;
        self.yunView.hidden = YES;
        
    }
    CGRect bottomFrame = self.footerView.frame;
    bottomFrame.size.height = 380 - priceNum*50;
    [self.footerView setFrame:bottomFrame];
    self.xiadanView.frame = CGRectMake(0, 165-priceNum*50, kScreenSize.width, 50);
    self.menNameView.frame = CGRectMake(0, 215-priceNum*50, kScreenSize.width, 50);
    self.menNumView.frame = CGRectMake(0, 265-priceNum*50, kScreenSize.width, 100);
    [self.bigTableVIew setTableFooterView:self.footerView];
    
}

- (void)deletImg:(UIButton *)button {
    _viewTag = button.tag - 100;
    
    _array =  [NSMutableArray arrayWithArray:uploadImages];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    kantuViewController *picVC = [storyboard instantiateViewControllerWithIdentifier:@"kantuViewController"];
    picVC.IMGArray = _array;
   picVC.typestr = @"kan";
    picVC.IMGNum = [NSString stringWithFormat:@"%d",_viewTag];
    [self.navigationController pushViewController:picVC animated:YES];
    
   }


- (IBAction)buttonClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 201) {
        
        if ([self.fanStr isEqualToString:@"OrderTwoVC"]) {
          [self.navigationController popViewControllerAnimated:YES];
        }else {
  
            OrderTwoVC *order = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
            [self.navigationController pushViewController:order animated:YES];
        }
        
    }else if (sender.tag == 204) {
        NSArray *dataArr = [dataDict valueForKey:@"groupDetail"];
        if (dataArr.count > 0) {
            [self create];
        }

        
      
    }else if (sender.tag == 203) {
        EditVC *editVC = [storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
        editVC.idStr = self.idStr;
        editVC.countStr = self.sumLab.text;
         NSArray *dataArr = [dataDict valueForKey:@"groupDetail"];
        if (dataArr.count > 0) {
             [self.navigationController pushViewController:editVC animated:YES];
        }
       
        
    }

}

-(void)create {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSNumber *num = [NSNumber numberWithBool:YES];
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDict valueForKey:@"master"],@"master", num,@"isConfirmed",postArr,@"detail",[dataDict valueForKey:@"uploadImages"],@"uploadImages",nil];
    
    
    [postMast setObject:[dataDict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    [postMast setObject:[dataDict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    if (![BGControl isNULLOfString:jsob001Str]) {
        [postMast setObject:jsob001Str forKey:@"jsob001"];
    }
    [self show];
    [[AFClient shareInstance] Create:postMast withArr:postOneArr withUrl:@"App/Wbp3001/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                OrderTwoVC *payVC = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                [self.navigationController pushViewController:payVC animated:YES];
                
            
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self create];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self create];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                }
                //添加取消到UIAlertController中
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            
        }else {
            [self Alert:[responseBody valueForKey:@"errors"][0]];
        }
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[OrderTwoDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    _cell.delegate = self;
    NewModel *model = self.dataArray[indexPath.section];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    [_cell showModel:model withDict:dataDict withIndex:indexPath.section];
    return _cell;
    
    
}
-(void)getHei:(CGFloat)maxHei withIndex:(NSInteger)index {
    
    NewModel *model = self.dataArray[index];
    model.bottomHei = maxHei;
    [self.dataArray replaceObjectAtIndex:index withObject:model];
}


//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    NewModel *model = self.dataArray[indexPath.section];
    if (model.bottomHei == 0) {
        return 80;
    }else{
        return model.bottomHei ;
    }

    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
}
#pragma mark -- 删除
-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3001/Destroy" progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:@"删除成功"];
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [self dismiss];
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postOneArr removeAllObjects];
                        [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self delet:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self delet:idStr];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                }
                //添加取消到UIAlertController中
                
                [self presentViewController:alertController animated:YES completion:nil];
            }
        }else {
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
            [self.navigationController popViewControllerAnimated:YES];
            [self dismiss];
            
        }
    } failure:^(NSError *error) {
        [self Alert:@"删除失败!"];
        [self dismiss];
    }];
    
    
}


-(void)tijiaoClient{
  
   
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self show];
    NSNumber *num2 = [NSNumber numberWithBool:YES];
    
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDict valueForKey:@"master"],@"master", num2,@"isConfirmed",postArr,@"detail",[dataDict valueForKey:@"uploadImages"],@"uploadImages",nil];
    [postMast setObject:[dataDict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    [postMast setObject:[dataDict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
   
        [[AFClient shareInstance] Create:postMast withArr:postOneArr withUrl:@"App/Wbp3001/UpdateAndConfirm" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            [self dismiss];
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                    if ([isEnablePayment isEqualToString:@"1"]) {
                        PayViewController *payVC = [storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
                        payVC.fanStr = @"OrderDetailVC";
                        NSDictionary *paymentDict = [[responseBody valueForKey:@"data"] valueForKey:@"data"];
                        payVC.k1mf100 = [paymentDict valueForKey:@"k1mf100"];
                        payVC.sumPrice = [paymentDict valueForKey:@"payment"];
                        [self.navigationController pushViewController:payVC animated:YES];
                    }else {
                        OrderTwoVC *orderDetailTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                        
                        [self.navigationController pushViewController:orderDetailTwo animated:YES];
                    }
                    
                    
                    
                }else{
                    [self dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                    if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        }];
                        [alertController addAction:cancelAction];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                            [self tijiaoClient];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self tijiaoClient];
                                
                                ;
                            }];
                            [alertController addAction:home1Action];
                        }
                        //取消style:UIAlertActionStyleDefault
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                    }
                    //添加取消到UIAlertController中
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                
            }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        } failure:^(id erroresponseBody) {
            NSString *str = [erroresponseBody valueForKey:@"errors"][0];
            [self Alert:str];
            [self dismiss];
        }];
        
    }



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
