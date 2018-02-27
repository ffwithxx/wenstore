//
//  AddPurchaseCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddPurchaseCell.h"
#import "BGControl.h"
#import <SDWebImage/UIImageView+WebCache.h>

@implementation AddPurchaseCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
    NSInteger lpdt043;
    AddPurchaseModel *oneModel;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCell];
    }
    return self;
}
- (void)customCell {
    for (UIView *view in [self.contentView subviews]) {
        if (view.tag ==1001) {
            [view removeFromSuperview];
        }
    }
    self.commodityImg = [UIImageView new];
    self.nameLab = [UILabel new];
    self.specificationsLab = [UILabel new];
    self.priceLab = [UILabel new];
    self.orderCountLab = [UILabel new];
    self.orderButton = [UIButton new];
    self.plusBth = [UIButton new];
    self.minusBth = [UIButton new];
    self.jianImg = [UIImageView new];
    self.jiaImg = [UIImageView new];
    self.bottomView = [UIView new];
    self.jishuView = [UIView new];
    self.jijiaView = [UIView new];
    self.numLab = [UILabel new];
    self.jipriceNum = [UILabel new];
    
    self.orderPriceCountLab = [UILabel new];
    self.jijiaPlusImg = [UIImageView new];
    self.jijiaMinImg = [UIImageView new];
    
    self.jijiaPlusBth = [UIButton new];
    self.jijiaMinBth = [UIButton new];
    self.orderPriceCountBth = [UIButton new];
    
    
    self.oneFgView = [UIView new];
    self.twoFgView = [UIView new];
    self.threeFgView = [UIView new];
    self.changePriceBth = [UIButton new];
    [self.contentView addSubview:self.changePriceBth];
    
    [self.contentView addSubview:self.commodityImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.specificationsLab];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.jipriceNum];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.orderCountLab];
    [self.contentView addSubview:self.orderButton];
    
    [self.contentView addSubview:self.plusBth];
    [self.contentView addSubview:self.minusBth];
    [self.contentView addSubview:self.oneFgView];
    [self.contentView addSubview:self.twoFgView];
    [self.contentView addSubview:self.jiaImg];
    [self.contentView addSubview:self.jianImg];
    [self.contentView addSubview:self.orderPriceCountLab];
    [self.contentView addSubview:self.jijiaPlusImg];
    [self.contentView addSubview:self.jijiaMinImg];
    
    [self.contentView addSubview:self.orderPriceCountBth];
    [self.contentView addSubview:self.jijiaPlusBth];
    [self.contentView addSubview:self.jijiaMinBth];
    [self.contentView addSubview:self.bottomView];
    
    [self.changePriceBth setTitleColor:kTabBarColor forState:UIControlStateNormal];
    [self.changePriceBth setTitle:@"修改单价" forState:UIControlStateNormal];
    self.changePriceBth.layer.cornerRadius = 10.f;
    self.changePriceBth.layer.borderColor = [kTabBarColor CGColor];
    self.changePriceBth.layer.borderWidth = 1.f;
    self.changePriceBth.titleLabel.font = [UIFont systemFontOfSize:15];
    
    self.nameLab.textColor = kBlackTextColor;
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.specificationsLab.textColor = kTextGrayColor;
    self.specificationsLab.font = [UIFont systemFontOfSize:14];
    self.priceLab.textColor = kredColor;
    self.priceLab.font = [UIFont systemFontOfSize:13];
    self.orderCountLab.textColor = kBlackTextColor;
    self.orderPriceCountLab.textColor = kBlackTextColor;
    self.orderCountLab.font = [UIFont systemFontOfSize:14];
    self.orderPriceCountLab.font = [UIFont systemFontOfSize:14];
    self.orderCountLab.textAlignment = NSTextAlignmentCenter;
    self.orderPriceCountLab.textAlignment = NSTextAlignmentCenter;
    self.numLab.textColor = kTextGrayColor;
    self.jipriceNum.textColor = kTextGrayColor;
    self.orderPriceCountLab.textColor = kBlackTextColor;
    self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.jiaImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.jijiaMinImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.jijiaPlusImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.oneFgView.backgroundColor = kTextLighColor;
    self.twoFgView.backgroundColor = kTextLighColor;
    self.bottomView.backgroundColor = kBackGroungColor;
    self.plusBth.tag = 1002;
    self.minusBth.tag = 1003;
    self.orderButton.tag = 1004;
    self.jijiaPlusBth.tag = 1005;
    self.jijiaMinBth.tag = 1006;
    self.orderPriceCountBth.tag = 1007;
    [self.plusBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.minusBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.orderButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.jijiaPlusBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.jijiaMinBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.orderPriceCountBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
     [self.changePriceBth addTarget:self action:@selector(changeClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)layoutSubviews {
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame)-10, self.contentView.frame.size.width, 10);
    [super layoutSubviews];
    
}

- (void)showModelWith:(AddPurchaseModel *)model {
    oneModel = model;
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt042"] ] integerValue];
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    CGFloat bei = 3;
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
        bei = 4;
    }
    
    CGFloat oneHei = Imgwidth/3;
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    self.commodityImg.frame = CGRectMake(marginWidth, marginWidth, Imgwidth, Imgwidth);
    self.nameLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    self.specificationsLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth+oneHei, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    self.priceLab.frame = CGRectMake(marginWidth, marginWidth*2+Imgwidth, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
   self.oneFgView.frame = CGRectMake(0, Imgwidth+marginWidth*2+oneHei, kScreenSize.width-100, 1);
    self.numLab.frame = CGRectMake(marginWidth, Imgwidth+marginWidth*3+1+oneHei, 150, shopWidth);
    self.jiaImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*3+1+oneHei, shopWidth, shopWidth);
    self.jianImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*3+1+oneHei, shopWidth, shopWidth);
    self.plusBth.frame = _jiaImg.frame;
    //    self.plusBth.backgroundColor = kTabBarColor;
    self.minusBth.frame =  _jianImg.frame;
    
    self.orderCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*3+1+oneHei, numWidth, shopWidth);
    //    self.orderCountLab.backgroundColor = kTabBarColor;
    self.orderButton.frame = self.orderCountLab.frame;
    self.twoFgView.frame =  CGRectMake(0, Imgwidth+marginWidth*4+1+shopWidth+oneHei, kScreenSize.width-100, 1);
    self.jipriceNum.frame = CGRectMake(marginWidth,Imgwidth+marginWidth*5+1+shopWidth + oneHei, 150, shopWidth);
    self.jijiaPlusImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*5+1+shopWidth +oneHei, shopWidth, shopWidth);
    self.jijiaMinImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, shopWidth, shopWidth);
    
    self.orderPriceCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, numWidth, shopWidth);
    self.jijiaPlusImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*5+1+shopWidth +oneHei, shopWidth, shopWidth);
    self.jijiaMinImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, shopWidth, shopWidth);
    self.orderPriceCountBth.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, numWidth, shopWidth);
     self.changePriceBth.frame  =  CGRectMake(Imgwidth+marginWidth*bei, Imgwidth+marginWidth*2, 80, 20);
    self.nameLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];

    self.numLab.text = [NSString stringWithFormat:@"%@%@%@",@"计数(",model.k1dt005,@")"];
    self.jipriceNum.text = [NSString stringWithFormat:@"%@%@%@",@"计价(",model.k1dt011UnitText,@")"];
    if ([model.k1dt005 isEqualToString:model.k1dt011UnitText]) {
        self.jijiaPlusBth.enabled = NO;
        self.jijiaMinBth.enabled = NO;
        self.jijiaMinImg.image = [UIImage imageNamed:@"jiangray.png"];
        self.jijiaPlusImg.image = [UIImage imageNamed:@"jiagray.png"];
    }else {
        self.jijiaPlusBth.enabled = YES;
        self.jijiaMinBth.enabled = YES;
        self.jijiaMinImg.image = [UIImage imageNamed:@"jianGree.png"];
        self.jijiaPlusImg.image = [UIImage imageNamed:@"jiaGree.png"];
        
    }
    self.orderPriceCountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.jijiaOrderCount afterPoint:lpdt036]];
    self.orderCountLab.text =  [NSString stringWithFormat:@"%@",[BGControl notRounding:model.orderCount afterPoint:lpdt036]];;
    
    if (![[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"] ||![[NSString stringWithFormat:@"%@",model.jijiaOrderCount] isEqualToString:@"0"]) {
        
        self.priceLab.text = [NSString stringWithFormat:@"￥%@/%@",[BGControl notRounding:model.k1dt201Price afterPoint:lpdt042],model.k1dt011UnitText];
    }else{
        self.priceLab.text = @"";
    }
    self.specificationsLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",model.k1dt003];
    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"] ) {
        self.jianImg.hidden = YES;
        self.minusBth.hidden = YES;
        self.orderCountLab.hidden = YES;
        self.orderButton.hidden = YES;
    }else {
        self.jianImg.hidden = NO;
        self.minusBth.hidden = NO;
        self.orderCountLab.hidden = NO;
        self.orderButton.hidden = NO;
        
    }
    if ([[NSString stringWithFormat:@"%@",model.jijiaOrderCount] isEqualToString:@"0"] ) {
        self.jijiaMinImg.hidden = YES;
        self.jijiaMinBth.hidden = YES;
        self.orderPriceCountBth.hidden = YES;
        self.orderPriceCountLab.hidden = YES;
    }else {
        self.jijiaMinImg.hidden = NO;
        self.jijiaMinBth.hidden = NO;
        self.orderPriceCountBth.hidden = NO;
        self.orderPriceCountLab.hidden = NO;
        
    }

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
        self.changePriceBth.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
        self.changePriceBth.hidden = NO;
    }
    
    
}
-(void)buttonClick:(UIButton *)bth {
    if (bth.tag == 1004 || bth.tag == 1007) {
        if (_inputDelegate && [_inputDelegate respondsToSelector:@selector(procurementWithModel:withTag:)]) {
            [_inputDelegate procurementWithModel:oneModel withTag:bth.tag ];
        }

    }else{
        NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:@"0"];
        NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1"]];
        
        if (bth.tag == 1002) {
            NSDecimalNumber*jiafa = [NSDecimalNumber decimalNumberWithString:@"0"];
            NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.orderCount]];
            jiafa = [dec decimalNumberByAdding:jiafa1];
            
            numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
            
            
        }else if (bth.tag == 1003) {
            NSComparisonResult compar = [ oneModel.orderCount compare:numCount];
            if (compar != NSOrderedDescending) {
            }else {
                NSDecimalNumber*jianfa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.orderCount]] decimalNumberBySubtracting:jiafa1];
                numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jianfa afterPoint:lpdt036]];
            }
            
        }else if (bth.tag == 1005) {
            NSDecimalNumber*jiafa = [NSDecimalNumber decimalNumberWithString:@"0"];
            NSDecimalNumber *dec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.jijiaOrderCount]];
            jiafa = [dec decimalNumberByAdding:jiafa1];
            
            numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
            
        }else if (bth.tag == 1006) {
            NSComparisonResult compar = [ oneModel.jijiaOrderCount compare:numCount];
            if (compar != NSOrderedDescending) {
            }else {
                NSDecimalNumber*jianfa = [oneModel.jijiaOrderCount decimalNumberBySubtracting:jiafa1];
                numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jianfa afterPoint:lpdt036]];
            }
            
        }        if (_purchaseDelegate && [_purchaseDelegate respondsToSelector:@selector(procurementWithModel:withTag:withCount:)]) {
            [_purchaseDelegate procurementWithModel:oneModel withTag:bth.tag withCount:numCount];
        }

    }

}
- (void)changeClick:(UIButton *)bth {
    if (_changeDelegate && [_changeDelegate respondsToSelector:@selector(changeWithModel:)]) {
        [_changeDelegate changeWithModel:oneModel];
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
