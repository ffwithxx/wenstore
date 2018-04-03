//
//  PayViewController.m
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PayViewController.h"
#import "OrderTwoDetailVC.h"
#import "OrderTwoVC.h"
#import "AFClient.h"
#import "BGControl.h"

@interface PayViewController (){
    int paymentId;
}

@end

@implementation PayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    paymentId = 12;
    [self isIphoneX];
    [self fist];
    
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
- (void)fist {
    [self show];
    [[AFClient shareInstance] GetPaymentResrouce:self.k1mf100 progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] intValue] == 200) {
            NSDecimalNumber *payMent = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[[responseBody valueForKey:@"data"]valueForKey:@"payment"]]];
            NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
            self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:payMent afterPoint:lpdt043]];
        }else {
            NSString *errors = [responseBody valueForKey:@"errors"][0];
            [self Alert:errors];
        }
        [self dismiss];
    } failure:^(NSError *error) {
         [self dismiss];
    }];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
//        if ([self.fanStr isEqualToString:@"OrderTwoDetailVc"]) {
//            [self.navigationController popViewControllerAnimated:YES];
//        }else {
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            OrderTwoVC *orderTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
            [self.navigationController pushViewController:orderTwo animated:YES];
//        }
//        [self.navigationController popViewControllerAnimated:YES];
      
    }else if (sender.tag == 202) {
        self.oneImg.image = [UIImage imageNamed:@"greeYes.png"];
        self.twoImg.image = [UIImage imageNamed:@""];
        self.threeImg.image = [UIImage imageNamed:@""];
        paymentId = 12;

    
    }else if (sender.tag == 203) {
         self.twoImg.image = [UIImage imageNamed:@"greeYes.png"];
        self.oneImg.image = [UIImage imageNamed:@""];
        self.threeImg.image = [UIImage imageNamed:@""];

        
    }else if (sender.tag == 204) {
         self.threeImg.image = [UIImage imageNamed:@"greeYes.png"];
        self.twoImg.image = [UIImage imageNamed:@""];
        self.oneImg.image = [UIImage imageNamed:@""];

        
    }


}
- (IBAction)payClick:(UIButton *)sender {
    NSNumber *payNum = [NSNumber numberWithInt:paymentId];
    NSDictionary *dict = [[NSDictionary alloc] initWithObjectsAndKeys:payNum,@"paymentId",self.k1mf100,@"k1mf100", nil];
    [self show];
    if(![self.priceLab.text isEqualToString:@"￥_ _"]){
    [[AFClient shareInstance] Masgetpay:@"App/Masgetpay/Pay" withDict:dict progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        if ([[responseBody valueForKey:@"status"] intValue] == 200) {
            NSString *url = [responseBody valueForKey:@"data"];
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
             NSLog(@"%@",responseBody);
        }else {
            NSString *errors = [responseBody valueForKey:@"errors"][0];
            [self Alert:errors];
        }
        [self dismiss];
    } failure:^(NSError *error) {
       
         [self Alert:@"支付失败"];
    }];
    }
}
- (void)Alert:(NSString *)AlertStr{
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
}
-(void)test{
    NSLog(@"123");
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
