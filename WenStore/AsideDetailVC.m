//
//  AsideDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AsideDetailVC.h"
#import "AsideDetailCell.h"
#import "RemarkVC.h"
#import "BGControl.h"
#import "SZCalendarPicker.h"
#import "AFClient.h"
#import "AsideModel.h"
#import "AsideOnePageVC.h"
#import "StoreNameVC.h"
#define kCellName @"AsideDetailCell"
@interface AsideDetailVC ()<RemarkDelegate,UITableViewDelegate,UITableViewDataSource,StoreNameDelegate> {
    AsideDetailCell *_cell;
    NSInteger lpdt043;
    NSInteger lpdt042;
    NSInteger lpdt036;
    NSMutableArray *postOneArr;
    NSMutableArray *uploadImagesArr;;
    NSMutableArray *postArr;
    NSString *remarkStr;
    BOOL isConfirm;
    NSDate *bochuDate;
 
}


@end

@implementation AsideDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt042"] ] integerValue];
    postOneArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
    self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 180);
    //     self.bottomView.frame = CGRectMake(0, 0, kScreenSize.width, 100);
    [self.bigTableView setTableHeaderView:self.topView];
    [self.bigTableView setTableFooterView:self.footerView];
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
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
        self.sumPriceLab.hidden = YES;
    }else{
        self.sumPriceLab.hidden = NO;
    }
    
    
    [self first];
}
- (void)first {
    NSDictionary *masterDict = [self.dataDict valueForKey:@"master"];
    self.bochuDate.text = [BGControl changeNsdate:[NSDate date]];
    
    bochuDate = [NSDate date];
    
    self.remarkField.text = [masterDict valueForKey:@"k1mf010"];
    NSString *countStr = [NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf303"]];
    NSString *priceStr = [NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]];
    self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",countStr,@"件商品"];
    self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    self.sumPriceOne.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    NSArray *oneArr = [self.dataDict valueForKey:@"detail"];
    NSDecimalNumber *priceNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i<oneArr.count; i++) {
        AsideModel  *model = [AsideModel new];
        NSDictionary *dict = oneArr[i];
        [model setValuesForKeysWithDictionary:dict];
        NSDecimalNumber *one = [[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]]];
        NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:one afterPoint:lpdt043]];
        priceNum =[priceNum decimalNumberByAdding:two];
        
        [self.dataArray addObject:model];
        
    }
    [self.bigTableView reloadData];
}
- (IBAction)buttonClick:(UIButton *)sender {
    
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 203) {
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
            self.bochuDate.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
           
            bochuDate = [BGControl stringToDate:self.bochuDate.text];
        };
        
    }else if (sender.tag == 204) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        RemarkVC *remark = [storyboard instantiateViewControllerWithIdentifier:@"RemarkVC"];
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
    }else if (sender.tag == 205) {
        isConfirm = false;
        [self update];
    }else if (sender.tag == 206) {
        isConfirm = true;
        [self update];
    }else if (sender.tag == 202) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
        StoreNameVC *storeVC = [storyboard instantiateViewControllerWithIdentifier:@"StoreNameVC"];
        storeVC.detpsArr = self.detpsArr;
        storeVC.delegate = self;
        [self.navigationController pushViewController:storeVC animated:YES];
    }

    
    
}

-(void)update{
    NSMutableDictionary *masterDict = [self.dataDict valueForKey:@"master"];
    NSMutableDictionary *postMast = [[NSMutableDictionary alloc] init];
    [postMast setValue:[masterDict valueForKey:@"k1mf000"] forKey:@"k1mf000"];
    [postMast setValue:self.storeField.text forKey:@"k1mf001"];
    [postMast setValue:self.storeField.text forKey:@"k1mf002"];
    [postMast setValue:self.bochuDate.text forKey:@"k1mf003"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf005"] forKey:@"k1mf005"];
    [postMast setValue:[masterDict valueForKey:@"k1mf006"] forKey:@"k1mf006"];
    [postMast setValue:[masterDict valueForKey:@"k1mf007"] forKey:@"k1mf007"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf008"] forKey:@"k1mf008"];
    [postMast setValue:remarkStr forKey:@"k1mf010"];
    [postMast setValue:[masterDict valueForKey:@"k1mf011"] forKey:@"k1mf011"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf100"] forKey:@"k1mf100"];
    [postMast setValue:[masterDict valueForKey:@"k1mf101"] forKey:@"k1mf101"];
    [postMast setValue:[masterDict valueForKey:@"k1mf105"] forKey:@"k1mf105"];
    [postMast setValue:[masterDict valueForKey:@"k1mf106"] forKey:@"k1mf106"];
    [postMast setValue:self.k1mf107 forKey:@"k1mf107"];
    [postMast setValue:self.k1mf101 forKey:@"k1mf101"];
     [postMast setValue:self.storeField.text forKey:@"k1mf012"];
    [postMast setValue:[masterDict valueForKey:@"k1mf108"] forKey:@"k1mf108"];
    [postMast setValue:[masterDict valueForKey:@"k1mf116"] forKey:@"k1mf116"];
    [postMast setValue:[masterDict valueForKey:@"k1mf117"] forKey:@"k1mf117"];
    [postMast setValue:[masterDict valueForKey:@"k1mf118"] forKey:@"k1mf118"];
    [postMast setValue:[masterDict valueForKey:@"k1mf119"] forKey:@"k1mf119"];
    
    
    [postMast setValue:[masterDict valueForKey:@"k1mf302"] forKey:@"k1mf302"];
    [postMast setValue:[masterDict valueForKey:@"k1mf303"] forKey:@"k1mf303"];
    [postMast setValue:[masterDict valueForKey:@"k1mf304"] forKey:@"k1mf304"];
    [postMast setValue:[masterDict valueForKey:@"k1mf500"] forKey:@"k1mf500"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf800"] forKey:@"k1mf800"];
    [postMast setValue:[masterDict valueForKey:@"k1mf996"] forKey:@"k1mf996"];
    [postMast setValue:[masterDict valueForKey:@"k1mf997"] forKey:@"k1mf997"];
    [postMast setValue:[masterDict valueForKey:@"k1mf998"] forKey:@"k1mf998"];
    [postMast setValue:[masterDict valueForKey:@"k1mf999"] forKey:@"k1mf999"];
    
    NSMutableDictionary  *updateDict = [[NSMutableDictionary alloc] init];
    
    [updateDict setObject:postMast forKey:@"master"];
    
    
    [updateDict setObject:[self.dataDict valueForKey:@"detail"] forKey:@"detail"];
    NSNumber *isconfirmNum = [NSNumber numberWithBool:isConfirm];
    [updateDict setObject:isconfirmNum forKey:@"isConfirm"];
    [self show];
    NSString *urlStr;
   
        if (isConfirm == true) {
            urlStr = @"App/Wbp3005/CreateAndConfirm";
        }else {
            urlStr = @"App/Wbp3005/Create";
        }
  
    
    [[AFClient shareInstance] Update:updateDict withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                AsideOnePageVC *orderVC = [storyboard instantiateViewControllerWithIdentifier:@"AsideOnePageVC"];
                orderVC.detpsArr = self.detpsArr;
                [self.navigationController pushViewController:orderVC animated:YES];
                
                
                
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

-(void)RemarkStr:(NSString *)str {
    self.remarkField.text = str;
    remarkStr = str;
    //    [masterDictone setObject:str forKey:@"k1mf010"];
}

- (void)StoreNameDict:(NSDictionary *)dict {
    self.storeField.text = [dict valueForKey:@"text"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[AsideDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    AsideModel *model = self.dataArray[indexPath.section];
    
    [_cell showModel:model];
    
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
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

- (void)Alert:(NSString *)AlertStr{
       [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
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