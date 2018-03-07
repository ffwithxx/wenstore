//
//  AddAsideCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddAsideCell.h"
#import "BGControl.h"

@implementation AddAsideCell{
    AsideModel *oneModel;
    NSDecimalNumber *priceOne;;
    NSInteger lpdt036;
    NSInteger lpdt042;
    NSInteger lpdt043;
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
    
 
    //    [self.contentView addSubview:self.aView ];
    self.headImg = [UIImageView new];
    [self.contentView  addSubview:self.headImg];
    self.nameLab = [UILabel new];
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.nameLab.textColor = kBlackTextColor;
    [self.contentView  addSubview:self.nameLab];
    self.guigeLab = [UILabel new];
    self.guigeLab.textColor = kTextGrayColor;
    self.guigeLab.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:self.guigeLab];
    self.priceLab =[UILabel new];
    self.priceLab.textColor = kredColor;
    self.priceLab.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:self.priceLab];
    self.jianImg = [UIImageView new];
    [self.contentView  addSubview:self.jianImg];
    self.orderNumLab = [UILabel new];
    self.orderNumLab.textColor = kTextGrayColor;
    self.orderButton = [UIButton new];
    self.orderNumLab.font = [UIFont systemFontOfSize:14];
    [self.contentView  addSubview:self.orderNumLab];
    self.jiaImg = [UIImageView new];
    [self.contentView  addSubview:self.jiaImg];
    self.jiaBth = [UIButton new];
    [self.contentView  addSubview:self.jiaBth];
    self.minuBth = [UIButton new];
    [self.contentView  addSubview:self.minuBth];
    
    self.lineOneView = [UIView new];
    [self.contentView  addSubview:self.lineOneView];
    self.lastView = [UIView new];
    [self.contentView  addSubview:self.lastView];
    self.lineOneView.backgroundColor = kLineColor;
         [self.contentView addSubview:self.orderButton];
    
    
}
- (void)layoutSubviews {
    CGFloat  onwidth = self.contentView.frame.size.width;
    //    self.headImg.image = [UIImage imageNamed:@"icon_moren(1).png"];;
    self.jiaImg.image =  [UIImage imageNamed:@"jiaGree.png"];
    self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];;
    
    [self.minuBth addTarget:self action:@selector(clickMins:) forControlEvents:UIControlEventTouchUpInside];
   
    [self.jiaBth addTarget:self action:@selector(plusclicks) forControlEvents:UIControlEventTouchUpInside];
    self.lastView.frame = CGRectMake(0, CGRectGetMaxY(self.priceLab.frame), onwidth, 10);
    //    [self.jiaBth addTarget:self action:@selector(plusclicks) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [super layoutSubviews];
}
- (void)showModel:(AsideModel *)model{
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3005lpdt042"] ] integerValue];
    oneModel = model;
    
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
    }
    CGFloat oneHei = Imgwidth/3;
       CGFloat  onwidth = self.contentView.frame.size.width;
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    self.headImg.frame = CGRectMake(marginWidth, marginWidth, Imgwidth, Imgwidth);
    self.nameLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth, onwidth - Imgwidth-marginWidth*3, oneHei);
    self.guigeLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth+oneHei, onwidth - Imgwidth-marginWidth*3, oneHei);
    self.jiaImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*2, shopWidth, shopWidth);
    self.jianImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*2, shopWidth, shopWidth);
    self.jiaBth.frame = _jiaImg.frame;
    //    self.plusBth.backgroundColor = kTabBarColor;
    self.minuBth.frame =  _jianImg.frame;
    
    self.orderNumLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*2, numWidth, shopWidth);
    //    self.orderCountLab.backgroundColor = kTabBarColor;
    self.orderButton.frame = self.orderNumLab.frame;
    
    self.orderNumLab.textAlignment = NSTextAlignmentCenter;
    self.lineOneView.frame = CGRectMake(0, Imgwidth+marginWidth*3+shopWidth, onwidth, 1);
    self.numCount =model.orderCount;
    self.orderNumLab.text = [BGControl notRounding:model.orderCount afterPoint:lpdt036];
    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
        _jianImg.hidden = YES;
        self.minuBth.hidden = YES;
        self.orderNumLab.hidden = YES;
        self.orderButton.hidden = YES;
        
    }else {
        _jianImg.hidden = NO;
        self.minuBth.hidden = NO;
        self.orderNumLab.hidden = NO;
        self.orderButton.hidden = NO;
           }
    self.nameLab.text = model.k1dt002;
    if ([BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = @"";
    }else {
        self.guigeLab.text = [NSString stringWithFormat:@"%@ %@",@"规格:",model.k1dt003];
    }
  
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    priceOne = [NSDecimalNumber decimalNumberWithString:priceStr];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
    CGFloat pWidth = [BGControl labelAutoCalculateRectWith:self.priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
    self.priceLab.frame = CGRectMake(marginWidth, Imgwidth+marginWidth*2, pWidth, oneHei);
    //    if (orderWidth>shopWidth) {
    //        self.orderNumLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-orderWidth, Imgwidth, orderWidth, shopWidth);
    //        self.orderButton.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-orderWidth, Imgwidth, orderWidth, shopWidth);
    //        self.jianImg.frame = CGRectMake(self.contentView.frame.size.width-marginWidth-shopWidth*2-orderWidth, Imgwidth, shopWidth, shopWidth);
    //        self.minuBth.frame =CGRectMake(self.contentView.frame.size.width-marginWidth-shopWidth*2-orderWidth, Imgwidth, shopWidth, shopWidth);
    //
    //    }
    [self.orderButton addTarget:self action:@selector(clickOrder:) forControlEvents:UIControlEventTouchUpInside];
     NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    
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
    
}
-(void)plusclicks{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber*jiafa = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",self.numCount]] decimalNumberByAdding:jiafa1];
    NSString *numStr = [BGControl notRounding:jiafa afterPoint:lpdt036];
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withModel:)]) {
        [_orderDelegate getOrderCount:[NSDecimalNumber decimalNumberWithString:numStr] withModel:oneModel];
    }
    
    
    
}
-(void)clickMins:(UIButton *)bth{
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber*jiafa = [self.numCount decimalNumberBySubtracting:jiafa1];
    NSString *numStr = [BGControl notRounding:jiafa afterPoint:lpdt036];
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withModel:)]) {
        if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withModel:)]) {
            [_orderDelegate getOrderCount:[NSDecimalNumber decimalNumberWithString:numStr] withModel:oneModel];
        }
        
    }
    
    
}
-(void)clickOrder:(UIButton *)bth {
    
    if (_TanDelegate &&[_TanDelegate respondsToSelector:@selector(scrapwithModel:)]) {
        [_TanDelegate scrapwithModel:oneModel];
    }
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
