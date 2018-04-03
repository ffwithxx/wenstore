//
//  EmailViewController.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "EmailViewController.h"
#import "EmailCell.h"
#import "BGControl.h"
#import "AFClient.h"
#import "Email.h"
#define kCellName @"EmailCell"

@interface EmailViewController ()<UITableViewDelegate,UITableViewDataSource,EmailDelegate> {
    EmailCell *_cell;
    NSMutableArray *postOneArr;
    NSMutableDictionary *dataDict;
    NSInteger indexNum;
    Email *emailView;
    NSString *emailStr;
}

@end

@implementation EmailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    indexNum = 0;
    self.dataArray = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    dataDict = [NSMutableDictionary new];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    [self first];
    
}
- (void)isIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.bigTableView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        self.leftImg.frame = CGRectMake(15, 52, 24, 16);
        self.rightImg.frame = CGRectMake(kScreenSize.width-72, 50, 20, 13);
        self.rightLab.frame = CGRectMake(kScreenSize.width-55, 34, 40, 50);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
    }
}
- (void)first {
    [self show];
[[AFClient shareInstance] NewSendReport:self.idStr withArr:postOneArr withUrl:@"App/Wbp3022/NewSendReport" progressBlock:^(NSProgress *progress) {
    
} success:^(id responseBody) {
    if ([[responseBody valueForKey:@"status"] integerValue]==200) {
        NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
        if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
            dataDict = responseBody[@"data"];
            NSArray *receiverArr = [dataDict valueForKey:@"receivers"];
            for (int i = 0; i<receiverArr.count; i++) {
                NSString *xianshi = @"1";
                NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:xianshi,@"xianshi",receiverArr[i],@"mail", nil];
                [self.dataArray addObject:dic];
                
            }
            if (self.dataArray.count <1) {
                self.sendBth.hidden = YES;
            }
            [self.bigTableView reloadData];
          
            
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

- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 202) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"Email" owner:self options:nil];
        self.blackButton.hidden = YES;
        self.blackButton.hidden = NO;
        emailView = [nib firstObject];
        emailView.clipsToBounds = YES;
        CGRect ipRect = emailView.frame;
        ipRect.size.width = kScreenSize.width - 40;
        [emailView setFrame:ipRect];
        emailView.subMitBth.clipsToBounds = YES;
        emailView.subMitBth.layer.cornerRadius = 10.f;
        emailView.center = self.view.center;
        emailView.bigView.clipsToBounds = YES;
        emailView.bigView.layer.borderColor = [kLineColor CGColor];
        emailView.bigView.layer.cornerRadius = 5.f;
        emailView.bigView.layer.borderWidth = 1.0f;
        emailView.layer.cornerRadius = 5.f;
        emailView.emailDelegate = self;
        [emailView.orderFile becomeFirstResponder];
        [self.view addSubview:emailView];

    }else {
        [self sendEmail];
    }
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[EmailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    NSDictionary *receiversDict = self.dataArray[indexPath.section];
    [_cell showWithDic:receiversDict];
   
    return _cell;
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50 ;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    NSDictionary *current = self.dataArray[indexPath.section];
    
    if (indexPath.section == indexNum-1) {
        return;
    }
    NSDictionary *newDic =[NSDictionary dictionaryWithObjectsAndKeys:@"2",@"xianshi",[current valueForKey:@"mail"],@"mail", nil];

    emailStr = [current valueForKey:@"mail"];
    [self.dataArray replaceObjectAtIndex:indexPath.section withObject:newDic];
    if (indexNum > 0) {
        NSDictionary *current = self.dataArray[indexNum-1];
        
        NSDictionary *newDic =[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"xianshi",[current valueForKey:@"mail"],@"mail", nil];
        [self.dataArray replaceObjectAtIndex:indexNum-1 withObject:newDic];
    }
    indexNum = indexPath.section + 1;
    [self.bigTableView reloadData];
    
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
-(void)fanDelegate:(NSString *)email {
    [self hiddleAllViews];
    NSDictionary *dict = [NSDictionary dictionaryWithObjectsAndKeys:@"2",@"xianshi",email,@"mail", nil];
    [self.dataArray addObject:dict];
    emailStr = email;
    if (indexNum > 0) {
        NSDictionary *current = self.dataArray[indexNum-1];
        
        NSDictionary *newDic =[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"xianshi",[current valueForKey:@"mail"],@"mail", nil];
        [self.dataArray replaceObjectAtIndex:indexNum-1 withObject:newDic];
        
    }
    [self.bigTableView reloadData];
}


- (void)sendEmail {
    NSString *email = @"";
    for (int i = 0; i<self.dataArray.count; i++) {
        if (i == self.dataArray.count-1) {
             email = [NSString stringWithFormat:@"%@%@",email,[self.dataArray[i] valueForKey:@"mail"]];
        }else{
        email = [NSString stringWithFormat:@"%@%@;",email,[self.dataArray[i] valueForKey:@"mail"]];
        }
    }
    
    
    NSMutableDictionary *postDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:email,@"receivers",[dataDict valueForKey:@"subject"],@"subject",[dataDict valueForKey:@"account"],@"account",[dataDict valueForKey:@"sender"],@"sender",[dataDict valueForKey:@"password"],@"password", nil];
    
    [self show];
    [[AFClient shareInstance] SendReport:self.idStr withDic:postDict withArr:postOneArr withUrl:@"App/Wbp3022/SendReport" progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] integerValue]==200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:@"邮件发送成功!"];
                
                
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
            
            NSString *str = [responseBody valueForKey:@"errors"][0];
            [self Alert:str];
            
        }
        
        
        [self dismiss];

    } failure:^(NSError *error) {
        
    }];
}
-(void)blackButtonClick {
    
    [self hiddleAllViews];
}
- (void)hiddleAllViews {
    emailView.hidden = YES;
    [emailView.orderFile resignFirstResponder];
    self.blackButton.hidden = YES;
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
