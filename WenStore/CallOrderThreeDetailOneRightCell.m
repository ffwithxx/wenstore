//
//  CallOrderThreeDetailOneRightCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeDetailOneRightCell.h"
#import "BGControl.h"

@implementation CallOrderThreeDetailOneRightCell{
 EditModel *oneModel;
    NSDecimalNumber *priceOne;
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
    self.stockLab = [UILabel new];
    self.priceLab = [UILabel new];
    self.orderCountLab = [UILabel new];
     self.orderButton = [UIButton new];
    self.plusBth = [UIButton new];
    self.minusBth = [UIButton new];
    
    
    
    self.jianImg = [UIImageView new];
    self.jiaImg = [UIImageView new];
    self.fgView = [UIView new];
    self.bottomView = [UIView new];
    
    self.peiLab = [UILabel new];
    self.shouLab = [UILabel new];
    self.peiCountLab = [UILabel new];
    self.peiLab.font = [UIFont systemFontOfSize:14];
    self.shouLab.font = [UIFont systemFontOfSize:14];
    self.peiCountLab.font = [UIFont systemFontOfSize:14];
    self.peiLab.textColor = kTextGrayColor;
    self.shouLab.textColor = kTextGrayColor;
    self.peiCountLab.textColor = kTextGrayColor;
    self.shouLab.textAlignment = NSTextAlignmentRight;
    self.peiLab.textAlignment = NSTextAlignmentRight;
    self.peiCountLab.textAlignment = NSTextAlignmentCenter;
    
     [self.contentView addSubview:self.shouLab];
    [self.contentView addSubview:self.peiCountLab];
    [self.contentView addSubview:self.commodityImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.specificationsLab];
    [self.contentView addSubview:self.stockLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.orderCountLab];
     [self.contentView addSubview:self.orderButton];
    [self.contentView addSubview:self.plusBth];
    [self.contentView addSubview:self.minusBth];
    
    
    
    [self.contentView addSubview:self.jiaImg];
    [self.contentView addSubview:self.jianImg];
    [self.contentView addSubview:self.fgView];
    [self.contentView addSubview:self.bottomView];
    
    self.nameLab.textColor = kBlackTextColor;
    self.nameLab.font = [UIFont systemFontOfSize:15];
    
    self.specificationsLab.textColor = kTextGrayColor;
    self.specificationsLab.font = [UIFont systemFontOfSize:14];
    
    self.stockLab.textColor = kTextGrayColor;
    self.stockLab.font = [UIFont systemFontOfSize:14];
    
    self.priceLab.textColor = kredColor;
    self.priceLab.font = [UIFont systemFontOfSize:14];
    
    self.orderCountLab.textColor = kTextGrayColor;
    self.orderCountLab.font = [UIFont systemFontOfSize:14];
    [self.contentView addSubview:self.peiLab];
    
}
- (void)layoutSubviews {
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame)-10, self.contentView.frame.size.width, 10);
    [super layoutSubviews];
}

-(void)plusclick{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber*jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.numCount]] decimalNumberByAdding:jiafa1];
    NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
    self.numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:)]) {
        [_orderDelegate getOrderCount:self.numCount withKey:oneModel.keyStr withIndex:oneModel.index withPrice:[NSDecimalNumber decimalNumberWithString:@"0"]];
    }
 
}
-(void)clickMin:(UIButton *)bth{
    
//    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.multipleBase]];
      NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber*jiafa = [self.numCount decimalNumberBySubtracting:jiafa1];
    NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
    self.numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:)]) {
        [_orderDelegate getOrderCount:self.numCount withKey:oneModel.keyStr withIndex:oneModel.index withPrice:[NSDecimalNumber decimalNumberWithString:@"0"]];
    }

    
}
-(void)other:(UIButton *)bth{
    
}
- (void)showModel:(EditModel *)model{
     NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
    }
    CGFloat oneHei = Imgwidth/3;
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    
     self.commodityImg.frame = CGRectMake(marginWidth, marginWidth, Imgwidth, Imgwidth);
     self.nameLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
       self.specificationsLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth+oneHei, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
//    self.stockLab.frame = CGRectMake(110, 55, self.contentView.frame.size.width - 125, 20);
    self.jiaImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*2+shopWidth, shopWidth, shopWidth);
    self.jianImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*2+shopWidth, shopWidth, shopWidth);
    self.shouLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth-70, Imgwidth+marginWidth*2+shopWidth, 65, shopWidth);
    self.shouLab.text = @"收货量:";
    self.peiLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth-70, Imgwidth+marginWidth*2, 65, shopWidth);
    self.peiLab.text = @"配货量:";
    
    self.plusBth.frame = _jiaImg.frame;
    //    self.plusBth.backgroundColor = kTabBarColor;
    self.minusBth.frame =  _jianImg.frame;
    self.peiCountLab.frame =CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*2, numWidth, shopWidth);
    self.orderCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*2+shopWidth, numWidth, shopWidth);
    //    self.orderCountLab.backgroundColor = kTabBarColor;
    self.orderButton.frame = self.orderCountLab.frame;
    
    self.priceLab.frame = CGRectMake(marginWidth, Imgwidth+marginWidth*2, 120, oneHei);
    self.orderCountLab.textAlignment = NSTextAlignmentCenter;
    //    self.orderCountLab.backgroundColor = [UIColor redColor];
//    self.fgView.frame = CGRectMake(marginWidth, 120, self.contentView.frame.size.width-marginWidth*2, 1);
    self.fgView.backgroundColor = kLineColor;
    self.bottomView.backgroundColor = kBackGroungColor;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
      self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.jiaImg.image = [UIImage imageNamed:@"jiaGree.png"];
    [self.minusBth addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
    [self.plusBth addTarget:self action:@selector(plusclick) forControlEvents:UIControlEventTouchUpInside];
       oneModel = model;
    self.numCount =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]];;
;
  self.peiCountLab.text = [BGControl notRounding:model.k1dt102 afterPoint:lpdt036];
   self.orderCountLab.text = [BGControl notRounding:model.orderCount afterPoint:lpdt036];
    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
        _jianImg.hidden = YES;
        self.minusBth.hidden = YES;
        self.orderCountLab.hidden = YES;
        self.orderButton.hidden = YES;
    }else {
        _jianImg.hidden = NO;
        self.minusBth.hidden = NO;
        self.orderCountLab.hidden = NO;
        self.orderButton.hidden = NO;
    }
   self.nameLab.text = model.k1dt002;
    if ([BGControl isNULLOfString:model.k1dt003]) {
        self.specificationsLab.text = @"";
    }else {
        self.specificationsLab.text = [NSString stringWithFormat:@"%@ %@",@"规格:",model.k1dt003];
    }
    
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.orderCountLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
    NSInteger lpdt042 = [[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt042"] integerValue];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    priceOne = [NSDecimalNumber decimalNumberWithString:priceStr];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
    CGFloat pWidth = [BGControl labelAutoCalculateRectWith:self.priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;

    [self.orderButton addTarget:self action:@selector(clickOrder:) forControlEvents:UIControlEventTouchUpInside];

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
    if (![self.orderCountLab.text isEqualToString:self.peiCountLab.text]) {
        self.orderCountLab.textColor = kredColor;
    }else {
        self.orderCountLab.textColor = kTextGrayColor;
    }
}

-(void)clickOrder:(UIButton *)bth {
    
    if (_TanDelegate &&[_TanDelegate respondsToSelector:@selector(getwithKey:withIndex:withModel:withweizhi:)]) {
        [_TanDelegate getwithKey:oneModel.keyStr withIndex:oneModel.index withModel:oneModel withweizhi:@"right"];
    }
    
}
- (void)showOrderNums:(NSInteger) count {
    self.orderCountLab.text = [NSString stringWithFormat:@"%ld",count];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
