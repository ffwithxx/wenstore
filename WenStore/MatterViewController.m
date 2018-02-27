//
//  MatterViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "MatterViewController.h"
#import "MatterTableViewCell.h"
#import "BGControl.h"
#import "groupModel.h"
#import "EditVC.h"
#import "CallOrderThreeDetailOneVC.h"
#import "CallOrderFourDetailOneVC.h"
#import "ProcurementOrderVC.h"
#import "AddPSOnePageVC.h"
#import "AddPurchaseVC.h"
#import "AddScrapVC.h"
#import "AddStocktakVC.h"
#import "AddAsideVC.h"
#import "AddDialVC.h"
#import "AddProducedVC.h"
#import "AddTryEatVC.h"
#import "AddGiveAwayVC.h"
#import "AddRecipientsVC.h"
#import "AFClient.h"
#define kCellName @"MatterTableViewCell"
@interface MatterViewController ()<UITableViewDelegate,UITableViewDataSource> {
    MatterTableViewCell *_cell;
    NSMutableDictionary *dict;
    NSString *idStr;
    NSString *billId ;
     NSMutableArray *reasonsArr;
      NSMutableArray *postArr;
     NSArray *detpsArr;
}







@end

@implementation MatterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    dict = [[NSMutableDictionary alloc] init];
     postArr = [NSMutableArray array];
    self.dataArray = [NSMutableArray array];
     detpsArr = [NSArray array];
    [self first];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    // Do any additional setup after loading the view.
}
-(void)first{
    
    self.titleLab.text =  self.dataDict.groupName ;
    self.dataArray = [NSMutableArray arrayWithArray:self.dataDict.allTodos];
}
- (IBAction)backClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[MatterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    //    XyModel *model = self.dataArray[indexPath.row];
    NSDictionary *dict = self.dataArray[indexPath.section];
    [_cell showModelWithDict:dict];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    CGSize detailSize = [@"2017年春季新商品已经上架相关活动DM已寄出请各店注意查收哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈哈" sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(kScreenSize.width-30, MAXFLOAT) lineBreakMode:UILineBreakModeWordWrap];
    NSString *string = [self.dataArray[indexPath.section] valueForKey:@"appMsg"];
    
    NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc]initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc]init];
    [paragraphStyle setLineSpacing:4];
    [string1 addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0,string.length)];
    CGFloat height = [BGControl getSpaceLabelHeight:string withFont:[UIFont systemFontOfSize:15] withWidth:kScreenSize.width - 30];
    
    return 55 + height;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}
-
(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 15;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
      UIStoryboard *wendianStoryboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
     UIStoryboard *twoStoryboard = [UIStoryboard storyboardWithName:@"WendianTwo" bundle:nil];
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *dict = self.dataArray[indexPath.section];
    idStr = [dict valueForKey:@"billCode"];
     billId = [dict valueForKey:@"billId"];
    if ([billId isEqualToString:@"WBW3001"]) {
         [self setDataWithUrl:@"App/Wbp3001/GetResource"];
    }else if ([billId isEqualToString:@"WBW3008"]) {
        [self setDataWithUrl:@"App/Wbp3008/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3011"]) {
         [self setDataWithUrl:@"App/Wbp3011/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3022"]) {
       [self setDataWithUrl:@"App/Wbp3022/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3023"]) {
          [self setDataWithUrl:@"App/Wbp3023/GetResource"];
    }else if ([billId isEqualToString:@"WBW3004"]) {
          [self setDataWithUrl:@"App/Wbp3004/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3002"]) {
        [self setDataWithUrl:@"App/Wbp3002/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3003"]) {
         [self setDataWithUrl:@"App/Wbp3003/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3005"]) {
         [self setDataWithUrl:@"App/Wbp3005/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3010"]) {
         [self setDataWithUrl:@"App/Wbp3010/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3007"]) {
            [self setDataWithUrl:@"App/Wbp3007/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3018"]) {
        [self setDataWithUrl:@"App/Wbp3018/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3019"]) {
         [self setDataWithUrl:@"App/Wbp3019/GetResource"];
        
    }else if ([billId isEqualToString:@"WBW3013"]) {
      [self setDataWithUrl:@"App/Wbp3013/GetResource"];
        
    }
    
    
}

- (void)setDataWithUrl:(NSString *)urlStr {
    [self show];
    
    [[AFClient shareInstance] GetResource:@"1" withArr:postArr withUrl:urlStr progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                dict = responseBody[@"data"];
                if ([urlStr isEqualToString:@"App/Wbp3001/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"lpdt036"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[dict valueForKey:@"isEnablePayment"]  ]forKey:@"isEnablePayment"];
                    //                    isEnablePayment
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3008/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3008lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3008lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3008lpdt036"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3011/GetResource"]) {
                    reasonsArr = [[NSMutableArray alloc] init];
                    reasonsArr = [dict valueForKey:@"reasons"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3011lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3011lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3011lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3011isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3022/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3022lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3022lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3022lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3022isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3004/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3004lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3004lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3004lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3004isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3002/GetResource"]) {
                    reasonsArr = [[NSMutableArray alloc] init];
                    reasonsArr = [dict valueForKey:@"reasons"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3002lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3002lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3002lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3002isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3003/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3003lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3003lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3003lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"3003isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3023/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3023lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3023lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3023lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3023isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3005/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3005lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3005lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3005lpdt036"];
                    detpsArr = [NSArray array];
                    detpsArr = [dict valueForKey:@"depts"];
                    
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3005isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3010/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3010lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3010lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3010lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3010isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3007/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3007lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3007lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3007lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3007isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3018/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3018lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3018lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3018lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3018isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3019/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3019lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3019lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3019lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3019isDisplayUnitPrice"];
                    [self delayMethod];
                }else if ([urlStr isEqualToString:@"App/Wbp3013/GetResource"]) {
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt043"] ] forKey:@"3013lpdt043"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt042"] ] forKey:@"3013lpdt042"];
                    [[NSUserDefaults standardUserDefaults] setValue:[NSString stringWithFormat:@"%@",[[dict valueForKey:@"precisionSetting"] valueForKey:@"lpdt036"] ]forKey:@"3013lpdt036"];
                    NSNumber *num = [NSNumber numberWithBool:[dict valueForKey:@"isDisplayUnitPrice"]];
                    [[NSUserDefaults standardUserDefaults] setValue:num forKey:@"Wbp3013isDisplayUnitPrice"];
                    [self delayMethod];
                }
            }else {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                if ([[userResponseDict valueForKey:@"code"] intValue] == 1|| [[userResponseDict valueForKey:@"code"] intValue] == 4) {
                    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                    }];
                    [alertController addAction:cancelAction];
                    UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        [postArr removeAllObjects];
                        [postArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                        [self setDataWithUrl:urlStr];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]==2 ) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postArr removeAllObjects];
                            [postArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self setDataWithUrl:urlStr];
                            
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

- (void)delayMethod{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    UIStoryboard *wendianStoryboard = [UIStoryboard storyboardWithName:@"Wendian" bundle:nil];
    UIStoryboard *twoStoryboard = [UIStoryboard storyboardWithName:@"WendianTwo" bundle:nil];
    if ([billId isEqualToString:@"WBW3001"]) {
        EditVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"EditVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
    }else if ([billId isEqualToString:@"WBW3008"]) {
        CallOrderThreeDetailOneVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderThreeDetailOneVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3011"]) {
        CallOrderFourDetailOneVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourDetailOneVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3022"]) {
        ProcurementOrderVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"ProcurementOrderVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3023"]) {
        AddPSOnePageVC *edit = [wendianStoryboard instantiateViewControllerWithIdentifier:@"AddPSOnePageVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3004"]) {
        AddPurchaseVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"AddPurchaseVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3002"]) {
        AddScrapVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"AddScrapVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3003"]) {
        AddStocktakVC *edit = [storyboard instantiateViewControllerWithIdentifier:@"AddStocktakVC"];
        edit.idStr = idStr;
        edit.urlStr = @"App/Wbp3003/Edit";
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3005"]) {
        AddAsideVC *edit = [wendianStoryboard instantiateViewControllerWithIdentifier:@"AddAsideVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3010"]) {
        AddDialVC *edit = [wendianStoryboard instantiateViewControllerWithIdentifier:@"AddDialVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3007"]) {
        AddProducedVC *edit = [wendianStoryboard instantiateViewControllerWithIdentifier:@"AddProducedVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3018"]) {
        AddTryEatVC *edit = [wendianStoryboard instantiateViewControllerWithIdentifier:@"AddTryEatVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3019"]) {
        AddGiveAwayVC *edit = [twoStoryboard instantiateViewControllerWithIdentifier:@"AddGiveAwayVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }else if ([billId isEqualToString:@"WBW3013"]) {
        AddRecipientsVC *edit = [twoStoryboard instantiateViewControllerWithIdentifier:@"AddRecipientsVC"];
        edit.idStr = idStr;
        [self.navigationController pushViewController:edit animated:YES];
        
    }
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
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
