//
//  ProcurementOrderDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProcurementOrderDetailVC.h"
#import "ProcurementOrderDetailCell.h"
#import "AddProcurementModel.h"
#import "ProcurementOrderOnePagVC.h"
#import "RemarkVC.h"
#import "ProcurementOrderVC.h"
#import "AFClient.h"
#import "BGControl.h"
#import "AddPSOnePageVC.h"
#import "EmailViewController.h"
#define kCellName @"ProcurementOrderDetailCell"
@interface ProcurementOrderDetailVC ()<RemarkDelegate,UITableViewDelegate,UIAlertViewDelegate>{
    ProcurementOrderDetailCell *_cell;
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
    NSString *k1mf100Str;
    NSString *isShan;
    NSMutableArray *uploadImages;

}


@end

@implementation ProcurementOrderDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IsIphoneX];
    [self Progress];
    dataDict = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray new];
    _array = [NSMutableArray new];
    _imageview = [UIImageView new];
    posImgArr = [NSMutableArray new];
    getArr = [NSMutableArray new];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
//    self.bigTableVIew.frame = CGRectMake(0, 60, kScreenSize.width, kScreenSize.height-110);
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt043"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt042"] ] integerValue];
    //self.bigTableVIew.showsVerticalScrollIndicator = NO;
    self.bigTableVIew.separatorStyle = UITableViewCellSelectionStyleNone;
    self.caigouDateFile.enabled = NO;
    self.yujiaoDateFile.enabled = NO;
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
 
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.bianjiBth.layer.borderWidth = 1.f;
    self.bianjiBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.sumbitBth.layer.cornerRadius = 15.f;
    self.sumbitBth.layer.borderWidth = 1.f;
    self.sumbitBth.layer.borderColor = kTabBarColor.CGColor;
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 405);

 
    [self.bigTableVIew setTableHeaderView:self.topView];
    [self.bigTableVIew setTableFooterView:self.footerView];

    if (self.billState == 0) {
          self.bottomView.hidden = NO;
        [self.sumbitBth setTitle:@"提交" forState:UIControlStateNormal];
    }else if (self.billState == 10) {
          self.bottomView.hidden = NO;
         [self.deletBth setTitle:@"发送邮件" forState:UIControlStateNormal];
         [self.bianjiBth setTitle:@"编辑" forState:UIControlStateNormal];
        [self.sumbitBth setTitle:@"转出" forState:UIControlStateNormal];
    }else if (self.billState == 30 || self.billState == 40) {
        self.bottomView.hidden = NO;
        [self.deletBth setTitle:@"发送邮件" forState:UIControlStateNormal];
        [self.bianjiBth setTitle:@"转出" forState:UIControlStateNormal];
        [self.sumbitBth setTitle:@"结案" forState:UIControlStateNormal];
        
    }
    else if (self.billState == 50){
        [self.bianjiBth setTitle:@"转出" forState:UIControlStateNormal];
        [self.sumbitBth setTitle:@"结案" forState:UIControlStateNormal];
        self.deletBth.hidden = YES;
         self.bottomView.hidden = NO;
        
    }else{
        self.bottomView.hidden = YES;
        self.bigTableVIew.frame= CGRectMake(0, 60, kScreenSize.width, kScreenSize.height-60);
    }
    
    if (self.tagNum == 301) {
        self.sumbitBth.hidden = YES;
        self.bianjiBth.hidden = YES;
        self.deletBth.frame = self.sumbitBth.frame;
    }else if (self.tagNum == 302) {
        self.sumbitBth.hidden = YES;
        self.deletBth.hidden = YES;
        self.bianjiBth.frame = self.sumbitBth.frame;
    }else if (self.tagNum ==303){
        self.deletBth.hidden = YES;
        self.bianjiBth.hidden = YES;
    }
     [self setView];
     [self first];
}
- (void)IsIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.bigTableVIew.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight-50);
       
        self.leftImg.frame = CGRectMake(15, 49, 22, 19);
        
        
        
    }
}
- (void)Progress {
    NSString *oneDateStr = [BGControl dateToDateStringTwo:_orderModel.k1mf997];
    NSArray *oneTimeArr = [oneDateStr componentsSeparatedByString:@" "];
    self.oneDateLab.text = oneTimeArr[0];
    self.oneTimeLab.text = oneTimeArr[1];
    self.oneImg.image = [UIImage imageNamed:@"blue.png"];
    
    NSString *twoDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf600 ];
    if ([BGControl isNULLOfString:twoDateStr]) {
        self.twoImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.twoImg.image = [UIImage imageNamed:@"blue.png"];
        NSArray *dateArr = [twoDateStr componentsSeparatedByString:@" "];
        self.twoDateLab.text = dateArr[0];
        self.twoTimeLab.text = dateArr[1];
    }
    NSString *threeDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf007 ];
    if ([BGControl isNULLOfString:threeDateStr]) {
        self.threeImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.threeImg.image = [UIImage imageNamed:@"blue.png"];
        NSArray *dateArr = [threeDateStr componentsSeparatedByString:@" "];
        self.threeDateLab.text = dateArr[0];
        self.threeTimeLab.text = dateArr[1];
    }
    NSDictionary *otherBillStateDict = _orderModel.otherBillState;
    NSString *fourDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s40" ]];
    NSString *fiveDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s50" ]];
    NSString *sixDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s90" ]];

    
    if ([BGControl isNULLOfString:fiveDateStr]) {
        self.fiveImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.fiveImg.image = [UIImage imageNamed:@"blue.png"];
        NSArray *dateArr = [fiveDateStr componentsSeparatedByString:@" "];
        self.fiveDateLab.text = dateArr[0];
        self.fiveTimeLab.text = dateArr[1];
    }
    if ([BGControl isNULLOfString:fourDateStr]) {
        self.fourImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.fourImg.image = [UIImage imageNamed:@"blue.png"];
        NSArray *dateArr = [fourDateStr componentsSeparatedByString:@" "];
        self.fourDateLab.text = dateArr[0];
        self.fourTimeLab.text = dateArr[1];
    }
    
    if ([BGControl isNULLOfString:sixDateStr]) {
        self.sixImg.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.sixImg.image = [UIImage imageNamed:@"blue.png"];
        NSArray *dateArr = [sixDateStr componentsSeparatedByString:@" "];
        self.sixDateLab.text = dateArr[0];
        self.sixTimeLab.text = dateArr[1];
    }
   
}
- (void)setView {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
     BOOL isPrice = false;
     BOOL isyun = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF301"]) {
            isyun = true;
        }
    }
    NSInteger priceNum = 0;
    if (!isPrice) {
        
        priceNum++;
        self.sumLab.hidden = YES;
        self.sumOneView.hidden = YES;
      
        
    }
    if (!isyun) {
        priceNum ++;
        self.yunView.hidden = YES;
        
        
        
    }
//    CGRect bottomFrame = self.bottomView.frame;
//    bottomFrame.size.height = 315 - priceNum*50;
//    [self.bottomView setFrame:bottomFrame];
    self.sumOneView.frame = CGRectMake(0, 100-priceNum*50, kScreenSize.width, 50);
    self.orderIdView.frame = CGRectMake(0, 165-priceNum*50, kScreenSize.width, 50);
    self.menshiNameView.frame = CGRectMake(0, 215-priceNum*50, kScreenSize.width, 50);
    self.orderNumView.frame = CGRectMake(0, 265-priceNum*50, kScreenSize.width, 50);
//    [self.bigTableVIew setTableFooterView:self.bottomView];
}
-(void)first {
    [self show];
    [[AFClient shareInstance] WBP3008Preview:self.idStr withArr:postOneArr withUrl:@"App/Wbp3022/Preview" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self.dataArray removeAllObjects];
                [postArr removeAllObjects];
                dataDict = [responseBody valueForKey:@"data"];
                NSArray *dataArr = [dataDict valueForKey:@"groupDetail"];
                for (int i = 0; i<dataArr.count; i++) {
                    
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    
                    for (int j = 0; j<dictDetail.count; j++) {
                        AddProcurementModel *model  = [AddProcurementModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt101"]]];
                        NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                        NSDecimalNumber *k1dt110Count = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt110"]]];
                        NSComparisonResult k1dt110compar = [k1dt110Count compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                        if (compar == NSOrderedDescending || k1dt110compar == NSOrderedDescending) {
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
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
}
-(void)setdata {
    
    
    CGFloat maxHei;
    CGFloat oneHei;
    uploadImages = [NSMutableArray array];
       NSDictionary *masterDict = [dataDict valueForKey:@"master"];
    self.titleName.text = @"采购商品";
    
    self.beizhuLab.text = [masterDict valueForKey:@"k1mf010"];
    
    if (![BGControl isNULLOfString:self.beizhuLab.text]) {
        self.beizhuLab = [BGControl setLabelSpace:self.beizhuLab withValue:self.beizhuLab.text withFont:[UIFont systemFontOfSize:14]];
        CGFloat heightone = [BGControl getSpaceLabelHeight:self.beizhuLab.text withFont:[UIFont systemFontOfSize:14] withWidth:kScreenSize.width-110] +10;
        
        if (heightone<50) {
            self.beizhuLab.frame = CGRectMake(95, 0, kScreenSize.width-110, 50);
        }else{
            CGRect beizhuFile = self.beizhuLab.frame;
            beizhuFile.size.height = heightone;
            [self.beizhuLab setFrame:beizhuFile];
            
            CGRect beizhuTitleFrame = self.beiTitle.frame;
            beizhuTitleFrame.size.height = heightone;
            [self.beiTitle setFrame:beizhuTitleFrame];
            CGRect beiViewFrame = self.beiView.frame;
            beiViewFrame.size.height = heightone;
            [self.beiView setFrame:beiViewFrame];
           
            self.topView.frame = CGRectMake(0, 0, kScreenSize.width,130+heightone);
            [self.bigTableVIew setTableHeaderView:self.topView];
            CGRect oneView = self.topViewOne.frame;
            oneView.size.height = oneHei-50+heightone;
            [self.topViewOne setFrame:oneView];
            
            
            
        }
        
    }
    
    NSArray *time = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf003"]] componentsSeparatedByString:@" "];
    self.caigouDateFile.text = time[0];
    NSArray *timeOne = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf004"]] componentsSeparatedByString:@" "];
    self.yujiaoDateFile.text = timeOne[0];
    //    self.topView.backgroundColor = kTabBarColor;
   
    NSString *orderCountStr = [NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf303"]];
    self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",orderCountStr,@"件商品"];
 
    NSString *zongpriceStr = [BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043];
    
    if (![[NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
        self.zongjiLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ￥",zongpriceStr ];
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
          self.zongjiLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ",@"--"];
         self.zongLab.text = [NSString stringWithFormat:@"%@%@",@"合计: ", @"--"];
    }
    
    
    self.idLab.text = [masterDict valueForKey:@"k1mf100"];
    self.xiadanName.text = [masterDict valueForKey:@"k1mf996"];
    self.storeName.text = [masterDict valueForKey:@"k1mf011"];
    self.storeId.text = [masterDict valueForKey:@"k1mf001"];
  
    
    
    
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[ProcurementOrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
   // _cell.delegate = self;
    AddProcurementModel *model = self.dataArray[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
   [_cell showModel:model];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
 
    return 100;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataArray.count;
    }

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
//    return self.footerView;
//}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClick:(UIButton *)sender {
 
 UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 202){
        if (self.billState == 0) {
            [self delet:self.idStr];
        }else {
            EmailViewController *emailVC = [storyboard instantiateViewControllerWithIdentifier:@"EmailViewController"];
            emailVC.idStr = self.idStr;
            [self.navigationController pushViewController:emailVC animated:YES];

        }
    }else if (sender.tag == 203){
        if (self.billState == 0||self.billState == 10) {
            ProcurementOrderVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
            orderVC.idStr = self.idStr;
            [self.navigationController pushViewController:orderVC animated:YES];
        }else {
             [self Divert:self.idStr];
//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否转出？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//            alert.alertViewStyle = UIAlertViewStyleDefault;
//            alert.tag = 201;
//            alert.delegate = self;
//            [alert show];
            
        }
    }else if (sender.tag == 204){
          if (self.billState == 0) {
        if (postArr.count > 0) {
            [self create];
        }
              
          }else if (self.billState == 10){
             [self Divert:self.idStr];
          }
          else {
              [self UpdateState];
          }
    }
}
- (void)UpdateState{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
  
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDict valueForKey:@"master"],@"master",postArr,@"detail",nil];
    
    
    // [postMast setObject:[dataDict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    // [postMast setObject:[dataDict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    [self show];
    [[AFClient shareInstance] UpdateState:postMast withArr:postOneArr withUrl:@"App/Wbp3022/UpdateState"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                [self Alert:@"结案成功"];
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
                        [self UpdateState];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self UpdateState];
                            
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
-(void)create {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSNumber *isConfirmed = [NSNumber numberWithBool:YES];
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:[dataDict valueForKey:@"master"],@"master", isConfirmed,@"isConfirmed",postArr,@"detail",[dataDict valueForKey:@"uploadImages"],@"uploadImages",nil];
    
    
   // [postMast setObject:[dataDict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
   // [postMast setObject:[dataDict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    [self show];
    [[AFClient shareInstance] Create:postMast withArr:postOneArr withUrl:@"App/Wbp3022/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                ProcurementOrderOnePagVC *payVC = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderOnePagVC"];
                [self dismiss];
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
/*转出*/
-(void)Divert:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Divert:idStr withArr:postOneArr withUrl:@"App/Wbp3022/Divert" progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:@"转出成功"];
                 k1mf100Str = [NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"] valueForKey:@"data"]];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"是否进入转出采购进货 ？" delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                alert.delegate = self;
                alert.tag = 202;
                [alert show];
                [self dismiss];
                
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
                        [self Divert:idStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                           [self Divert:idStr]
                            
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
           
            [self dismiss];
            
        }
    } failure:^(NSError *error) {
        [self Alert:@"转出失败!"];
        [self dismiss];
    }];
    
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
   
    if (buttonIndex == 1) {
        if (alertView.tag == 201) {
//            [self Divert:self.idStr];
        }else{
        [self GetResource];
        }
    }else{
        [self first];
    }
}

- (void)GetResource {
    [[AFClient shareInstance] GetResource:@"1" withArr:postArr withUrl:@"App/Wbp3023/GetResource" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
              NSDictionary  *dict = responseBody[@"data"];
               
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3023lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3023lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3023lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3023isDisplayUnitPrice"];
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
                AddPSOnePageVC *mainVC = [storyboard instantiateViewControllerWithIdentifier:@"AddPSOnePageVC"];
                mainVC.idStr = k1mf100Str;
                [self.navigationController pushViewController:mainVC animated:YES];
                
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue] == 1|| [[userResponseDict valueForKey:@"code"] intValue] == 4) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postArr removeAllObjects];
                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self GetResource];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]==2 ) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postArr removeAllObjects];
                            [postArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self GetResource];
                            
                            ;
                        }];
                        [alertController addAction:home1Action];
                    }
                    //取消style:UIAlertActionStyleDefault
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                }
                //添加取消到UIAlertController中
                
                [self presentViewController:alertController animated:YES completion:nil];
            } }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        
        [self dismiss];
        
        
    } failure:^(NSError *error) {
        [self Alert:@"请重试!"];
        [self dismiss];
    }];
}
-(void)delet:(NSString *)idStr {
    [self show];
    [[AFClient shareInstance] Destroy:idStr withArr:postOneArr withUrl:@"App/Wbp3022/Destroy" progressBlock:^(NSProgress *progress) {
        
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:@"删除成功"];
                 [self dismiss];
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
- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
   self.footerView.autoresizingMask = UIViewAutoresizingNone;
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
