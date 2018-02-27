//
//  OrderDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OrderDetailCell.h"
#import "BGControl.h"

@implementation OrderDetailCell {
     NSInteger lpdt036;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModelWith:(NewModel *)model withDict:(NSMutableDictionary *)dict withSelfDict:(NSMutableDictionary *)selfDict withIndex:(NSInteger)index{
    for (UIView *lab in [self.contentView subviews]) {
        if (lab.tag ==1001) {
            [lab removeFromSuperview];
        }
    }
     lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    self.titleLab.text = model.k1dt002;
  
    if (![BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.k1dt003]]) {
          self.guigeLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",model.k1dt003];
        
    }
   self.orderCountLab.text = [NSString stringWithFormat:@"%@%@",@"×",[BGControl notRounding:model.k1dt102 afterPoint:lpdt036]];
  
    NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    
    if (![[NSString stringWithFormat:@"%@",model.k1dt201] isEqualToString:@"0"]) {
       self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    }else{
       self.priceLab.text = @"";
    }
    

    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.iconImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    NSArray *freeArrr = [selfDict valueForKey:@"freeOrders"];
    NSArray *proArrr = [selfDict valueForKey:@"promoOrders"];
    NSInteger count = 0;
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1DT201"]) {
            isPrice = true;
        }
       
    }
   
    
    if (!isPrice) {
        self.priceLab.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
    }
    if (freeArrr.count >0) {
        for (int i = 0; i<freeArrr.count; i++) {
            
            if ([model.k1dt001 isEqualToString:[freeArrr[i] valueForKey:@"k1dt501"]]) {
                UIView *bigview = [[UIView alloc] initWithFrame:CGRectMake(0, count*100 +80, kScreenSize.width, 100)];
                
                bigview.backgroundColor = [UIColor whiteColor];
                bigview.tag = 1001;
                [self.contentView addSubview:bigview];
            for (UIView *lab in [bigview subviews]) {
                    if (lab.tag ==2001) {
                        [lab removeFromSuperview];
                    }
                }
                UIImageView *zengImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 16, 16)];
                zengImgView.image = [UIImage imageNamed:@"zeng.png"];
                
                zengImgView.tag = 2001;
                [bigview addSubview:zengImgView];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 0, kScreenSize.width-41-15, 16)];
                titleLabel.text = @"购买赠送";
                titleLabel.font = [UIFont systemFontOfSize:13];
                titleLabel.textColor = kTextGrayColor;
                titleLabel.tag = 2001;
                [bigview addSubview: titleLabel];
                UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 60, 60)];
//               [headImgView sd_setImageWithURL:[NSURL URLWithString:[freeArrr[i] valueForKey:@"productImagePath"]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
                NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
                [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%@",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",[freeArrr[i] valueForKey:@"k1dt001"],@"imge004=",[freeArrr[i] valueForKey:@"imge004"]]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
                headImgView.tag = 2001;
                [bigview addSubview:headImgView];
                UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, kScreenSize.width - 105, 20)];
                oneLab.text = [freeArrr[i] valueForKey:@"k1dt002"];
                oneLab.font = [UIFont systemFontOfSize:14];
                oneLab.textColor = kBlackTextColor;
                oneLab.tag = 2001;
                [bigview addSubview: oneLab];
                
                UILabel *twoLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, kScreenSize.width - 105, 20)];
                if (![BGControl isNULLOfString:[freeArrr[i] valueForKey:@"k1dt003"]]) {
                    twoLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",[freeArrr[i] valueForKey:@"k1dt003"]];

                }
                twoLab.font = [UIFont systemFontOfSize:14];
                twoLab.textColor = kTextGrayColor;
                twoLab.tag = 2001;
                [bigview addSubview: twoLab];
                UILabel *pLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, (kScreenSize.width - 105)/2, 20)];
                NSString *priceStr = [BGControl notRounding:[freeArrr[i] valueForKey:@"k1dt201"] afterPoint:lpdt042];
                
                if (![[NSString stringWithFormat:@"%@",[freeArrr[i] valueForKey:@"k1dt201"]] isEqualToString:@"0"]) {
                   pLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
                }else{
                   pLab.text =@"";
                }
                
               
                pLab.font = [UIFont systemFontOfSize:14];
                pLab.textColor = kredColor;
                pLab.tag = 2001;
             
                [bigview addSubview: pLab];
                UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pLab.frame), 70, (kScreenSize.width - 105)/2, 20)];
               countLab.text = [NSString stringWithFormat:@"%@%@",@"×",[BGControl notRounding:[freeArrr[i] valueForKey:@"k1dt102"] afterPoint:lpdt036]];;
                countLab.textAlignment = NSTextAlignmentRight;
                countLab.font = [UIFont systemFontOfSize:14];
                countLab.textColor = kBlackTextColor;
                countLab.tag = 2001;
              
                [bigview addSubview: countLab];
                count = count +1;
                if (!isPrice) {
                   pLab.hidden = YES;
                }else{
                   pLab.hidden = NO;
                }
                
            }
        }
    }
    
    if (proArrr.count >0) {
        for (int i = 0; i<proArrr.count; i++) {
            
            if ([model.k1dt001 isEqualToString:[proArrr[i] valueForKey:@"k1dt503"]]) {
                NSComparisonResult resut = [[proArrr[i] valueForKey:@"k1dt102"] compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (resut !=NSOrderedDescending) {
                    return;
                }
                
                UIView *bigview = [[UIView alloc] initWithFrame:CGRectMake(0, count*100 +80, kScreenSize.width, 100)];
             
                bigview.backgroundColor = [UIColor whiteColor];
                bigview.tag = 1001;
                [self.contentView addSubview:bigview];
                for (UIView *lab in [bigview subviews]) {
                    if (lab.tag ==2001) {
                        [lab removeFromSuperview];
                    }
                }
                UIImageView *zengImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 0, 16, 16)];
                zengImgView.image = [UIImage imageNamed:@"hui.png"];
                zengImgView.tag = 2001;
                [bigview addSubview:zengImgView];
                UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 0, kScreenSize.width-41-15, 16)];
                titleLabel.text = @"优惠购买";
                titleLabel.font = [UIFont systemFontOfSize:13];
                titleLabel.textColor = kTextGrayColor;
                titleLabel.tag = 2001;
                [bigview addSubview: titleLabel];
                UIImageView *headImgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 30, 60, 60)];
                NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
                 [headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%@",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",[proArrr[i] valueForKey:@"k1dt001"],@"imge004=",[proArrr[i] valueForKey:@"imge004"]]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
                headImgView.tag = 2001;
                [bigview addSubview:headImgView];
                UILabel *oneLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 30, kScreenSize.width - 105, 20)];
                oneLab.text = [proArrr[i] valueForKey:@"k1dt002"];
                oneLab.font = [UIFont systemFontOfSize:14];
                oneLab.textColor = kBlackTextColor;
                oneLab.tag = 2001;
                [bigview addSubview: oneLab];
                
                UILabel *twoLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 50, kScreenSize.width - 105, 20)];
                if (![BGControl isNULLOfString:[proArrr[i] valueForKey:@"k1dt003"]]) {
                    twoLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",[proArrr[i] valueForKey:@"k1dt003"]];
                    
                }
                twoLab.font = [UIFont systemFontOfSize:14];
                twoLab.textColor = kTextGrayColor;
                twoLab.tag = 2001;
                [bigview addSubview: twoLab];
                UILabel *pLab = [[UILabel alloc] initWithFrame:CGRectMake(90, 70, (kScreenSize.width - 105)/2, 20)];
                NSString *priceStr = [BGControl notRounding:[proArrr[i] valueForKey:@"k1dt201"] afterPoint:lpdt042];
                if (![[NSString stringWithFormat:@"%@",[proArrr[i] valueForKey:@"k1dt201"]] isEqualToString:@"0"]) {
                    pLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
                }else{
                    pLab.text =@"";
                }
                
                pLab.font = [UIFont systemFontOfSize:14];
                pLab.textColor = kredColor;
                pLab.tag = 2001;
                
                [bigview addSubview: pLab];
                UILabel *countLab = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(pLab.frame), 70, (kScreenSize.width - 105)/2, 20)];
                countLab.text = [NSString stringWithFormat:@"%@%@",@"×",[BGControl notRounding:[proArrr[i] valueForKey:@"k1dt102"] afterPoint:lpdt036]];;
                countLab.textAlignment = NSTextAlignmentRight;
                countLab.font = [UIFont systemFontOfSize:14];
                countLab.textColor = kBlackTextColor;
                countLab.tag = 2001;
                
                [bigview addSubview: countLab];
                count = count +1;
                if (!isPrice) {
                    pLab.hidden = YES;
                }else{
                    pLab.hidden = NO;
                }
                
            }
        }
    }
    
        self.fgView = [UIView new];
        self.fgView.tag = 1001;
        self.fgView.backgroundColor = kLineColor;
        self.fgView.frame = CGRectMake(0, 79+100*count, kScreenSize.width, 1);
        [self.contentView addSubview:self.fgView];
  

  
    if (_delegate && [_delegate respondsToSelector:@selector(getHei:withIndex:)]) {
        [_delegate getHei:80+count*100 withIndex:index];
    }

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
