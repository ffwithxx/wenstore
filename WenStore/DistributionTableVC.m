//
//  DistributionTableVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/8.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "DistributionTableVC.h"
#import "BGControl.h"
#import "UIView+Common.h"
@interface DistributionTableVC ()<UIScrollViewDelegate>

@end

@implementation DistributionTableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.typeView.layer.cornerRadius = 5.f;
    self.typeView.layer.borderWidth = 1.f;
    self.typeView.layer.borderColor = kTabBarColor.CGColor;
    
    self.nameView.layer.cornerRadius = 5.f;
    self.nameView.layer.borderWidth = 1.f;
    self.nameView.layer.borderColor = kTabBarColor.CGColor;
    
    self.dataView.layer.cornerRadius = 5.f;
    self.dataView.layer.borderWidth = 1.f;
    self.dataView.layer.borderColor = kTabBarColor.CGColor;

    
    self.beginView.layer.cornerRadius = 5.f;
    self.beginView.layer.borderWidth = 1.f;
    self.beginView.layer.borderColor = kTabBarColor.CGColor;
    self.endView.layer.cornerRadius = 5.f;
    self.endView.layer.borderWidth = 1.f;
    self.endView.layer.borderColor = kTabBarColor.CGColor;
    self.bigScrollview.delegate = self;
    self.bigScrollview.delegate = self;
    self.bigScrollview.showsVerticalScrollIndicator = NO;
    self.bigScrollview.contentSize = CGSizeMake(width(self.bigView.frame),1130);
    self.bigScrollview.scrollEnabled = YES;
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGRect oneFrame = self.oneView.frame;
    oneFrame.size.width = self.bigView.frame.size.width;
    [self.oneView setFrame:oneFrame];
    CGRect typeFrame = self.typeView.frame;
    typeFrame.size.width = self.bigView.frame.size.width-30;
    [self.typeView setFrame:typeFrame];
    
    CGRect twoFrame = self.twoView.frame;
    twoFrame.size.width = self.bigView.frame.size.width;
    [self.twoView setFrame:twoFrame];
    CGRect nameFrame = self.nameView.frame;
    nameFrame.size.width = self.bigView.frame.size.width-30;
    [self.nameView setFrame:nameFrame];
    
    CGRect threeFrame = self.threeView.frame;
    threeFrame.size.width = self.bigView.frame.size.width;
    [self.threeView setFrame:threeFrame];
    self.subMitBth.layer.cornerRadius = 25.f;
    self.subMitBth.clipsToBounds = YES;
    CGRect subMitFrame = self.subMitBth.frame;
    subMitFrame.size.width = self.bigView.frame.size.width-30;
    [self.subMitBth setFrame:subMitFrame];
    CGRect fourFrame = self.fourView.frame;
    fourFrame.size.width = self.bigView.frame.size.width;
    [self.fourView setFrame:fourFrame];
  
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
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
