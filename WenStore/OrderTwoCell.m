//
//  OrderTwoCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OrderTwoCell.h"
#import "BGControl.h"

@implementation OrderTwoCell {
    CAShapeLayer *_border;
    orderModel *oneModel;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews {
    _border = [CAShapeLayer layer];
    
    _border.strokeColor = kTabBarColor.CGColor;
    
    _border.fillColor = nil;
    
    _border.path = [UIBezierPath bezierPathWithRect:self.fgview.bounds].CGPath;
    
    _border.frame = self.fgview.bounds;
    
    _border.lineWidth = 1.f;
    
    _border.lineCap = @"square";
    
    _border.lineDashPattern = @[@2.0];
//    self.fgview.backgroundColor = [UIColor clearColor];
    
//    [self.fgview.layer addSublayer:_border];
    [super layoutSubviews];
}

- (void)showModel:(orderModel *)model withDict:(NSMutableDictionary *)dict{
    oneModel = model;
 
    
   
    self.jiImg.hidden = YES;
    if (model.k1mf109 == true) {
        self.jiImg.hidden = NO;
    }
    self.jiaoDate.text = [BGControl dateToDateString:model.k1mf003];
    self.peiDate.text = [BGControl dateToDateString:model.k1mf004];
    self.otherLab.text = model.billStateName;
    
    self.timeLab.hidden = YES;

    
    self.deletBth.layer.cornerRadius = 15.f;
    self.deletBth.layer.borderWidth = 1.f;
    self.deletBth.layer.borderColor = kTabBarColor.CGColor;
    
    self.oneMoreBth.layer.cornerRadius = 15.f;
    self.oneMoreBth.layer.borderWidth = 1.f;
    self.oneMoreBth.layer.borderColor = kTabBarColor.CGColor;
    [self.oneMoreBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
    [self.oneMoreBth setBackgroundColor:[UIColor whiteColor]];
    self.bianjiBth.layer.cornerRadius = 15.f;
    self.bianjiBth.layer.borderWidth = 1.f;
    self.bianjiBth.layer.borderColor = kTabBarColor.CGColor;
    self.subMitBth.layer.borderWidth = 1.f;
    self.subMitBth.layer.borderColor = kTabBarColor.CGColor;
    self.subMitBth.layer.cornerRadius = 15.f;
    self.oneView.hidden = YES;
    self.twoView.hidden = YES;

     CGFloat oneWidth = self.deletBth.frame.size.width;
     CGFloat margin =  CGRectGetMinX(self.oneView.frame) - CGRectGetMaxX(self.twoView.frame) ;
     NSInteger countNum = 4;
//    CGFloat marginOne = 10;
    CGFloat widthOne = CGRectGetWidth(self.subMitBth.frame);
    if (model.isDisplayCommitButton  || model.isDisplayPayBillButton) {
        self.subMitBth.hidden = NO;
        if (model.isDisplayCommitButton) {
             [self.subMitBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
             [self.subMitBth setBackgroundColor:[UIColor whiteColor]];
            [self.subMitBth setTitle:@"提交" forState:UIControlStateNormal];
        }else if (model.isDisplayPayBillButton){
            [self.subMitBth setBackgroundColor:kTabBarColor];
            [self.subMitBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.subMitBth setTitle:@"支付" forState:UIControlStateNormal];
        }
        self.subMitBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth  , 10, widthOne, 30);
        self.bianjiBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth*2 - margin  , 10, widthOne, 30);
         self.deletBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth*3 - margin*2  , 10, widthOne, 30);
    }else{
        self.subMitBth.hidden = YES;
          countNum = countNum - 1;
          self.bianjiBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth  , 10, widthOne, 30);
        self.deletBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth*2 - margin  , 10, widthOne, 30);
    }
    
   
   
    if (model.isDisplayDeleteButton) {
        self.otherLab.textColor = kTabBarColor;
        self.deletBth.hidden = NO;
   
      
    }else{
        
        self.deletBth.hidden = YES;
        countNum = countNum - 1;
        
    }
    if (model.isDisplayEditButton) {
        self.bianjiBth.hidden = NO;
        [self.subMitBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
        [self.subMitBth setBackgroundColor:[UIColor whiteColor]];
    }else {
       self.bianjiBth.hidden = YES;
       countNum = countNum - 1;
        
    }
    if (model.billState == 0) {
        self.oneMoreBth.hidden = YES;
    }else{
        self.oneMoreBth.hidden = NO;
    }
    self.oneMoreBth.frame = CGRectMake(kScreenSize.width-15 - oneWidth *countNum - margin*(countNum-1) , 10, widthOne, 30);
   
    if (model.isDisplayEditButton || model.isDisplayDeleteButton || model.isDisplayCommitButton || model.isDisplayPayBillButton) {
        self.lastView.hidden = NO;
    }else{
        if (model.billState == 0) {
            self.lastView.hidden = YES;
        }else {
            [self.oneMoreBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.oneMoreBth setBackgroundColor:kTabBarColor];
             self.lastView.hidden = NO;
        }
        
    }

    NSInteger lpdt043 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    
    NSString *yunPriceStr = [BGControl notRounding:model.k1mf301 afterPoint:lpdt043];
    self.yunpPrice.text = [NSString stringWithFormat:@"%@%@",@"￥",yunPriceStr];
    self.orderNum.text = model.k1mf100;
    self.sumLab.text = [NSString stringWithFormat:@"%@%@%@",@"已购",model.k1mf303,@"件商品"];

    
    
    CGFloat sumWidth = [BGControl labelAutoCalculateRectWith:self.sumLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    CGRect sumFrame = self.sumLab.frame;
    sumFrame.size.width = sumWidth;
    [self.sumLab setFrame:sumFrame];
    NSString *sumPrice = [BGControl notRounding:model.k1mf302 afterPoint:lpdt043];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@%@",@"合计:",@"￥",sumPrice];
    CGRect priceFrame = self.priceLab.frame;
    priceFrame.size.width =self.contentView.frame.size.width -sumWidth-30;
    self.priceLab.frame = CGRectMake(sumWidth +15, 0, priceFrame.size.width, 50);
    //self.timeLab.text = [NSString stringWithFormat:@"%@%@",@"剩余支付时间: ",@"28:02"];
    
   
    CGFloat timeWidth = [BGControl labelAutoCalculateRectWith:self.timeLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 30)].width;
    CGRect timeFrame = self.timeLab.frame;
    timeFrame.size.width = timeWidth;
    [self.timeLab setFrame: timeFrame];
       NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.priceLab.text];
     NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 4)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,pricelenght-4)];
      self.priceLab.attributedText = priceStr;
  
//    NSMutableAttributedString *timeAStr = [[NSMutableAttributedString alloc] initWithString:self.timeLab.text];
//    NSInteger timelLenght = timeAStr.length;
//    [timeAStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 8)];
//    [timeAStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(7,timelLenght-8)];
//    self.timeLab.attributedText = timeAStr;
 
    
//    self.deletBth.hidden = YES;

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
        self.priceLab.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
    }

    
}

- (IBAction)buttonClick:(UIButton *)sender {
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(postoneStr:twoStr:withCount:withModel:)]) {
        [_orderDelegate postoneStr:[NSString stringWithFormat:@"%ld",sender.tag] twoStr:oneModel.k1mf100 withCount:oneModel.k1mf303 withModel:oneModel ];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
