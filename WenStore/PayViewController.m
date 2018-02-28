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
     NSInteger lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:self.sumPrice afterPoint:lpdt043]];
    // Do any additional setup after loading the view.
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
        [self dismiss];
         [self Alert:@"支付失败"];
    }];
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
