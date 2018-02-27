//
//  PurchaseCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PurchaseCell.h"
#import "BGControl.h"

@implementation PurchaseCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
    NSInteger lpdt043;
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
    
    self.oneFgView = [UIView new];
    self.twoFgView = [UIView new];
    self.threeFgView = [UIView new];
    [self.contentView addSubview:self.commodityImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.specificationsLab];
    [self.contentView addSubview:self.numLab];
    [self.contentView addSubview:self.jipriceNum];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.orderCountLab];
    [self.contentView addSubview:self.orderButton];
    
//    [self.contentView addSubview:self.plusBth];
//    [self.contentView addSubview:self.minusBth];
    [self.contentView addSubview:self.oneFgView];
    [self.contentView addSubview:self.twoFgView];
//    [self.contentView addSubview:self.jiaImg];
//    [self.contentView addSubview:self.jianImg];
    [self.contentView addSubview:self.orderPriceCountLab];
//    [self.contentView addSubview:self.jijiaPlusImg];
//    [self.contentView addSubview:self.jijiaMinImg];
    [self.contentView addSubview:self.bottomView];
    self.nameLab.textColor = kBlackTextColor;
    self.nameLab.font = [UIFont systemFontOfSize:15];
    self.specificationsLab.textColor = kTextGrayColor;
    self.specificationsLab.font = [UIFont systemFontOfSize:14];
    self.priceLab.textColor = kredColor;
    self.priceLab.font = [UIFont systemFontOfSize:14];
    self.orderCountLab.textColor = kBlackTextColor;
    self.orderCountLab.font = [UIFont systemFontOfSize:14];
    self.orderCountLab.textAlignment = NSTextAlignmentLeft;
    self.orderPriceCountLab.font = [UIFont systemFontOfSize:14];
    self.orderPriceCountLab.textAlignment = NSTextAlignmentLeft;
    self.numLab.textColor = kTextGrayColor;
    self.jipriceNum.textColor = kTextGrayColor;
    self.orderPriceCountLab.textColor = kBlackTextColor;
    self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.jiaImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.jijiaMinImg.image = [UIImage imageNamed:@"jiangray.png"];
    self.jijiaPlusImg.image = [UIImage imageNamed:@"jiagray.png"];
    self.oneFgView.backgroundColor = kTextLighColor;
    self.twoFgView.backgroundColor = kTextLighColor;
    self.bottomView.backgroundColor = kBackGroungColor;
}
- (void)layoutSubviews {
    
    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame)-10, self.contentView.frame.size.width, 10);
    [super layoutSubviews];
    
}

- (void)showModel:(PurchaseModel *)model {
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt042"] ] integerValue];
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
    self.priceLab.frame = CGRectMake(marginWidth, marginWidth*2+Imgwidth, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    self.oneFgView.frame = CGRectMake(0, Imgwidth+marginWidth*2+oneHei, kScreenSize.width-100, 1);
    self.numLab.frame = CGRectMake(marginWidth, Imgwidth+marginWidth*3+1+oneHei, 80, shopWidth);
    self.jiaImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*3+1+oneHei, shopWidth, shopWidth);
    self.jianImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*3+1+oneHei, shopWidth, shopWidth);
    self.plusBth.frame = _jiaImg.frame;
    //    self.plusBth.backgroundColor = kTabBarColor;
    self.minusBth.frame =  _jianImg.frame;
    
    self.orderCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*3+1+oneHei, numWidth, shopWidth);
    //    self.orderCountLab.backgroundColor = kTabBarColor;
    self.orderButton.frame = self.orderCountLab.frame;
    self.twoFgView.frame =  CGRectMake(0, Imgwidth+marginWidth*4+1+shopWidth+oneHei, kScreenSize.width-100, 1);
    self.jipriceNum.frame = CGRectMake(marginWidth,Imgwidth+marginWidth*5+1+shopWidth+oneHei, 80, shopWidth);
    
    self.jijiaPlusImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth*5+1+shopWidth +oneHei, shopWidth, shopWidth);
    self.jijiaMinImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, shopWidth, shopWidth);
    
   
    
  self.orderPriceCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth*5+1+shopWidth+oneHei, numWidth, shopWidth);
    if (model.hasProductPicture == true) {
        NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
        [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
          }

    
    self.nameLab.text = model.k1dt002;

    self.numLab.text = [NSString stringWithFormat:@"计数(%@)",model.k1dt005];
    self.jipriceNum.text = [NSString stringWithFormat:@"计价(%@)",model.k1dt011];;
    self.orderPriceCountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt110 afterPoint:lpdt036]];
 self.orderCountLab.text = [NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]];;
    if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.k1dt110]]) {
        self.orderPriceCountLab.text = @"0";
    }
    if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.k1dt101]]) {
        self.orderCountLab.text = @"0";
    }

    if (![[NSString stringWithFormat:@"%@",model.k1dt201] isEqualToString:@"0"]) {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]];
    }else{
        self.priceLab.text = @"";
    }
    self.specificationsLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",model.k1dt003];
    
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
