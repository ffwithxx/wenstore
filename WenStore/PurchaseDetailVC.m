//
//  PurchaseDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PurchaseDetailVC.h"
#import "PurchaseDetailCell.h"
#import "BGControl.h"
#import "RemarkVC.h"
#import "AddPurchaseModel.h"
#import "AFClient.h"
#import "SZCalendarPicker.h"
#import "PurchaseOnePageVC.h"
#define kCellName @"PurchaseDetailCell"

@interface PurchaseDetailVC ()<UITableViewDelegate,UITableViewDataSource,RemarkDelegate> {
    NSInteger lpdt042;
    NSInteger lpdt043;
    NSInteger lpdt036;
    NSString *remarkStr;
    BOOL isConfirm;
    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
    NSDate *jinhuoDate;
    PurchaseDetailCell *_cell;
    NSMutableArray *uploadImagesArr;;
     NSMutableArray *oneArr;

}

@end

@implementation PurchaseDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    postOneArr = [[NSMutableArray alloc] init];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt042"] ] integerValue];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 180);
    [self.bigTableView setTableHeaderView:self.topView];
    self.footerView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
    [self.bigTableView setTableFooterView:self.footerView];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.dataArray = [NSMutableArray array];
    
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
        
    }
    
    if (!isPrice) {
        self.sumPriceLAB.hidden = YES;
    }else{
        self.sumPriceLAB.hidden = NO;
    }
    
    [self first];

}
- (void)isIphoneX {
    if (kiPhoneX) {
        if (kiPhoneX) {
            self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
            self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
            self.leftImg.frame = CGRectMake(15, 49, 22, 19);
            self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight-50);
        }
    }
}
- (void)first {
    NSDictionary *masterDict = [self.dataDict valueForKey:@"master"];
   
    jinhuoDate = [masterDict valueForKey:@"k1mf003"];
    NSArray *time = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf003"]] componentsSeparatedByString:@" "];
    self.caigouFiled.text = time[0];
    self.remarkTextField.text = [masterDict valueForKey:@"k1mf010"];
    
    NSString *countStr = [NSString stringWithFormat:@"%@",[BGControl notRounding:[masterDict valueForKey:@"k1mf303"] afterPoint:lpdt036]];
    NSString *priceStr = [NSString stringWithFormat:@"%@",[BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043]];
    self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已进货",countStr,@"件商品"];
    
    if (![[NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
        self.sumPriceLAB.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
        self.hejiPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    }else{
        self.sumPriceLAB.text = @"";
        self.hejiPriceLab.text = @"";
    }
    
      oneArr = [[NSMutableArray alloc] init];
     if ([self.typeStr isEqualToString:@"1"]) {
    oneArr = [self.dataDict valueForKey:@"detail"];
     }else{
        
         NSArray *dataArr = [self.dataDict valueForKey:@"groupDetail"];
         for (int i = 0; i<dataArr.count; i++) {
             
             NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
             
             for (int j = 0; j<dictDetail.count; j++) {
                 AddPurchaseModel *model  = [AddPurchaseModel new];
                 NSDictionary *dictOne = dictDetail[j];
                 
                 
                 [oneArr addObject:dictOne];
                 
                 
                 
             }
         }
     }
    NSDecimalNumber *priceNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i<oneArr.count; i++) {
        AddPurchaseModel *model = [AddPurchaseModel new];
        NSDictionary *dict = oneArr[i];
        if ([BGControl isNULLOfString:[dict valueForKey:@"k1dt102"]]) {
            model.k1dt102 = [NSDecimalNumber decimalNumberWithString:@"0"];
        }
        if ([BGControl isNULLOfString:[dict valueForKey:@"k1dt110"]]) {
            model.k1dt110 = [NSDecimalNumber decimalNumberWithString:@"0"];
        }
       
        [model setValuesForKeysWithDictionary:dict];
     //   NSDecimalNumber *one = [[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]]];
       // NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:one afterPoint:lpdt043]];
//        priceNum =[priceNum decimalNumberByAdding:two];
        
        [self.dataArray addObject:model];
        
    }
    [self.bigTableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[PurchaseDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    AddPurchaseModel *model = self.dataArray[indexPath.section];
    
  [_cell showWithModel:model];
    return _cell;
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NewModel *model = self.dataArray[indexPath.section];
    return 100;
    
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



- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
        
    }else if (sender.tag == 202){
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        calendarPicker.frame = CGRectMake(20, 0.15*self.view.frame.size.height, self.view.frame.size.width-40, 0.7*self.view.frame.size.height);
        calendarPicker.center = self.view.center;
        calendarPicker.clipsToBounds = YES;
        
        calendarPicker.layer.cornerRadius = 10.f;
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
            NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)day];
            NSString *monthStr = [NSString stringWithFormat:@"%ld",(long)month];;
            NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)year];;
            if (day < 10) {
                dayStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)day];
            }
            if (month < 10) {
                monthStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)month];
            }
            self.caigouFiled.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
           
            jinhuoDate = [BGControl stringToDate:self.caigouFiled.text];
            
        };
        
    }else if (sender.tag == 203){
        //配送备注
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RemarkVC *remark = [storyboard instantiateViewControllerWithIdentifier:@"RemarkVC"];
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
        
    }else if (sender.tag == 204){
        isConfirm = false;
        [self update];
    }else if (sender.tag == 205){
        isConfirm = true;
        [self update];
    }
    

}
-(void)update{
    NSMutableDictionary *masterDict = [self.dataDict valueForKey:@"master"];
    NSMutableDictionary *postMast = [[NSMutableDictionary alloc] init];
    [postMast setValue:[masterDict valueForKey:@"k1mf000"] forKey:@"k1mf000"];
    [postMast setValue:[masterDict valueForKey:@"k1mf001"] forKey:@"k1mf001"];
    [postMast setValue: self.caigouFiled.text forKey:@"k1mf003"];
    [postMast setValue:[masterDict valueForKey:@"k1mf005"] forKey:@"k1mf005"];
    [postMast setValue:[masterDict valueForKey:@"k1mf006"] forKey:@"k1mf006"];
    [postMast setValue:[masterDict valueForKey:@"k1mf008"] forKey:@"k1mf008"];
    [postMast setValue:remarkStr forKey:@"k1mf010"];
    [postMast setValue:[masterDict valueForKey:@"k1mf011"] forKey:@"k1mf011"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf100"] forKey:@"k1mf100"];
      [postMast setValue:[masterDict valueForKey:@"k1mf101"] forKey:@"k1mf101"];
    [postMast setValue:[masterDict valueForKey:@"k1mf108"] forKey:@"k1mf108"];
    [postMast setValue:[masterDict valueForKey:@"k1mf105"] forKey:@"k1mf105"];
    [postMast setValue:[masterDict valueForKey:@"k1mf106"] forKey:@"k1mf106"];
    [postMast setValue:[masterDict valueForKey:@"k1mf107"] forKey:@"k1mf107"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf116"] forKey:@"k1mf116"];
    [postMast setValue:[masterDict valueForKey:@"k1mf117"] forKey:@"k1mf117"];
    [postMast setValue:[masterDict valueForKey:@"k1mf118"] forKey:@"k1mf118"];
    [postMast setValue:[masterDict valueForKey:@"k1mf119"] forKey:@"k1mf119"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf302"] forKey:@"k1mf302"];
    [postMast setValue:[masterDict valueForKey:@"k1mf303"] forKey:@"k1mf303"];
    [postMast setValue:[masterDict valueForKey:@"k1mf304"] forKey:@"k1mf304"];
    [postMast setValue:[masterDict valueForKey:@"k1mf500"] forKey:@"k1mf500"];
    [postMast setValue:[masterDict valueForKey:@"k1mf600"] forKey:@"k1mf600"];
    [postMast setValue:[masterDict valueForKey:@"k1mf800"] forKey:@"k1mf800"];
     [postMast setValue:[masterDict valueForKey:@"K1mf996"] forKey:@"K1mf996"];
    [postMast setValue:[masterDict valueForKey:@"k1mf998"] forKey:@"k1mf998"];
    [postMast setValue:[masterDict valueForKey:@"k1mf999"] forKey:@"k1mf999"];
    
    NSMutableDictionary  *updateDict = [[NSMutableDictionary alloc] init];
    
    [updateDict setObject:postMast forKey:@"master"];
    
    
    [updateDict setObject:oneArr forKey:@"detail"];
    NSNumber *isconfirmNum = [NSNumber numberWithBool:isConfirm];
    [updateDict setObject:isconfirmNum forKey:@"isConfirm"];
    [self show];
    NSString *urlStr;
           if (isConfirm == true) {
            urlStr = @"App/Wbp3004/UpdateAndConfirm";
        }else {
            urlStr = @"App/Wbp3004/Update";
        }
        
   
    [[AFClient shareInstance] Update:updateDict withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
              PurchaseOnePageVC *callOrderThree = [storyboard instantiateViewControllerWithIdentifier:@"PurchaseOnePageVC"];
               [self.navigationController pushViewController:callOrderThree animated:YES];
                
                
                
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
                        [self update];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self update];
                            
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
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    
    
}


- (void)Alert:(NSString *)AlertStr{
      [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
}
-(void)RemarkStr:(NSString *)str {
    self.remarkTextField.text = str;
    remarkStr = str;
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
