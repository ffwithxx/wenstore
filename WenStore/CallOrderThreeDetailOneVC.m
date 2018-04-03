//
//  CallOrderThreeDetailOneVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeDetailOneVC.h"
#import "CallOrderThreeDetailOneRightCell.h"
#import "BGControl.h"
#define kCellName @"CallOrderThreeDetailOneRightCell"
#import "CallThreeAddVC.h"
#import "AFClient.h"
#import "EditModel.h"
#import "SearchVC.h"
#import "ThreeDetailVC.h"
#import "orderCountThree.h"

@interface CallOrderThreeDetailOneVC ()<UITableViewDataSource,UITableViewDelegate,orderCountDelegate,fanDataDelegate,TanDelegate,zengDataDelegate,Threedelegate> {
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
    NSMutableDictionary *updateDict;
     orderCountThree *orderView;
    BOOL isConfirmed;
    NSMutableDictionary *headDict;
    BOOL isFan;
    
    
}
@property (nonatomic, strong) NSMutableArray *datas;
// 用来保存当前左边tableView选中的行数
@property (strong, nonatomic) NSIndexPath *currentSelectIndexPath;
@end

@implementation CallOrderThreeDetailOneVC

- (void)viewDidLoad {
    [super viewDidLoad];
     self.navigationController.navigationBar.hidden = YES;
     self.navigationItem.title = @"";
    [self IsIphoneX];
    isSerch = NO;
    isFan = YES;
    headDict = [[NSMutableDictionary alloc] init];
    postMastDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray array];
    rightDict = [[NSMutableDictionary alloc] init];
    _ruleArr = [NSMutableArray arrayWithArray:self.datas];
    postArr = [NSMutableArray array];
    [self firstOne];
    [self first];
    
    //    [self setBaseTableView];
    
    // Do any additional setup after loading the view.
}
- (void)IsIphoneX {
    if (kiPhoneX) {
         self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.leftTableView.frame = CGRectMake(0, kNavHeight, 100, kScreenSize.height-kNavHeight-50);
        self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), kNavHeight, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 50-kNavHeight);
        self.leftImg.frame = CGRectMake(15, 49, 22, 19);
        self.searchImg.frame = CGRectMake(kScreenSize.width-67, 50, 17, 17);
        self.jiaImg.frame = CGRectMake(kScreenSize.width-32, 50, 17, 17);
       
    }
}

-(void)first{
    rightDict = [[NSMutableDictionary alloc] init];
    dataDict = [[NSMutableDictionary alloc] init];
    self.dataArray = [NSMutableArray array];
    postOneArr = [NSMutableArray array];
    postArr = [NSMutableArray new];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt042"] ] integerValue];
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
        self.sumPriceLab.hidden = YES;
    }else{
        self.sumPriceLab.hidden = NO;
    }
    
}


- (NSMutableArray *)datas {
    if (!_datas) {
        _datas = [NSMutableArray array];
        //        for (NSInteger i = 1; i <= 5; i++) {
        //            [_datas addObject:[NSString stringWithFormat:@"第%zd分区", i]];
        //        }
    }
    return _datas;
}
-(void)firstOne {
    [self show];
    [[AFClient shareInstance] GetEdit:self.idStr withArr:postOneArr withUrl:@"App/Wbp3008/Edit"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([responseBody[@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                headDict = responseBody[@"data"];
                NSDictionary *dict = responseBody[@"data"];
                mastDict = [dict valueForKey:@"master"];
                self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:[mastDict valueForKey:@"k1mf302"] afterPoint:lpdt043]];
                priceNumber = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf302"]]];
                orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[mastDict valueForKey:@"k1mf303"]]];

                rightDict = responseBody[@"data"];
                NSArray *dataArr = [dict valueForKey:@"groupDetail"];
                NSInteger count = 0;
                for (int i = 0; i<dataArr.count; i++) {
                    NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
                   
                    NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                    NSMutableArray *arr =[NSMutableArray array];
                    NSInteger countOne = 0;
                    for (int j = 0; j<dictDetail.count; j++) {
                        EditModel *model  = [EditModel new];
                        NSDictionary *dictOne = dictDetail[j];
                        model.orderCount = [dictOne valueForKey:@"k1dt103"];
                        
                        model.xianStr = @"1";
                        [model setValuesForKeysWithDictionary:dictOne];
                        if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
                            model.keyStr = [NSString stringWithFormat:@"%ld",(long)count];
                            model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)count];
                            model.index = countOne;
                            model.indexOne = countOne;
                            countOne = countOne+1;
                            [postArr addObject:model];
                            [arr addObject:model];
                        }
                    
                    }
                    if (arr.count >0) {
                         [self.datas addObject:titleStr];
                          [dataDict setObject:arr forKey:[NSString stringWithFormat:@"%ld",(long)count]];
                        count = count+1;
                    }
                  
                }
                self.ruleDita = [[NSMutableDictionary alloc] init];
                self.ruleDita = dataDict;
                self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
                
                [self dismiss];
                [self.leftTableView reloadData];
                [self.rightTableView reloadData];
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
            [self.navigationController popViewControllerAnimated:YES];
            [self dismiss];
        }
        
        [self dismiss];
    } failure:^(NSError *error) {
        [self dismiss];
    }];
}

- (IBAction)buttonClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    if (sender.tag == 201) {
        if (isSerch == true) {
            self.searchImg.image = [UIImage imageNamed:@"search.png"];
            isSerch = NO;
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
            isSerch = false;
            self.searchBth.enabled  = YES;
            self.searchImg.hidden = NO;

        }else{
            [self.navigationController popViewControllerAnimated:YES];
        }
      
    }else if (sender.tag == 203) {
        CallThreeAddVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"CallThreeAddVC"];
        addVC.headDict = headDict;
        addVC.dataDict = dataDict;
        addVC.dataArray = self.datas;
        addVC.zengdelegate = self;
        [self.navigationController pushViewController:addVC animated:YES];
    }else if (sender.tag == 204) {
        isConfirmed = NO;
        [self jiaoyan];
        
    }else if (sender.tag == 205) {
        isConfirmed = YES;
         [self jiaoyan];
        
    }else if (sender.tag == 202) {
       
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SearchVC *searchVC = [storyboard instantiateViewControllerWithIdentifier:@"SearchVC"];
            searchVC.dataDict = self.ruleDita;
            searchVC.maxCount = self.ruleArr.count;
            searchVC.delegate = self;
            [self.navigationController pushViewController:searchVC animated:YES];
        
       
    }
}
-(void)fanDict:(NSMutableDictionary *)dict
{
    self.searchImg.image = [UIImage imageNamed:@"yuanCancle.png"];
    isSerch = true;
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
    isFan = NO;
    self.ruleDita = [[NSMutableDictionary alloc] init];
    self.ruleDita = dict;
    self.searchBth.enabled = NO;
    self.searchImg.hidden = YES;
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}

-(void)zengDict:(NSMutableDictionary *)dict withArr:(NSMutableArray *)arr {
    dataDict =[NSMutableDictionary new];
    self.datas = [NSMutableArray array];
    self.datas = arr;
    dataDict = dict;
        self.ruleDita = [[NSMutableDictionary alloc] init];
    for (int i = 0; i<self.datas.count; i++) {
         NSMutableArray *arr =[NSMutableArray array];
        NSArray *dictDetail = [dataDict valueForKey:[NSString stringWithFormat:@"%d",i]];
        for (int j = 0; j<dictDetail.count; j++) {
            NSDictionary *dictOne = dictDetail[j];
            EditModel *model  = dictDetail[j];
            model.xianStr = @"1";
            model.keyStr = [NSString stringWithFormat:@"%d",i];
            model.keyOneStr = [NSString stringWithFormat:@"%d",i];
            model.index = j;
            model.indexOne = j;
            [postArr addObject:model];
            [arr addObject:model];
        }
         [self.ruleDita setObject:arr forKey:[NSString stringWithFormat:@"%d",i]];
    }
    
   
    self.ruleArr = [NSMutableArray arrayWithArray:self.datas];
    [self setview];
//    [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
}
-(void)setview {
    orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i <postArr.count; i++) {
        EditModel *modelTwo = postArr[i];
        NSString *countStr = [BGControl notRounding:modelTwo.orderCount afterPoint:lpdt036];
        orderCount = [orderCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:countStr]];
        orderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:orderCount afterPoint:lpdt036]];
        NSString *priceStr = [BGControl notRounding:modelTwo.k1dt201 afterPoint:lpdt042];
        NSDecimalNumber *zongPrice = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]]decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:priceStr]];
        priceNumber = [priceNumber decimalNumberByAdding:zongPrice];
        priceNumber = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    }
    self.sumPriceLab.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    [self.leftTableView reloadData];
    [self.rightTableView reloadData];
}
-(void)jiaoyan {
    postMastDict = [[NSMutableDictionary alloc] init];
    postMastDict = mastDict;
//    [postMastDict setObject:priceNumber forKey:@"k1mf302"];
//    [postMastDict setObject:orderCount forKey:@"k1mf303"];
    NSMutableArray *uploadImgArr = [NSMutableArray array];
    uploadImgArr = [rightDict valueForKey:@"uploadImages"];
    NSMutableArray *proOrderArr = [NSMutableArray array];
    NSMutableArray *freeOrderArr = [NSMutableArray array];
    NSMutableArray *detailArr = [NSMutableArray new];
    for (int i = 0; i<postArr.count; i++) {
        EditModel *model = postArr[i];
        NSMutableDictionary *modelOne = [NSMutableDictionary new];
        [modelOne setValue:model.k1dt001 forKey:@"k1dt001"];
        [modelOne setValue:model.k1dt002 forKey:@"k1dt002"];
        NSNumber *num = [NSNumber numberWithInt:model.imge004];
        [modelOne setValue:num forKey:@"imge004"];
        [modelOne setValue:model.k1dt003 forKey:@"k1dt003"];
        [modelOne setValue:model.k1dt003d forKey:@"k1dt003d"];
        [modelOne setValue:model.k1dt004 forKey:@"k1dt004"];
        [modelOne setValue:model.k1dt005 forKey:@"k1dt005"];
        [modelOne setValue:model.k1dt005d forKey:@"k1dt005d"];
        
        [modelOne setValue:model.orderCount forKey:@"k1dt103"];
         [modelOne setValue:model.k1dt800 forKey:@"k1dt800"];
        NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
        
        [modelOne setValue:[NSDecimalNumber decimalNumberWithString:priceStr] forKey:@"k1dt201"];
        
        
        
        [modelOne setValue:model.orderCount forKey:@"k1dt103"];
        [modelOne setValue:model.k1dt104 forKey:@"k1dt104"];
        [detailArr addObject:modelOne];
    }
    [self show];
    [[AFClient shareInstance] postValidateCartone:postMastDict detail:detailArr uploadImages:uploadImgArr promoOrders:proOrderArr freeOrders:freeOrderArr withArr:postOneArr withUrl:@"App/Wbp3008/ValidateCart" progressBlock:^(NSProgress *progress) {
        
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
                ThreeDetailVC *addVC = [storyboard instantiateViewControllerWithIdentifier:@"ThreeDetailVC"];
                addVC.datDict = responseBody[@"data"];
                [self.navigationController pushViewController:addVC animated:YES];

//                [self update];
               
                
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

-(void)update{
    [self show];
    [[AFClient shareInstance] Update:updateDict withArr:postOneArr withUrl:@"App/Wbp3008/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
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
#pragma mark - private
- (void)setBaseTableView {
    // leftTableView
    
    
    // rightTableView
    self.rightTableView.frame = CGRectMake(CGRectGetMaxX(self.leftTableView.frame), kNavHeight, kScreenSize.width -self.leftTableView.frame.size.width , kScreenSize.height - 50 - kNavHeight);
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
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.leftTableView){
        return self.datas.count;
    }else if (tableView == self.rightTableView){
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)section]];
        return arr.count ;
    }
    return 0;
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
    }
    else {
        
        // 通过不同标识创建cell实例
        NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%ld%ld", (long)[indexPath section], [indexPath row]];
        CallOrderThreeDetailOneRightCell  * _twoCell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!_twoCell) {
            _twoCell = [[CallOrderThreeDetailOneRightCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
            
        }
        CGRect cellFrame = _twoCell.contentView.frame;
        cellFrame.size.width = kScreenSize.width-100;
        [_twoCell.contentView setFrame:cellFrame];
        _twoCell.TanDelegate = self;
        _twoCell.selectedBackgroundView=[[UIView alloc]initWithFrame:_twoCell.frame];
        _twoCell.selectedBackgroundView.backgroundColor = [UIColor whiteColor];
        _twoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *arr = [dataDict valueForKey:[NSString stringWithFormat:@"%ld",(long)indexPath.section]];
        EditModel *model = arr[indexPath.row];
        _twoCell.orderDelegate = self;
        [_twoCell showModel:model];
        
        return _twoCell;
        
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
    }
    if (kScreenSize.width == 320) {
        return 134;
    }
    return 178;
}
- (void)getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price {
    [self hilldeAll];
    NSMutableArray *oneArr= [self.ruleDita valueForKey:key];
    EditModel *model = oneArr[index];
    model.orderCount = count;
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
    }else{
         model.k1dt202 = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] ] afterPoint:lpdt043]];
        [postArr addObject:model];
    }
    orderCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    priceNumber = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i <postArr.count; i++) {
        EditModel *modelTwo = postArr[i];
        NSString *countStr = [BGControl notRounding:modelTwo.orderCount afterPoint:lpdt036];
        orderCount = [orderCount decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:countStr]];
        orderCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:orderCount afterPoint:lpdt036]];
        NSString *priceStr = [BGControl notRounding:modelTwo.k1dt201 afterPoint:lpdt042];
        NSDecimalNumber *zongPrice = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",modelTwo.orderCount]]decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:priceStr]];
        priceNumber = [priceNumber decimalNumberByAdding:zongPrice];
        priceNumber = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    }
    self.sumPriceLab.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:priceNumber afterPoint:lpdt043]];
    [self.rightTableView reloadData];
    
    
}
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    if (tableView == self.leftTableView) return 0;
//    return 30;
//}


-(void)getwithKey:(NSString *)key withIndex:(NSInteger)index withModel:(EditModel *)model withweizhi:(NSString *)weizhi {
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
//    orderView.tagStr = [NSString stringWithFormat:@"%ld",tag];
    orderView.editModel = model;
    orderView.typeStr = @"3008";
    orderView.threeDelegate = self;

    orderView.orderFile.keyboardType = UIKeyboardTypeDecimalPad;
    [orderView.orderFile becomeFirstResponder];
    [self.view addSubview:orderView];


}
-(void)blackButtonClick {
    [self hilldeAll];
}
-(void)hilldeAll {
    self.blackButton.hidden = YES;
    [orderView removeFromSuperview];
    
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{ // 监听tableView滑动
    [self selectLeftTableViewWithScrollView:scrollView];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.topItem.title = @"";
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
