//
//  AddAddressVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddAddressVC.h"
#import "BGControl.h"

@interface AddAddressVC ()<UITextViewDelegate>

@end

@implementation AddAddressVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.addressTextView.delegate = self;
    [self first];
    // Do any additional setup after loading the view.
}

- (void)first {
    self.nameLab.text = self.nameStr;
    self.mobileLab.text = self.mobileStr;
    self.addressTextView.text = self.textViewStr;
    if ([BGControl isNULLOfString:self.textViewStr]) {
        self.tishiLab.alpha = 1;
    }else {
        self.tishiLab.alpha = 0;
    }
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        [self.navigationController popViewControllerAnimated:YES];
    }
}
- (void)textViewDidChange:(UITextView *)textView {
    if (!textView.text.length) {
        self.tishiLab.alpha = 1;
    }else {
        self.tishiLab.alpha = 0;
    }
}
- (void) dismissKeyBoard {
 [self.addressTextView resignFirstResponder];
}
 
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.addressTextView isExclusiveTouch]) {
        [self.addressTextView resignFirstResponder];
    }
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
