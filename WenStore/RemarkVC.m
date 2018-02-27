//
//  RemarkVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "RemarkVC.h"
#import "BGControl.h"

@interface RemarkVC ()<UITextViewDelegate>

@end

@implementation RemarkVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.remarkTextView.text = self.remarkStr;
    [self.remarkTextView becomeFirstResponder];
    // Do any additional setup after loading the view.
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
        if (![BGControl isNULLOfString:self.remarkTextView.text
             ]) {
            if (_delegate &&[_delegate respondsToSelector:@selector(RemarkStr:)]) {
                [_delegate RemarkStr:self.remarkTextView.text];
                [self.navigationController popViewControllerAnimated:YES];
            }

        }
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
    [self.remarkTextView resignFirstResponder];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![self.remarkTextView isExclusiveTouch]) {
        [self.remarkTextView resignFirstResponder];
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
