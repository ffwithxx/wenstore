//
//  CallOrderFourDetailOneVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderFourDetailOneVC.h"
#import "CallOrderFourDetailOneCell.h"
#import "orderCountThree.h"
#import "SearchVC.h"
#import "AFClient.h"
#import "BGControl.h"
#import "DetailVC.h"
#import "ReasonView.h"
#import "BackCell.h"
#define kCellName @"CallOrderFourDetailOneCell"

@interface CallOrderFourDetailOneVC ()<UITableViewDelegate,UITableViewDataSource,onedelegate,fanDataDelegate,inputdelegate,resonTanDelegate,resonDelegate,backDelegate,oneBackdelegate,inputOnedelegate,ChoiceresonTanDelegate,UITextViewDelegate> {
    NSMutableArray *arrOne;
    NSMutableArray *two;

    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
    NSInteger lpdt036;//数量
    NSInteger lpdt042;//单价
    NSInteger lpdt043;//总价
    NSMutableDictionary *dataDict;
    NSMutableDictionary *rightDict;
    NSMutableDictionary *mastDict;
    NSMutableDictionary *postMastDict;
    NSDecimalNumber *orderCount;
    NSDecimalNumber *priceNumber;
    BOOL isSerch;
    BOOL istrue;
     NSString *rightorXia;
    NSMutableDictionary *updateDict;
    orderCountThree *orderView;
    BOOL isConfirmed;
    NSMutableDictionary *headDict;
    ReasonView *resonView;

}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;
@end

@implementation CallOrderFourDetailOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
    rightorXia = @"right";
    isSerch = NO;
    istrue = false;
    self.bigView.hidden = YES;
     [self.carTableView setTableHeaderView:self.topview];
    headDict = [[NSMutableDictionary alloc] init];
    postMastDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    rightDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray arrayWithArray:self.datas];
    postArr = [NSMutableArray array];
    if ([self.typeStr isEqualToString:@"add"]) {
        self.titleLab.text = @"新增商品";
    }
    resonView.resonTextFile.keyboardType = UIReturnKeyDone;
    resonView.resonTextFile.delegate = self;
    [self firstOne];
    [self first];

}
- (void)first {

    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    self.dataArray = [NSMutableArray array];
    postOneArr = [NSMutableArray array];
    postArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt042"] ] integerValue];
    self.carTableView.delegate = self;
    self.carTableView.dataSource = self;
    
    self.carTableView.showsVerticalScrollIndicator = NO;
    self.carTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.leftTableView.showsVerticalScrollIndicator = NO;
    self.leftTableView.separatorStyle = UITableViewCellSelectionStyleNone;
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    self.rightTableView.showsVerticalScrollIndicator = NO;
    self.rightTableView.separatorStyle = UITableViewCellSelectionStyleNone;
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
        self.sumLab.hidden = YES;
    }else{
        self.sumLab.hidden = NO;
    }
}
- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
       
    }
    return _datas;
}
- (UITableView *)tableView

{
    
    if (self.carTableView == nil) {
        
        self.carTableView = [[UITableView alloc] initWithFrame:self.carTableView.frame style:UITableViewStylePlain];
        
        self.carTableView.delegate = self;
        
        self.carTableView.dataSource = self;
        
        [self.view addSubview:self.carTableView];
        
    }
    
    return self.carTableView;
    
}


-(void)firstOne {
    NSString *urlStr;
    if ([self.typeStr isEqualToString:@"add"]) {
        urlStr = @"App/Wbp3011/New";
    }else {
     urlStr = @"App/Wbp3011/Edit";
    }
    [self show];

    [[AFClient shareInstance] GetEdit:self.idStr withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                headDict = responseBody[@"data"];
                NSDictionary *dict = responseBody[@"data"];
                mastDict = [dict valueForKey:@"master"];
                self.sumLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:[mastDict valueForKey:@"k1mf302"] afterPoint:lpdt043]];
                 priceNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf302"]]];
                orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf303"]]];
                rightDict = responseBody[@"data"];
                NSArray *dataArr = [dict valueForKey:@"groupDetail"];
//                NSInteger count = 0;
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                    [self.datas addObject:titleStr];
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    for (int j = 0; j<dictDetail.count; j++) {
                        EditModel *model  = [EditModel new];
                        NSDictionary *dictOne = dictDetail[j];
                     
                       
                        model.orderCount =[dictOne valueForKey:@"k1dt101"];
                        model.keyStr = [NSString stringWithFormat:@"%ld",(long)i];
                        model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)i];
                     
                        model.xianStr = @"1";
                        model.index = j;
                        model.indexOne = j;
                        [model setValuesForKeysWithDictionary:dictOne];
                        
                        [arr addObject:model];
                        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
                            [postArr addObject:model];
                        
                        }
                    }
                    
                    [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)i]];

//                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
//                    
//                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
//                    NSMutableArray *arr =[NSMutableArray array];
//                    NSInteger countOne = 0;
//                    for (int j = 0; j<dictDetail.count; j++) {
//                        EditModel *model  = [EditModel new];
//                        NSDictionary *dictOne = dictDetail[j];
//                        model.orderCount = [dictOne valueForKey:@"k1dt101"];
//                        
//                        model.xianStr = @"1";
//                        [model setValuesForKeysWithDictionary:dictOne];
//                        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
//                            model.keyStr = [NSString stringWithFormat:@"%ld",(long)count];
//                            model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)count];
//                            model.index = countOne;
//                            model.indexOne = countOne;
//                            countOne = countOne+1;
//                            [postArr addObject:model];
//                            [arr addObject:model];
//                        }
//                        
//                    }
//                    if (arr.count >0) {
//                        [self.datas addObject:titleStr];
//                        [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)count]];
//                        count = count+1;
//                    }
                    
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = dataDict;
                self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
                
                [self dismiss];
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
                [self firstTwo];
                if (self.datas.count > 0) {
                     [self setBaseTableView];
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
                        [self firstOne];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self firstOne];
                            
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
        }else{
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
         
            [self dismiss];
        }
        
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}

- (void)firstTwo {
    self.sumOrderCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)postArr.count];
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.sumOrderCount.text FontSize:9 MaxSize:CGSizeMake(20, 20)].width;
    self.sumOrderCount.clipsToBounds = YES;
    if (orderWidth >10) {
        self.sumOrderCount.frame = CGRectMake(52, -((orderWidth +2)/2), orderWidth+2, orderWidth+2);
        self.sumOrderCount.layer.cornerRadius =(orderWidth +2)/2;
    }else {
        self.sumOrderCount.layer.cornerRadius = 6.f;
        self.sumOrderCount.frame = CGRectMake(52, -((orderWidth +2)/2), 12, 12);
    }
    
    if (postArr.count >0) {
        self.sumOrderCount.hidden = NO;
       
        self.addOrderBth.backgroundColor = kTabBarColor;
    self.addOrderBth.enabled = YES;
        [self.addOrderBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else {
        self.sumOrderCount.hidden = YES;
        self.addOrderBth.backgroundColor = kBackGroungColor;
        self.addOrderBth.enabled = NO;
        [self.addOrderBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [self hiddleAllViews];
        istrue = false;
        self.sumOrderCount.text = @"";
        self.sumLab.text = @"";
       // self.priceLab.hidden = YES;
        self.sumOrderCount.hidden = YES;
      
        
    }

}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        
        if (isSerch == true) {
          
            isSerch = NO;
            self.searchImg.hidden = NO;
            self.searchBth.enabled = YES;
            dataDict = [[NSMutableDictionary alloc] init];
            for (int i = 0; i<self.ruleArr.count; i++) {
                NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                NSMutableArray *arr = [[NSMutableArray alloc] init];
                for (int j = 0; j<arrTwo.count; j++) {
                    EditModel *model = arrTwo[j];
                    model.xianStr = @"1";
                    [arr addObject:model];
                    
                }
                [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];
            }
            
            
            self.ruleDita = [[NSMutableDictionary alloc] init];
            self.ruleDita = dataDict;
            self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
            [self.rightTableView reloadData];
            [self.leftTableView reloadData];
            [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
            
        }else {
        [self.navigationController popViewControllerAnimated:YES];
        }
    }else if (sender.tag == 203){
        if (postArr.count>0) {
             [self jiaoyan];
        }
       
        
        
      
        
    }else if (sender.tag == 204){
        if (postArr.count>0) {
            [self jiaoyan];
        }

    }else if (sender.tag == 202) {
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        
    }else if (sender.tag == 205) {
            if (!istrue && postArr.count>0) {
                self.blackButton.hidden = NO;
                [self.view addSubview:self.bigView];
                [self.view addSubview:self.bottomView];
                self.bigView.hidden = NO;
                self.carTableView.hidden = NO;
                istrue = true;
                rightorXia = @"xia";
                [self.carTableView reloadData];
                
            }else{
                rightorXia = @"right";
                [self hiddleAllViews];
                
                istrue = false;
            }
        CGFloat maxHei = self.view.frame.size.height *0.65;
        CGFloat hei = postArr.count *65;
        if (hei > maxHei) {
            self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - maxHei - 50-40, kScreenSize.width, maxHei+40 );
            self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width,self.bigView.frame.size.height);
        }else {
            self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50 - hei-40, kScreenSize.width, hei +40);
            self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.bigView.frame));
            
        }

    }
        else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        }
        
    
}
- (IBAction)deletClick:(UIButton *)sender {
    [postArr removeAllObjects];
   
    [self hiddleAllViews];
    istrue = false;
    self.sumLab.text = @"";
   
    [self.carTableView reloadData];
    
    for (int i = 0; i<_ruleArr.count; i++) {
        NSMutableArray *arr = [NSMutableArray arrayWithArray:[dataDict valueForKey:[NSString stringWithFormat:@"%d",i]]];
        for (int j = 0; j<arr.count; j++) {
            EditModel *model = arr[j];
            model.orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
            [[self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]] replaceObjectAtIndex:j withObject:model];
            NSLog(@"%@",model.orderCount);
        }
    }
    dataDict = self.ruleDita;
    self.datas = self.ruleArr;
    [self.rightTableView reloadData];

}


- (void)hiddleAllViews{
    if (istrue) {
        istrue = false;
    }
     //    [forecastView.ipText resignFirstResponder];
    self.bigView.hidden = YES;
    rightorXia = @"right";
    self.carTableView.hidden = YES;
   
    [self.bigView removeFromSuperview];
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
}
-(void)hiddleOne{
    if (istrue) {
        istrue = false;
    }


    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    orderView.hidden = YES;
    [orderView.orderFile resignFirstResponder];
    //        self.blackButton.hidden = YES;
}

-(void)jiaoyan {
  
    NSMutableArray *uploadImgArr = [NSMutableArray array];
    uploadImgArr = [headDict valueForKey:@"uploadImages"];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    postMastDict = [[NSMutableDictionary alloc] init];
    postMastDict = mastDict;
    [postMastDict setObject:priceNumber forKey:@"k1mf302"];
    [postMastDict setObject:orderCount forKey:@"k1mf303"];
    if (![self.typeStr isEqualToString:@"add"]) {
         [postMastDict setObject:self.idStr forKey:@"k1mf100"];
    }
    
    NSMutableArray *detailArr = [NSMutableArray new];
    for (int i = 0; i<postArr.count; i++) {
        EditModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
//        [modelOne setValue:model.k1dt003d forKey:@"k1dt003d"];
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt201"];
        [modelOne setValue:model.orderCount forKey:@"k1dt101"];
         [modelOne setValue:model.k1dt202 forKey:@"k1dt202"];
        [modelOne setValue:model.k1dt502 forKey:@"k1dt502"];
        [modelOne setValue:model.k1dt501 forKey:@"k1dt501"];
        [modelOne setValue:model.k1dt503 forKey:@"k1dt503"];
        NSNumber *imgNum = [NSNumber numberWithInt:model.imge004];
        [modelOne setValue:imgNum forKey:@"imge004"];
        NSNumber *num = [NSNumber numberWithBool:model.selected];
        [modelOne setValue:num forKey:@"selected"];
        NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
        
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
        
        
        
        [modelOne setValue:model.k1dt103 forKey:@"k1dt103"];
        [modelOne setValue:model.k1dt104 forKey:@"k1dt104"];
        [detailArr addObject:modelOne];
    }
    [self show];
    if ([self.typeStr isEqualToString:@"add"]) {
        [[AFClient shareInstance] postValidateCart:postMastDict detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3011/ValidateCart" withjsob001:@"" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                [self dismiss];
                
                NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                    NSDictionary *dict = [responseBody valueForKey:@"data"];
                    updateDict = [[NSMutableDictionary alloc] init];
                    NSNumber *confirme = [NSNumber numberWithBool:isConfirmed];
                    [updateDict setObject:confirme forKey:@"isConfirmed"];
                    [updateDict setObject:[dict valueForKey:@"master"] forKey:@"master"];
                    [updateDict setObject:[dict valueForKey:@"detail"] forKey:@"detail"];
                    DetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
                    addVC.datDict = responseBody[@"data"];
                    addVC.reasonsArr = self.reasonsArr;
                    
                    addVC.typeStr = @"fourNew";
                    
                    [self.navigationController pushViewController:addVC animated:YES];
                    
                    
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
                            [self jiaoyan];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self jiaoyan];
                                
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
            [self dismiss];
            
        } failure:^(NSError *error) {
            [self dismiss];
        }];
  
    }else{
    [[AFClient shareInstance] postValidateCartone:postMastDict detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3011/ValidateCart" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            [self dismiss];
            
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                NSDictionary *dict = [responseBody valueForKey:@"data"];
                updateDict = [[NSMutableDictionary alloc] init];
                NSNumber *confirme = [NSNumber numberWithBool:isConfirmed];
                [updateDict setObject:confirme forKey:@"isConfirmed"];
                [updateDict setObject:[dict valueForKey:@"master"] forKey:@"master"];
                [updateDict setObject:[dict valueForKey:@"detail"] forKey:@"detail"];
                DetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
                NSMutableDictionary *dictOne = [[NSMutableDictionary alloc] init];
             
                
                addVC.datDict = responseBody[@"data"];
                
                addVC.typeStr = @"four";
                
                [self.navigationController pushViewController:addVC animated:YES];
                
                
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
                        [self jiaoyan];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self jiaoyan];
                            
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
        [self dismiss];
        
    } failure:^(NSError *error) {
        [self dismiss];
    }];
    }

}

-(void)fanDict:(NSMutableDictionary *)dict
{
   
    isSerch = true;
    self.searchImg.hidden = YES;
    self.searchBth.enabled = NO;
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger count = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [dict valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            EditModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",count];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            count = count+1;
            [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",count-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
    
    if (self.datas.count<1) {
        self.datas = [NSMutableArray arrayWithArray:self.ruleArr];
        dataDict = [[NSMutableDictionary alloc] init];
        dataDict = self.ruleDita;
        //        [self Alert:@"没有"]
    }
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dict;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}


- (BOOL)prefersStatusBarHidden{
    return YES;
}

#pragma mark - private
- (void)setBaseTableView {
    // leftTableView
    
    
    // rightTableView
    self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), 60, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 110);
    // 默认选择左边tableView的第一行
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

- (void)selectLeftTableViewWithScrollView:(UIScrollView *)scrollView {
    if (self.currentSelectIndexPath) {
        return;
    }
    // 如果现在滑动的是左边的tableView，不做任何处理
    if ((UITableView *)scrollView == self.leftTableView) return;
    // 滚动右边tableView，设置选中左边的tableView某一行。indexPathsForVisibleRows属性返回屏幕上可见的cell的indexPath数组，利用这个属性就可以找到目前所在的分区
    if ((UITableView *)scrollView == self.carTableView) return;

    if (self.datas.count > 0) {
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.rightTableView.indexPathsForVisibleRows.firstObject.section inSection:0] animated:YES scrollPosition:UITableViewScrollPositionMiddle];

    }
   }

#pragma mark - UITableViewDelegate && UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.leftTableView)
    {
        return 1;
    }else if (tableView == self.rightTableView){
        
        return self.datas.count;
    }else {
        return 1;
    }

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView){
        return self.datas.count;
    }else if (tableView == self.rightTableView){
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)section]];
        return arr.count ;
    }
    return postArr.count;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return nil;
//    return self.datas[section];
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if (tableView == self.leftTableView){
        static NSString *ID = @"cellId";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
        if (!cell) cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        
        cell.textLabel.text = self.datas[indexPath.row];
        cell.textLabel.textColor = kTextGrayColor;
        cell.textLabel.highlightedTextColor = kTabBarColor;
        cell.textLabel.font = [UIFont systemFontOfSize:15];
        cell.textLabel.backgroundColor = [UIColor clearColor];
        cell.backgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.backgroundView.backgroundColor = kBackGroungColor;
        cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        
        cell.textLabel.numberOfLines = 0;
        return cell;
    }else if (tableView == self.rightTableView) {
        
        // 通过不同标识创建cell实例
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        CallOrderFourDetailOneCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            _twoCell = [[CallOrderFourDetailOneCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        }
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.inputDelegate = self;
         _twoCell.oneDelegate = self;
        _twoCell.resonDelegate = self;
        _twoCell.resonOneDelegate = self;
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        EditModel *model = arr[indexPath.row];

        [_twoCell showModel:model];

          return _twoCell;
        
    }else {
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        BackCell  * _oneCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_oneCell) {
            _oneCell = [[BackCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        CGRect cellFrame = _oneCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width;
        _oneCell.backgroundColor = kBackGroungColor;
        [_oneCell.contentView setFrame:cellFrame];
        _oneCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_oneCell.frame];
        _oneCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _oneCell.selectionStyle = UITableViewCellSelectionStyleNone;
        _oneCell.backDelegate = self;
        _oneCell.inputOnedelegate = self;
        //_oneCell.inputView = self;
        EditModel *model = postArr[indexPath.row];
        [_oneCell showModelWithModel:model];
        return _oneCell;
        
    }

    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    // 如果点击的是右边的tableView，不做任何处理
    if (tableView == self.rightTableView)
    {
        UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }else{
        // 点击左边的tableView，设置选中右边的tableView某一行。左边的tableView的每一行对应右边tableView的每个分区
        [self.rightTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row] animated:YES scrollPosition:UITableViewScrollPositionTop];
        UITableViewCell * cell = [self.rightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:indexPath.row]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.backgroundView.backgroundColor = kBackGroungColor;
        cell.selectedBackgroundView=[[UIView alloc]initWithFrame:cell.frame];
        cell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        UITableViewCell * cellone = [self.rightTableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
        cellone.selectionStyle = UITableViewCellSelectionStyleNone;
        
        self.currentSelectIndexPath = indexPath;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.leftTableView) {
        return 70;
    }else if(tableView == self.rightTableView){
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        EditModel *model = arr[indexPath.row];
        if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
            return 160;
        }else{
            return 210+30;
        }

    }
    
    return 65;
}
-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count{
    if ([rightorXia isEqualToString:@"xia"]) {
        [self hiddleOne];
        
    }else{
        
        [self hiddleAllViews];
    }
    model.orderCount = count;
    [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:model];
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            EditModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                [arrXianshi addObject:model];
            }
            
        }
        if (arrXianshi.count>0) {
            countOne = countOne+1;
            [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
 
    /* 更新postarr*/
    NSMutableArray *arr = [NSMutableArray new];
    for (EditModel *oneModel in postArr) {
        [arr addObject:oneModel.k1dt001];
    }
    
    if ([arr containsObject:model.k1dt001]) {
        NSInteger index = [arr indexOfObject:model.k1dt001];
        model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        NSComparisonResult result = [model.orderCount compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"0"]]];
        if (result != NSOrderedDescending) {
            [postArr removeObjectAtIndex:index];
        }else{
        [postArr replaceObjectAtIndex:index withObject:model];
        }
    }else{
        model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        [postArr addObject:model];
    }
    orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    CGFloat callTaleHei = 0;
    for (int i = 0; i <postArr.count; i++) {
        EditModel *modelTwo = postArr[i];
        NSString *countStr = [BGControl notRounding:modelTwo.orderCount afterPoint:lpdt036];
        orderCount = [orderCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:countStr]];
        orderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:orderCount afterPoint:lpdt036]];
        NSString *priceStr = [BGControl notRounding:modelTwo.k1dt201 afterPoint:lpdt042];
        NSDecimalNumber *zongPrice = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:priceStr]];
        priceNumber = [priceNumber decimalNumberByAdding:zongPrice];
        priceNumber = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:priceNumber afterPoint:lpdt043]];
         callTaleHei = callTaleHei +65;
    }
    self.sumLab.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    [self.rightTableView reloadData];

   // self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    self.sumOrderCount.text = [NSString stringWithFormat:@"%lu",(unsigned long)postArr.count];
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.sumOrderCount.text FontSize:9 MaxSize:CGSizeMake(20, 20)].width;
    self.sumOrderCount.clipsToBounds = YES;
    if (orderWidth >10) {
        self.sumOrderCount.frame = CGRectMake(52, -((orderWidth +2)/2), orderWidth+2, orderWidth+2);
        self.sumOrderCount.layer.cornerRadius =(orderWidth +2)/2;
    }else {
        self.sumOrderCount.layer.cornerRadius = 6.f;
        self.sumOrderCount.frame = CGRectMake(52, -((orderWidth +2)/2), 12, 12);
    }
    if (postArr.count >0) {
        self.sumOrderCount.hidden = NO;
     
       // self.priceLab.hidden = NO;
        self.addOrderBth.backgroundColor = kTabBarColor;
        self.addOrderBth.enabled = YES;
        [self.addOrderBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        
        
    }else {
        self.sumOrderCount.hidden = YES;
        self.addOrderBth.backgroundColor = kBackGroungColor;
        self.addOrderBth.enabled = NO;
       [self.addOrderBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
        [self hiddleAllViews];
        istrue = false;
        self.sumOrderCount.text = @"";
       // self.priceLab.text = @"";
       // self.priceLab.hidden = YES;
      //  self.orderCountLab.hidden = YES;
      
        
    }
    CGFloat maxHei = self.view.frame.size.height *0.65;
    if (callTaleHei +40 > maxHei) {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - maxHei - 50-40, kScreenSize.width, maxHei+40 );
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width,self.bigView.frame.size.height);
    }else {
        self.bigView.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 50 - callTaleHei-40, kScreenSize.width, callTaleHei +40);
        self.carTableView.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.bigView.frame));
        
    }
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.carTableView reloadData];
    if (self.datas.count > 0) {
        [self setBaseTableView];
    }

}
-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag  {
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"orderCountThree" owner:self options:nil];
    self.blackButton.hidden = YES;
    self.blackButton.hidden = NO;
    orderView = [nib firstObject];
    orderView.clipsToBounds = YES;
    CGRect ipRect = orderView.frame;
    ipRect.size.width = kScreenSize.width - 40;
    [orderView setFrame:ipRect];
    orderView.subMitBth.clipsToBounds = YES;
    orderView.subMitBth.layer.cornerRadius = 10.f;
    orderView.center = self.view.center;
    orderView.bigView.clipsToBounds = YES;
    orderView.bigView.layer.borderColor = [kLineColor CGColor];
    orderView.bigView.layer.cornerRadius = 5.f;
    orderView.bigView.layer.borderWidth = 1.0f;
    orderView.layer.cornerRadius = 5.f;
    orderView.tagStr = [NSString stringWithFormat:@"%ld",tag];
    orderView.editModel = model;
    orderView.typeStr = @"3011";
    orderView.oneBackDelegate = self;
    orderView.tagStr = [NSString stringWithFormat:@"%ld",(long)tag];
    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];

}

-(void)resonTan:(NSString *)typeStr withModel:(EditModel *)model {
    if ([typeStr isEqualToString:@"xia"]) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ReasonView" owner:self options:nil];
         self.blackButton.hidden = NO;
        resonView = [nib firstObject];
        resonView.clipsToBounds = YES;
        resonView.layer.cornerRadius = 5.f;
        resonView.keyStr = model.keyOneStr;
        resonView.index = model.indexOne;
        resonView.resonTextFile.text = model.k1dt503;
        resonView.delegate = self;
        CGRect forecasFrame = resonView.frame;
        forecasFrame.origin.x = 20;
        forecasFrame.size.width = kScreenSize.width - 40;
        if (kScreenSize.width == 320) {
              forecasFrame.origin.y = 120;
        }else if (kScreenSize.width == 375) {
            forecasFrame.origin.y = 150;
        }
        else {
             resonView.center = self.view.center;
        }
      
        
        [resonView setFrame:forecasFrame];
       
        [self.view addSubview:resonView];

    }
}

-(void)choiceResonTan:(NSString *)typeStr withModel:(EditModel *)model {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *dict = [BGControl dictionaryWithJsonString:jsonString];
   self.reasonsArr = [NSArray array];
   self.reasonsArr = [[dict valueForKey:@"data"] valueForKey:@"reasons"];
    if (self.reasonsArr.count > 0) {
        self.blackButton.hidden = NO;
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"退回原因" message:@"" preferredStyle:UIAlertControllerStyleAlert ];
 
        for (int i = 0; i < self.reasonsArr.count; i++) {
            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[self.reasonsArr[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                [self hilldeAll];
                model.k1dt502 = [self.reasonsArr[i] valueForKey:@"text"];
                model.k1dt501 = [self.reasonsArr[i] valueForKey:@"value"];
                [[self.ruleDita valueForKey:model.keyStr] replaceObjectAtIndex:model.index withObject:model];
                dataDict =[NSMutableDictionary new];
                self.datas = [NSMutableArray array];
                NSInteger countOne = 0;
                for (int i = 0; i<self.ruleArr.count; i++) {
                    NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
                    NSMutableArray *arrXianshi = [NSMutableArray array];
                    for (int j = 0; j<arrTwo.count; j++) {
                        EditModel *model = arrTwo[j];
                        if ([model.xianStr isEqualToString:@"1"]) {
                            model.indexOne = arrXianshi.count;
                            model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                            [arrXianshi addObject:model];
                        }
                        
                    }
                    
                    
                    if (arrXianshi.count>0) {
                        countOne = countOne+1;
                        [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
                        [self.datas addObject:self.ruleArr[i]];
                    }else {
                        
                    }
                }
                NSMutableArray *arr = [NSMutableArray new];
                for (EditModel *oneModel in postArr) {
                    [arr addObject:oneModel.k1dt001];
                }
                
                if ([arr containsObject:model.k1dt001]) {
                    NSInteger index = [arr indexOfObject:model.k1dt001];
                    model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
                    [postArr replaceObjectAtIndex:index withObject:model];
                }
                
                [self.rightTableView reloadData];
                
                
            }];
            [alertController addAction:home1Action];
        }
        //取消style:UIAlertActionStyleDefault
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            self.blackButton.hidden = YES;
        }]; [alertController addAction:cancelAction];
          [self presentViewController:alertController animated:YES completion:nil];
    }else{
        [self Alert:@"无退回原因可选"];
    }
   
    
}
-(void)resonStr:(NSString *)str withKey:(NSString *)key withIndex:(NSInteger)index {
    [self hilldeAll];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:key];
    EditModel *model = oneArr[index];
    model.k1dt503 = str;
   
    [[self.ruleDita valueForKey:key] replaceObjectAtIndex:index withObject:model];
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    NSInteger countOne = 0;
    for (int i = 0; i<self.ruleArr.count; i++) {
        NSArray *arrTwo = [self.ruleDita valueForKey:[NSString stringWithFormat:@"%d",i]];
        NSMutableArray *arrXianshi = [NSMutableArray array];
        for (int j = 0; j<arrTwo.count; j++) {
            EditModel *model = arrTwo[j];
            if ([model.xianStr isEqualToString:@"1"]) {
                model.indexOne = arrXianshi.count;
                model.keyOneStr = [NSString stringWithFormat:@"%ld",countOne];
                [arrXianshi addObject:model];
            }
            
        }
        
        
        if (arrXianshi.count>0) {
            countOne = countOne+1;
            [dataDict setObject:arrXianshi forKey:[NSString stringWithFormat:@"%ld",countOne-1]];
            [self.datas addObject:self.ruleArr[i]];
        }else {
            
        }
    }
     NSMutableArray *arr = [NSMutableArray new];
    for (EditModel *oneModel in postArr) {
        [arr addObject:oneModel.k1dt001];
    }
    
    if ([arr containsObject:model.k1dt001]) {
        NSInteger index = [arr indexOfObject:model.k1dt001];
        model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        [postArr replaceObjectAtIndex:index withObject:model];
    }
    
      [self.rightTableView reloadData];
    

    
}
-(void)blackButtonClick {
    [self hilldeAll];
}
-(void)hilldeAll {
    self.blackButton.hidden = YES;
    self.bigView.hidden = YES;
    orderView.hidden = YES;
    [resonView removeFromSuperview];
    [orderView removeFromSuperview];
    [resonView.resonTextFile resignFirstResponder];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    
    // 重新选中一下当前选中的行数，不然会有bug
    if (self.currentSelectIndexPath) self.currentSelectIndexPath = nil;
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
