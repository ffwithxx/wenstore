//
//  StocktakDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StocktakDetailVC.h"
#import "StocktakDetailCell.h"
#import "BGControl.h"
#import "RemarkVC.h"
#import "StocktakModel.h"
#import "SZCalendarPicker.h"
#import "AFClient.h"
#import "StocktakOnePageVC.h"
#define kCellName @"StocktakDetailCell"
@interface StocktakDetailVC ()<UITableViewDelegate,UITableViewDataSource,RemarkDelegate>{
    NSInteger lpdt042;
    NSInteger lpdt043;
    NSInteger lpdt036;
    NSString *remarkStr;
    BOOL isConfirm;
    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
     NSDate *moDate;
    StocktakDetailCell *_cell;
    NSMutableArray *uploadImagesArr;;
    NSMutableArray *oneArr;
}
@end

@implementation StocktakDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt042"] ] integerValue];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 130);
    [self.bigTableView setTableHeaderView:self.topView];
    self.bottomView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
    [self.bigTableView setTableFooterView:self.bottomView];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.dataArray = [NSMutableArray array];
    [self first];

   
    // Do any additional setup after loading the view.
}

- (void)first {
    NSDictionary *masterDict = [self.dataDict valueForKey:@"master"];
    self.dateTextFile.text = [BGControl changeNsdate:[NSDate date]];
    moDate = [NSDate date];
    self.remarkFile.text = [masterDict valueForKey:@"k1mf010"];
    NSString *countStr = [NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf303"]];
    self.sumCountNumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",countStr,@"件商品"];
   self.sumCountTwoLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",countStr,@"件商品"];
    oneArr = [[NSMutableArray alloc] init];
 
    if ([self.typeStr isEqualToString:@"2"]) {
        NSArray *dataArr = [self.dataDict valueForKey:@"groupDetail"];
        for (int i = 0; i<dataArr.count; i++) {
            
            NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
            
            for (int j = 0; j<dictDetail.count; j++) {
                StocktakModel *model  = [StocktakModel new];
                NSDictionary *dictOne = dictDetail[j];
                
                [oneArr addObject:dictOne];
                
            }
        }
    }else {
       oneArr = [self.dataDict valueForKey:@"detail"];
    }
    NSDecimalNumber *priceNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i<oneArr.count; i++) {
        StocktakModel *model = [StocktakModel new];
        NSDictionary *dict = oneArr[i];
        if ([BGControl isNULLOfString:[dict valueForKey:@"k1dt011n"]]) {
            model.k1dt011n = [NSDecimalNumber decimalNumberWithString:@"0"];
        }
        if ([BGControl isNULLOfString:[dict valueForKey:@"k1dt012n"]]) {
            model.k1dt012n = [NSDecimalNumber decimalNumberWithString:@"0"];
        }
        if ([BGControl isNULLOfString:[dict valueForKey:@"k1dt013n"]]) {
            model.k1dt013n = [NSDecimalNumber decimalNumberWithString:@"0"];
        }
        [model setValuesForKeysWithDictionary:dict];
        NSDecimalNumber *one = [[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]]];
        NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:one afterPoint:lpdt043]];
        priceNum =[priceNum decimalNumberByAdding:two];
        
        [self.dataArray addObject:model];
        
    }
[self.bigTableView reloadData];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[StocktakDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    StocktakModel *model = self.dataArray[indexPath.section];
    
   [_cell showModel:model];
    return _cell;
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    //    NewModel *model = self.dataArray[indexPath.section];
    return 80;
    
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
            self.dateTextFile.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
            
            moDate = [BGControl stringToDate:self.dateTextFile.text];
            
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
    [postMast setValue:self.dateTextFile.text forKey:@"k1mf003"];
    [postMast setValue:[masterDict valueForKey:@"k1mf005"] forKey:@"k1mf005"];
    [postMast setValue:[masterDict valueForKey:@"k1mf006"] forKey:@"k1mf006"];
    [postMast setValue:[masterDict valueForKey:@"k1mf008"] forKey:@"k1mf008"];
    [postMast setValue:remarkStr forKey:@"k1mf010"];
    [postMast setValue:[masterDict valueForKey:@"k1mf011"] forKey:@"k1mf011"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf100"] forKey:@"k1mf100"];
    [postMast setValue:[masterDict valueForKey:@"k1mf109"] forKey:@"k1mf109"];
    [postMast setValue:[masterDict valueForKey:@"k1mf302"] forKey:@"k1mf302"];
    [postMast setValue:[masterDict valueForKey:@"k1mf303"] forKey:@"k1mf303"];
    [postMast setValue:[masterDict valueForKey:@"k1mf500"] forKey:@"k1mf500"];
    [postMast setValue:[masterDict valueForKey:@"k1mf600"] forKey:@"k1mf600"];
    [postMast setValue:[masterDict valueForKey:@"k1mf800"] forKey:@"k1mf800"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf998"] forKey:@"k1mf998"];
    [postMast setValue:[masterDict valueForKey:@"k1mf999"] forKey:@"k1mf999"];
    
    NSMutableDictionary  *updateDict = [[NSMutableDictionary alloc] init];
    
    [updateDict setObject:postMast forKey:@"master"];
   
   
    [updateDict setObject:oneArr forKey:@"detail"];
    NSNumber *isconfirmNum = [NSNumber numberWithBool:isConfirm];
    [updateDict setObject:isconfirmNum forKey:@"isConfirm"];
    [self show];
    NSString *urlStr;
    if ([self.typeStr isEqualToString:@"add"]) {
        if (isConfirm == true) {
            urlStr = @"App/Wbp3003/CreateAndConfirm";
        }else {
            urlStr = @"App/Wbp3003/Create";
        }

    }else {
        if (isConfirm == true) {
            urlStr = @"App/Wbp3003/UpdateAndConfirm";
        }else {
            urlStr = @"App/Wbp3003/Update";
        }
        
    }
    
        [[AFClient shareInstance] Update:updateDict withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                StocktakOnePageVC *callOrderThree = [storyboard instantiateViewControllerWithIdentifier:@"StocktakOnePageVC"];
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
    self.remarkFile.text = str;
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
