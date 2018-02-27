//
//  AddStocktakVCCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddStocktakVCCell.h"
#import "BGControl.h"

@implementation AddStocktakVCCell {
    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;
    NSInteger lpdt036;
    NSInteger lpdt042;
    CGFloat oneWidth;
    CGFloat shopWidth;
    StocktakModel *oneModel;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(StocktakModel *)model withType:(NSString *)typeStr{
    oneModel = model;
    for (UIView *view in [self.oneView subviews]) {
        if (view.tag ==1001 ||view.tag == 1002 ||view.tag ==1003 ||view.tag == 1004 ||view.tag == 1005 ||view.tag == 1006 || view.tag ==1007 ||view.tag == 1008 || view.tag ==1009 ||view.tag == 1010) {
            [view removeFromSuperview];
        }
    }
    for (UIView *view in [self.twoView subviews]) {
        if (view.tag ==1001 ||view.tag == 1002 ||view.tag ==1003 ||view.tag == 1004 ||view.tag == 1005 ||view.tag == 1006 || view.tag ==1007 ||view.tag == 1008 || view.tag ==1009 ||view.tag == 1010) {
            [view removeFromSuperview];
        }
    }
    for (UIView *view in [self.threeView subviews]) {
        if (view.tag ==1001 ||view.tag == 1002 ||view.tag ==1003 ||view.tag == 1004 ||view.tag == 1005 ||view.tag == 1006 || view.tag ==1007 ||view.tag == 1008 || view.tag ==1009 ||view.tag == 1010) {
            [view removeFromSuperview];
        }
    }


  
    self.cancleBth.tag = 901;
   
    
    self.maxPlusImg = [UIImageView new];
    self.maxPlusImg.tag = 1001;
   
    [self.oneView addSubview:self.maxPlusImg];
    self.maxMinImg = [UIImageView new];
     self.maxMinImg.tag = 1001;
    [self.oneView addSubview:self.maxMinImg];
    self.maxPlusImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.maxMinImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.maxPlusBth = [UIButton new];
    self.maxPlusBth.tag = 1002;
    [self.oneView addSubview:self.maxPlusBth];
    self.maxMinbth = [UIButton new];
    self.maxMinbth.tag = 1003;
    [self.oneView addSubview:self.maxMinbth];
    
    self.maxcountLab = [UILabel new];
    self.maxcountLab.tag = 1001;
    self.maxcountLab.textAlignment = NSTextAlignmentCenter;
    self.maxcountLab.textColor = kBlackTextColor;
    self.maxcountLab.font = [UIFont systemFontOfSize:14];
    self.maxcountBth = [UIButton new];
    self.maxcountBth.tag = 1004;
    [self.oneView addSubview:self.maxcountLab];
    [self.oneView addSubview:self.maxcountBth];
    
    self.middlePlusImg = [UIImageView new];
    self.middlePlusImg.tag = 1001;
    [self.twoView addSubview:self.middlePlusImg];
    self.middleMinImg = [UIImageView new];
    self.middleMinImg.tag = 1001;
    [self.twoView addSubview:self.middleMinImg];
    self.middlePlusBth = [UIButton new];
    self.middlePlusBth.tag = 1005;
    [self.twoView addSubview:self.middlePlusBth];
    self.middleMinbth = [UIButton new];
    self.middleMinbth.tag = 1006;
    [self.twoView addSubview:self.middleMinbth];

    self.middlecountLab = [UILabel new];
    self.middlecountLab.textAlignment = NSTextAlignmentCenter;
    self.middlecountLab.textColor = kBlackTextColor;
    self.middlecountLab.font = [UIFont systemFontOfSize:14];
    self.middlecountLab.tag = 1001;
    self.middlecountBth = [UIButton new];
    self.middlecountBth.tag = 1007;
    [self.twoView addSubview:self.middlecountLab];
    [self.twoView addSubview:self.middlecountBth];
    
    
    self.middlePlusImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.middleMinImg.image = [UIImage imageNamed:@"jianGree.png"];
    
    self.minPlusImg = [UIImageView new];
    self.minPlusImg.tag = 1001;
    [self.threeView addSubview:self.minPlusImg];
    self.minMinImg = [UIImageView new];
    self.minMinImg.tag = 1001;
    [self.threeView addSubview:self.minMinImg];
    self.minPlusBth = [UIButton new];
    self.minPlusBth.tag = 1008;
    [self.threeView addSubview:self.minPlusBth];
    self.minMinbth = [UIButton new];
    self.minMinbth.tag = 1009;
    [self.threeView addSubview:self.minMinbth];
    
    self.mincountLab = [UILabel new];
    self.mincountLab.tag = 1001;
    self.mincountBth = [UIButton new];
    self.mincountBth.tag = 1010;
    [self.threeView addSubview:self.mincountLab];
    [self.threeView addSubview:self.mincountBth];
    self.mincountLab.textAlignment = NSTextAlignmentCenter;
    self.mincountLab.textColor = kBlackTextColor;
     self.mincountLab.font = [UIFont systemFontOfSize:14];
    self.minPlusImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.minMinImg.image = [UIImage imageNamed:@"jianGree.png"];
    
    [self.maxPlusBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
    [self.maxMinbth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.maxcountBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.middlePlusBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.middleMinbth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.middlecountBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.minPlusBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.minMinbth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.mincountBth addTarget:self action:@selector(maxplusclick:) forControlEvents:UIControlEventTouchUpInside];
     [self.cancleBth addTarget:self action:@selector(cancleClick) forControlEvents:UIControlEventTouchUpInside];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt042"] ] integerValue];
    self.titleLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    oneHei = self.oneLab.frame.size.height;
    oneWidth = self.oneView.frame.size.width;
    maginWidth = 15;
    imgWidth = 80;
    shopWidth = 24;
   self.cancleBth.frame = CGRectMake(self.contentView.frame.size.width-maginWidth-60, 5, 60, 30);
    if (kScreenSize.width == 320) {
        oneHei = 20;
        maginWidth = 10;
        imgWidth = 60;
        oneHei = 20;
        maginWidth = 10;
        imgWidth = 60;
        shopWidth = 18;
        oneWidth = self.contentView.frame.size.width-80;
         self.detailView.frame = CGRectMake(0, 40, self.contentView.frame.size.width, 80);
        self.headImg.frame = CGRectMake(10, 10, 60, 60);
        self.oneView.frame = CGRectMake(80, 10, self.contentView.frame.size.width-80, oneHei);
        self.twoView.frame = CGRectMake(80, 30, self.contentView.frame.size.width-80, oneHei);
        self.threeView.frame = CGRectMake(80, 50, self.contentView.frame.size.width-80, oneHei);
       
        self.xiaView.frame = CGRectMake(0, 120, self.contentView.frame.size.width, 40);
        self.cancleBth.frame = CGRectMake(self.topView.frame.size.width-maginWidth-50, 5, 50, 30);
    }
   
    
    self.cancleBth.layer.cornerRadius = 15.f;
    self.cancleBth.layer.borderColor = kTextGrayColor.CGColor;
    self.cancleBth.layer.borderWidth = 1.f;
     CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    self.maxPlusImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth , 1, shopWidth, shopWidth);
    self.maxPlusBth.frame = self.maxPlusImg.frame;
    self.maxMinImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth*2 - numWidth , 1, shopWidth, shopWidth);
     self.maxMinbth.frame = self.maxMinImg.frame;
    self.maxcountLab.frame = CGRectMake(oneWidth - maginWidth - shopWidth - numWidth , 1, numWidth, shopWidth);
    self.maxcountBth.frame = self.maxcountLab.frame;
    
    self.middlePlusImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth , 1, shopWidth, shopWidth);
    self.middlePlusBth.frame = self.middlePlusImg.frame;
    self.middleMinImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth*2 - numWidth ,  1, shopWidth, shopWidth);
    self.middleMinbth.frame = self.middleMinImg.frame;
    self.middlecountLab.frame = CGRectMake(oneWidth - maginWidth - shopWidth - numWidth ,  1, numWidth, shopWidth);
    self.middlecountBth.frame = self.middlecountLab.frame;
    
    self.minPlusImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth , 1, shopWidth, shopWidth);
    self.minPlusBth.frame = self.minPlusImg.frame;
    self.minMinImg.frame = CGRectMake(oneWidth - maginWidth - shopWidth*2 - numWidth ,  1, shopWidth, shopWidth);
    self.minMinbth.frame = self.minMinImg.frame;
    self.mincountLab.frame = CGRectMake(oneWidth - maginWidth - shopWidth - numWidth ,  1, numWidth, shopWidth);
    self.mincountBth.frame = self.mincountLab.frame;
    NSInteger danweiCount = 0;
    NSInteger Count = 0;
    if (![BGControl isNULLOfString:model.k1dt011d]) {
        self.oneLab.text = [NSString stringWithFormat:@"%@:%@",@"单位",model.k1dt011];
        
        danweiCount = danweiCount + 1;
        
    }else {
         self.oneLab.text = @"";
         self.oneView.hidden = YES;
    }
    if (![BGControl isNULLOfString:model.k1dt012d]) {
        self.twoLab.text = [NSString stringWithFormat:@"%@:%@",@"单位",model.k1dt012];
        danweiCount = danweiCount + 1;
    }else {
        self.twoLab.text = @"";
        self.twoView.hidden = YES;
    }
    if (![BGControl isNULLOfString:model.k1dt013d]) {
        self.threeLab.text = [NSString stringWithFormat:@"%@:%@",@"单位",model.k1dt013];
        danweiCount = danweiCount + 1;
    }else {
        self.threeLab.text = @"";
          self.threeView.hidden = YES;
    }
       if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guiGeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    CGFloat guiWidth = [BGControl labelAutoCalculateRectWith:self.guiGeLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 40)].width;
    CGRect guiFrame = self.guiGeLab.frame;
    guiFrame.size.width = guiWidth;
    [self.guiGeLab setFrame:guiFrame];
    
    CGRect countFrame = self.countLab.frame;
    countFrame.origin.x = maginWidth+guiWidth;
    
    countFrame.size.width = self.contentView.frame.size.width - maginWidth*2 - guiWidth;
    [self.countLab setFrame:countFrame];
    self.countLab.text = [NSString stringWithFormat:@"%@%@",@"数量:",[BGControl notRounding:model.k1dt101Count afterPoint:lpdt036]];
    BOOL *yincang ;

    
    
    if ([[NSString stringWithFormat:@"%@",model.k1dt011nCount] isEqualToString:@"0"]&& model.isCancle) {
        self.maxcountLab.hidden = YES;
        self.maxcountBth.hidden = YES;
        self.maxMinImg.hidden = YES;
        self.maxMinbth.hidden = YES;
        
    }else {
        self.maxcountLab.hidden = NO;
        self.maxcountBth.hidden = NO;
        self.maxMinImg.hidden = NO;
        self.maxMinbth.hidden = NO;
        self.maxcountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt011nCount afterPoint:lpdt036]];
        Count = Count + 1;
    }
    if ([[NSString stringWithFormat:@"%@",model.k1dt012nCount] isEqualToString:@"0"] && model.isCancle) {
        self.middlecountLab.hidden = YES;
        self.middlecountBth.hidden = YES;
        self.middleMinImg.hidden = YES;
        self.middleMinbth.hidden = YES;
    }else {
        self.middlecountLab.hidden = NO;
        self.middlecountBth.hidden = NO;
        self.middleMinImg.hidden = NO;
        self.middleMinbth.hidden = NO;
         Count = Count + 1;
          self.middlecountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt012nCount afterPoint:lpdt036]];
        
    }
    if ([[NSString stringWithFormat:@"%@",model.k1dt013nCount] isEqualToString:@"0"] && model.isCancle) {
        self.mincountLab.hidden = YES;
        self.mincountBth.hidden = YES;
        self.minMinImg.hidden = YES;
        self.minMinbth.hidden = YES;
    }else {
        self.mincountLab.hidden = NO;
        self.mincountBth.hidden = NO;
        self.minMinImg.hidden = NO;
        self.minMinbth.hidden = NO;
         Count = Count + 1;
      self.mincountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt013nCount afterPoint:lpdt036]];
    }
    if (danweiCount == 0) {
        self.oneLab.text = [NSString stringWithFormat:@"%@:%@",@"单位",model.k1dt005];
        self.oneView.hidden = NO;
        if ([[NSString stringWithFormat:@"%@",model.k1dt101Count] isEqualToString:@"0"] && model.isCancle) {
            self.maxcountLab.hidden = YES;
            self.maxcountBth.hidden = YES;
            self.maxMinImg.hidden = YES;
            self.maxMinbth.hidden = YES;
        }else {
            self.maxcountLab.hidden = NO;
            self.maxcountBth.hidden = NO;
            self.maxMinImg.hidden = NO;
            self.maxMinbth.hidden = NO;
             self.maxcountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt101Count afterPoint:lpdt036]];
            self.middlecountLab.hidden = NO;
            self.middlecountBth.hidden = NO;
            self.middleMinImg.hidden = NO;
            self.middleMinbth.hidden = NO;
            Count = Count + 1;
            self.middlecountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt012nCount afterPoint:lpdt036]];
            self.mincountLab.hidden = NO;
            self.mincountBth.hidden = NO;
            self.minMinImg.hidden = NO;
            self.minMinbth.hidden = NO;
            Count = Count + 1;
            self.mincountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt013nCount afterPoint:lpdt036]];
            
            
        }

    }else {
        if ([[NSString stringWithFormat:@"%@",model.k1dt011nCount] isEqualToString:@"0"] &&model.isCancle) {
            self.maxcountLab.hidden = YES;
            self.maxcountBth.hidden = YES;
            self.maxMinImg.hidden = YES;
            self.maxMinbth.hidden = YES;
        }else {
            self.maxcountLab.hidden = NO;
            self.maxcountBth.hidden = NO;
            self.maxMinImg.hidden = NO;
            self.maxMinbth.hidden = NO;
            self.maxcountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt011nCount afterPoint:lpdt036]];
        }
    }

    if (Count == 0) {
        self.cancleBth.hidden = YES;
        self.countLab.hidden = YES;
    }else {
        self.cancleBth.hidden = NO;
        self.countLab.hidden = NO;
    }

    //self.maxPlusBth.backgroundColor = kredColor;
}

-(void)maxplusclick:(UIButton *)bth {
    if (bth.tag == 1004 ||bth.tag == 1007 ||bth.tag == 1010) {
        if (_inputDelegate && [_inputDelegate respondsToSelector:@selector(stockWithModel:withTag:)]) {
            [_inputDelegate stockWithModel:oneModel withTag:bth.tag];
        }

        
    }else {
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1"]];
        if (bth.tag == 1002) {
            NSDecimalNumber*jiafa = [NSDecimalNumber decimalNumberWithString:@"0"];
            if ([BGControl isNULLOfString:oneModel.k1dt011d  ]) {
                jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.k1dt101Count]]  decimalNumberByAdding:jiafa1];
            }else {
                jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.k1dt011nCount]] decimalNumberByAdding:jiafa1];
            }
            
            
            numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
        }else if (bth.tag == 1003) {
            NSComparisonResult compar;
            if ([BGControl isNULLOfString:oneModel.k1dt011d  ]) {
                
                compar = [ oneModel.k1dt101Count compare:numCount];
            }else {
                
                compar = [ oneModel.k1dt011nCount compare:numCount];
            }
            
            
            if (compar != NSOrderedDescending) {
            }else {
                NSDecimalNumber*jianfa = [NSDecimalNumber decimalNumberWithString:@"0"];
                if ([BGControl isNULLOfString:oneModel.k1dt011d  ]) {
                    jianfa = [oneModel.k1dt101Count decimalNumberBySubtracting:jiafa1];
                }else{
                    jianfa = [oneModel.k1dt011nCount decimalNumberBySubtracting:jiafa1];
                }
                
                numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jianfa afterPoint:lpdt036]];
            }
        }else if (bth.tag == 1005) {
            NSDecimalNumber*jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.k1dt012nCount]]  decimalNumberByAdding:jiafa1];
            numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
            
        }else if (bth.tag == 1006) {
            NSComparisonResult compar = [ oneModel.k1dt012nCount compare:numCount];
            if (compar != NSOrderedDescending) {
            }else {
                NSDecimalNumber*jianfa = [oneModel.k1dt012nCount decimalNumberBySubtracting:jiafa1];
                numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jianfa afterPoint:lpdt036]];
            }
            
        }else if (bth.tag == 1008) {
            NSDecimalNumber*jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.k1dt013nCount]] decimalNumberByAdding:jiafa1];
            numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
        }else if (bth.tag == 1009) {
            NSComparisonResult compar = [ oneModel.k1dt013nCount compare:numCount];
            if (compar != NSOrderedDescending) {
            }else {
                NSDecimalNumber*jianfa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.k1dt013nCount]] decimalNumberBySubtracting:jiafa1];
                numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jianfa afterPoint:lpdt036]];
            }
            
        }if (_stockDelegate && [_stockDelegate respondsToSelector:@selector(stockWithModel:withTag:with:)]) {
            [_stockDelegate stockWithModel:oneModel withTag:bth.tag with:numCount];
        }

    }
    

   }
-(void)cancleClick {
    if (_cancleDelegate && [_cancleDelegate respondsToSelector:@selector(cancle:)]) {
        [_cancleDelegate cancle:oneModel];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
