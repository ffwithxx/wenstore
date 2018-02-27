//
//  StocktakOnePageCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StocktakOnePageCell.h"
#import "BGControl.h"

@implementation StocktakOnePageCell{
    StocktakOnePageModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (_ScrapDelegate &&[_ScrapDelegate respondsToSelector:@selector(postoneStr:twoStr:withModel:)]) {
        [_ScrapDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:@"2"withModel:oneModel];
    }
}

-(void)showModel:(StocktakOnePageModel *)model {
    oneModel = model;
    self.pandianDate.text = [BGControl dateToDateString:model.k1mf003];
    self.orderIdLab.text = model.k1mf100;
    NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"盘点",[BGControl notRounding:model.k1mf303 afterPoint:lpdt036],@"件商品"];

    self.billsateLab.text = model.billStateName;
    self.typeLab.text = model.k1mf102;
    self.submitBth.layer.cornerRadius = 15.f;
    if (model.isDisplayEditButton || model.isDisplayCommitButton || model.isDisplayDeleteButton) {
         self.lasteView.hidden = NO;
        CGFloat oneWidth = self.submitBth.frame.size.width;
        CGFloat margin = CGRectGetMinX(self.submitBth.frame) -CGRectGetMaxX(self.bianjiBth.frame);
        if (model.isDisplayCommitButton) {
            self.submitBth.hidden = NO;
        }else {
            self.submitBth.hidden = YES;
        }
        
        if (model.isDisplayEditButton) {
            self.bianjiBth.hidden = NO;
            if (!model.isDisplayCommitButton) {
                CGRect bianjiFrame = self.bianjiBth.frame;
                bianjiFrame.origin.x = kScreenSize.width - 20 - oneWidth;
                [self.bianjiBth setFrame:bianjiFrame];
            }else {
                CGRect bianjiFrame = self.bianjiBth.frame;
                bianjiFrame.origin.x = kScreenSize.width - 20 - oneWidth*2 - margin;
                [self.bianjiBth setFrame:bianjiFrame];
                
            }
        }else {
            self.bianjiBth.hidden = YES;
            
        }
        
        if (model.isDisplayDeleteButton) {
            self.deleteBth.hidden = NO;
        }else{
            self.deleteBth.hidden = YES;
            
        }
    }else{
        self.lasteView.hidden = YES;
    }

    self.deleteBth.layer.cornerRadius = 15.f;
    self.deleteBth.layer.borderWidth = 1.f;
    self.deleteBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.submitBth.layer.borderWidth = 1.f;
    self.submitBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.submitBth.layer.cornerRadius = 15.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
