//
//  EditTwoCell.m
//  WenStore
//
//  Created by 冯丽 on 17/9/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "EditTwoCell.h"
#import "BGControl.h"
#import <SDWebImage/UIImageView+WebCache.h>
@implementation EditTwoCell{
    CAShapeLayer *_border;
    NewModel *oneModel;
//    NSInteger index;
    NSString *keyStr;
    NSMutableDictionary *rightDic;
    NSMutableDictionary *bigDic;
    NSInteger lpdt036;
    NSInteger lpdt042;
    
    
    
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
    self.oneImg = [UIImageView new];
    self.fourImg = [UIImageView new];
    self.bigView = [UIView new];
    [self.contentView addSubview:self.bigView];
    self.xiaBth = [UIButton new];
    self.xiaImg = [UIImageView new];
    self.upButton = [UIButton new];
    self.upView = [UIImageView new];
    self.jianImg = [UIImageView new];
    self.jiaImg = [UIImageView new];
    self.fgView = [UIView new];
    self.bottomView = [UIView new];
    self.remindButton = [UIButton new];
    
    
    self.threeImg = [UIImageView new];
    self.twoImg = [UIImageView new];
    [self.contentView addSubview:self.commodityImg];
    [self.contentView addSubview:self.nameLab];
    [self.contentView addSubview:self.specificationsLab];
    [self.contentView addSubview:self.stockLab];
    [self.contentView addSubview:self.priceLab];
    [self.contentView addSubview:self.orderCountLab];
    [self.contentView addSubview:self.orderButton];
    [self.contentView addSubview:self.remindButton];
    [self.contentView addSubview:self.plusBth];
    [self.contentView addSubview:self.minusBth];
    
    [self.bigView addSubview:self.oneImg];
    [self.bigView addSubview:self.twoImg];
    [self.bigView addSubview:self.threeImg];
    [self.bigView addSubview:self.fourImg];
    
    [self.contentView addSubview:self.jiaImg];
    [self.contentView addSubview:self.jianImg];
    [self.bigView addSubview:self.xiaImg];
    [self.bigView addSubview:self.xiaBth];
    [self.contentView addSubview:self.fgView];
    [self.contentView addSubview:self.bottomView];
    self.xiaView = [UIView new];
    [self.contentView addSubview:self.xiaView];
    [self.xiaView addSubview:self.upView];
    [self.xiaView addSubview:self.upButton];
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
    self.orderCountLab.textAlignment = NSTextAlignmentCenter;
    self.upView.image = [UIImage imageNamed:@"up.png"];
    self.xiaView.tag = 1001;
    [self.remindButton setTitle:@"到货提醒" forState:UIControlStateNormal];
    self.remindButton.titleLabel.font = [UIFont systemFontOfSize:11];
    self.remindButton.clipsToBounds = YES;
    [self.remindButton setTitleColor:kredColor forState:UIControlStateNormal];

    self.remindButton.layer.borderColor = [kredColor CGColor];
    self.remindButton.layer.borderWidth = 1.f;
    [self.remindButton addTarget:self action:@selector(reminClick) forControlEvents:UIControlEventTouchUpInside];
}
- (void)layoutSubviews {
     self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.contentView.frame)-10, self.contentView.frame.size.width, 10);
    [super layoutSubviews];
    
}

-(void)clickOrder:(UIButton *)bth {
    
    if (_TanDelegate &&[_TanDelegate respondsToSelector:@selector(getwithKey:withIndex:withModel:)]) {
        [_TanDelegate getwithKey:oneModel.keyStr withIndex:oneModel.index withModel:oneModel];
    }
    
}
-(void)plusclick{
    NSString *desStr;
    NSString *isFan;
    /* 判断最低叫货量除以倍数是否有余数  没有余数就用商*倍数，如果余数就（商+余数）*倍数*/
    if ([[NSString stringWithFormat:@"%@",self.numCount] isEqualToString:@"0"]) {
        NSString *minStr = [NSString stringWithFormat:@"%@",oneModel.minQuality];
        int minNum =  [minStr intValue];
        NSString *beiStr = [NSString stringWithFormat:@"%@",oneModel.multipleBase];
        int beiNum =  [beiStr intValue];
        int shang = minNum/beiNum;
        int yu = minNum%beiNum;
        int count = 0;
        if (minNum == 0) {
            self.numCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.multipleBase]];
        }else{
            if (yu == 0) {
                count = shang *beiNum;
            }else{
                count = (shang+1)*beiNum;
            }
            self.numCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
        }
    }else {
        NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.multipleBase]];
        NSDecimalNumber*jiafa = [self.numCount decimalNumberByAdding:jiafa1];
        self.numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
    }
    NSComparisonResult bijiaoResOne = [self.numCount compare:oneModel.maxQuality];
    
    if (bijiaoResOne == NSOrderedDescending) {
        if (![[NSString stringWithFormat:@"%@",oneModel.maxQuality] isEqualToString:@"0"]) {
            self.numCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:oneModel.maxQuality afterPoint:lpdt036]];
            
            desStr = [NSString stringWithFormat:@"%@%@%@%@",oneModel.k1dt002,@"最多可购买",[BGControl notRounding:oneModel.maxQuality afterPoint:lpdt036],oneModel.k1dt005];
        }else {
            
            
            
        }
    }
    
    if (![BGControl isNULLOfString:self.stockLab.text ]) {
        NSDecimalNumber *num = self.numCount;
        if (![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"0"]&& ![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"无货"]&&![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"有货"]) {
            num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.sys001Text]];
            
        }
        NSComparisonResult res = [self.numCount compare:num];
        if (res == NSOrderedDescending) {
            self.numCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.sys001Text]];
            desStr = [NSString stringWithFormat:@"%@%@%@%@",oneModel.k1dt002,@"可定量最多为",[BGControl notRounding:num afterPoint:lpdt036],oneModel.k1dt005];
            
            
        }
    }
    
    
    NSArray *arr = [rightDic valueForKey:@"pricConfigs"];
    NSDecimalNumber *price;
    NSMutableArray *murableArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        [murableArr addObject:[dict valueForKey:@"k1dt001"]];
    }
    
    if ([murableArr containsObject:oneModel.k1dt001]) {
        NSInteger indexStr = [murableArr indexOfObject:oneModel.k1dt001];
        NSArray *arrone = [arr[indexStr] valueForKey:@"prics"];
        for (int i = 0; i<arrone.count; i++) {
            NSDecimalNumber *str = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]]];
            NSComparisonResult result = [self.numCount compare:str];
            //            NSString *str = [NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]];
            if (i == 0) {
                
                if (result == NSOrderedAscending) {
                    price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.originalK1dt201]];
                }
            }
            
            if (result == NSOrderedDescending ||result == NSOrderedSame) {
                price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric003"]]];
            }
            
        }
        
    }else {
        price = oneModel.originaltest;
    }
    
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:withStr:)]) {
        [_orderDelegate getOrderCount:self.numCount withKey:oneModel.keyStr withIndex:oneModel.index withPrice:price withStr:desStr ];
    }
    [self showOrderNums:self.numCount withPrice:price];
    
    
}
-(void)clickMin:(UIButton *)bth{
    NSDecimalNumber *price;
    NSString *decStr ;
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.multipleBase]];
    NSDecimalNumber*jiafa = [self.numCount decimalNumberBySubtracting:jiafa1];
    self.numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
    NSString *minStr = [NSString stringWithFormat:@"%@",oneModel.minQuality];
    int minNum =  [minStr intValue];
    NSString *beiStr = [NSString stringWithFormat:@"%@",oneModel.multipleBase];
    int beiNum =  [beiStr intValue];
    int shang = minNum/beiNum;
    int yu = minNum%beiNum;
    int count = 0;
    if (yu == 0) {
        count = shang *beiNum;
    }else{
        count = (shang+1)*beiNum;
    }
    NSComparisonResult bijiaoRes = [self.numCount compare:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]]];
    if (bijiaoRes == NSOrderedAscending) {
        self.numCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    }

    NSArray *arr = [rightDic valueForKey:@"pricConfigs"];
    
    NSMutableArray *murableArr = [NSMutableArray new];
    for (NSDictionary *dict in arr) {
        [murableArr addObject:[dict valueForKey:@"k1dt001"]];
    }
    
    if ([murableArr containsObject:oneModel.k1dt001]) {
        NSInteger indexStr = [murableArr indexOfObject:oneModel.k1dt001];
        NSArray *arrone = [arr[indexStr] valueForKey:@"prics"];
        for (int i = 0; i<arrone.count; i++) {
            NSDecimalNumber *str = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]]];
            NSComparisonResult result = [self.numCount compare:str];
            //            NSString *str = [NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]];
            if (i == 0) {
                
                if (result == NSOrderedAscending) {
                    price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.originalK1dt201]];
                }
            }
            
            if (result == NSOrderedDescending ||result == NSOrderedSame) {
                price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric003"]]];
            }
            
        }
        
    }else {
        price = oneModel.originaltest;
    }
    
  
    NSComparisonResult resultTwo = [oneModel.minPei compare:self.numCount];
    NSComparisonResult resultF = [[NSString stringWithFormat:@"3"] compare:[NSString stringWithFormat:@"1"]];
    
    //        NSString *
    if (resultTwo == NSOrderedDescending) {
        self.numCount = oneModel.minPei;
        
        decStr = [NSString stringWithFormat:@"%@%@",@"最小订货量不小于",[BGControl notRounding:oneModel.minPei afterPoint:lpdt036]];
        //            [self Alert:[NSString stringWithFormat:@"%@%@%@",model.k1dt002,@"最低叫货量为",model.minPei]];
    }
    
    if (_orderDelegate &&[_orderDelegate respondsToSelector:@selector(getOrderCount:withKey:withIndex:withPrice:withStr:)]) {
        [_orderDelegate getOrderCount:self.numCount withKey:oneModel.keyStr withIndex:oneModel.index withPrice:price withStr:decStr];
    }
    [self showOrderNums:self.numCount withPrice:price];
    
    
    
    
    
    
    
}

- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict  withKey:(NSString *)key withIndex:(NSInteger) currentIndex{
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];

    NSLog(@"%f",kScreenSize.width);
    
    for (UILabel *lab in [self.xiaView subviews]) {
        if (lab.tag ==2001) {
            [lab removeFromSuperview];
        }
    }
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
    }
    
    CGFloat oneHei = Imgwidth/4;
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    self.commodityImg.frame = CGRectMake(marginWidth, marginWidth, Imgwidth, Imgwidth);
    self.nameLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    self.specificationsLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth+oneHei, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    self.stockLab.frame = CGRectMake(Imgwidth+marginWidth*2, marginWidth+oneHei*2, self.contentView.frame.size.width - Imgwidth-marginWidth*3, oneHei);
    
    self.jiaImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth, Imgwidth+marginWidth, shopWidth, shopWidth);
    self.jianImg.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth*2-numWidth, Imgwidth+marginWidth, shopWidth, shopWidth);
    self.plusBth.frame = _jiaImg.frame;
    //    self.plusBth.backgroundColor = kTabBarColor;
    self.minusBth.frame =  _jianImg.frame;
    
    self.orderCountLab.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-shopWidth-numWidth, Imgwidth+marginWidth, numWidth, shopWidth);
    //    self.orderCountLab.backgroundColor = kTabBarColor;
    self.orderButton.frame = self.orderCountLab.frame;
    
    self.priceLab.frame = CGRectMake(marginWidth, Imgwidth+marginWidth, 120, oneHei);
     self.remindButton.frame = CGRectMake(self.contentView.frame.size.width -marginWidth-60, Imgwidth, 60, 30);
    
    self.fgView.frame = CGRectMake(marginWidth, Imgwidth+40, self.contentView.frame.size.width-marginWidth*2, 1);
    self.fgView.backgroundColor = kLineColor;
    self.bigView.frame = CGRectMake(0, Imgwidth+52, self.contentView.frame.size.width, 16);
    self.xiaImg.frame = CGRectMake(self.contentView.frame.size.width - marginWidth-10, 2, 10, 7);
    self.xiaBth.frame = CGRectMake(self.contentView.frame.size.width - 50, -10, 46, 30);
    self.upView.frame = CGRectMake(self.contentView.frame.size.width - 25, 2, 10, 7);
    self.upButton.frame = CGRectMake(self.contentView.frame.size.width - 50, -10, 46, 30);
    //    self.bottomView.frame = CGRectMake(0, CGRectGetMaxY(self.upView.frame)+10, self.contentView.frame.size.width, 10);
    self.bottomView.backgroundColor = kBackGroungColor;
    
    self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];
    self.jiaImg.image = [UIImage imageNamed:@"jiaGree.png"];
    self.oneImg.image = [UIImage imageNamed:@"zeng.png"];
    self.twoImg.image = [UIImage imageNamed:@"pei.png"];
    self.threeImg.image = [UIImage imageNamed:@"hui.png"];
    self.xiaImg.image = [UIImage imageNamed:@"add.png"];
    self.fourImg.image = [UIImage imageNamed:@"pi.png"];
    [self.minusBth addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
    [self.orderButton addTarget:self action:@selector(clickOrder:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.plusBth addTarget:self action:@selector(plusclick) forControlEvents:UIControlEventTouchUpInside];
    oneModel = model;
    rightDic = rightDict;
    //    index = currentIndex;
    keyStr = key;
    bigDic = dict;
    
    self.numCount = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:lpdt036]];
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
    self.commodityImg.image = [UIImage imageNamed:@"icon_moren(1).png"];
    if (model.hasProductPicture == true) {
        NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
        [self.commodityImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
       
    }
    self.upView.frame = CGRectMake(self.contentView.frame.size.width - 10-marginWidth, 2, 10, 7);
    if ([BGControl isNULLOfString:model.k1dt003]) {
        self.specificationsLab.text = @"";
    }else {
        self.specificationsLab.text = [NSString stringWithFormat:@"%@ %@",@"规格:",model.k1dt003];
    }
    if ( [BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.sys001Text]]) {
        self.stockLab.text = @"";
    }else{
         self.stockLab.text =  [NSString stringWithFormat:@"%@ %@",@"可订量:",model.sys001Text];
      
    }
    
    self.orderCountLab.text = [BGControl notRounding:model.orderCount afterPoint:lpdt036];
    NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
    NSString *str = [NSString stringWithFormat:@"%@",model.originaltest];
    if (![str isEqualToString:@"0"]) {
        self.priceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
    }else{
        self.priceLab.text = @"";
    }
    
    
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isNum = false;
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1DT201"]) {
            isPrice = true;
        }
        if ([visiableFieldsStr isEqualToString:@"SYS001"]) {
            isNum = true;
        }
    }
    if (!isNum) {
        self.stockLab.hidden = YES;
    }else{
        self.stockLab.hidden = NO;
    }
    
    if (!isPrice) {
        self.priceLab.hidden = YES;
    }else{
        self.priceLab.hidden = NO;
    }
    
    NSDecimalNumber *sysDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.sys001Text]];
    NSDecimalNumber *bijiaoNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSComparisonResult res = [sysDec compare:bijiaoNum];
    if (res == NSOrderedSame||[[NSString stringWithFormat:@"%@",model.sys001Text] isEqualToString:@"无货"]) {
        self.jiaImg.hidden = YES;
        self.plusBth.enabled = NO;
        self.remindButton.hidden = NO;
    }else{
        self.jiaImg.hidden = NO;
        self.plusBth.enabled = YES;
        self.remindButton.hidden = YES;
    }
    NSInteger sum = 0;
    CGFloat sumHei = 0;
    NSArray *arr = [rightDict valueForKey:@"pricConfigs"];
    NSArray *arrFree = [rightDict valueForKey:@"freeActivities"];
    NSArray *arrpromo= [rightDict valueForKey:@"promoActivities"];
    NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
    if ( model.hasFree ==true ) {
        self.oneImg.frame = CGRectMake(marginWidth, 0, 16, 16);
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zeng.png"]];
        imgView.frame = CGRectMake(marginWidth, 3, 16, 16);
        for (int i = 0;i<arrFree.count ; i++) {
            UILabel *label = [UILabel new];
            if ([model.k1dt001 isEqualToString:[arrFree[i] valueForKey:@"k7mf004"]]) {
                NSString *pricInfoStr = [NSString stringWithFormat:@"%@%@%@%@%@%@%@%@%@%@",@"赠送:",@"购买",[arrFree[i] valueForKey:@"k7mf005"],model.k1dt005,model.k1dt002,@",",@"可免费获得",[arrFree[i] valueForKey:@"k7mf012"],[arrFree[i] valueForKey:@"k7mf011"],[arrFree[i] valueForKey:@"k7mf008"]];
                label.text = pricInfoStr;
                label.numberOfLines = 0;
                label.tag = 2001;
                label = [BGControl setLabelSpace:label withValue:label.text withFont:[UIFont systemFontOfSize:14]];
                CGFloat height = [BGControl getSpaceLabelHeight:label.text withFont:[UIFont systemFontOfSize:14] withWidth:self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-10];
                label.textColor = kTextGrayColor;
                
                label.frame = CGRectMake(marginWidth+16+4, sumHei, self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-10, height);
                [self.xiaView addSubview:label];
                
                [self.xiaView addSubview:imgView];
                sumHei = sumHei +height;;
            }
        }
        sum  = sum+1;
    }else {
        self.oneImg.hidden = YES;
    }
    if (model.hasBuyTogether==true ) {
        self.twoImg.frame = CGRectMake(marginWidth +(16+10)*sum, 0, 16, 16);
        sum = sum +1;
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pei.png"]];
        imgView.frame = CGRectMake(marginWidth, 3, 16, 16);
        for (int i = 0;i<buyTogetherArr.count ; i++) {
            UILabel *label = [UILabel new];
            if ([model.k1dt001 isEqualToString:[buyTogetherArr[i] valueForKey:@"k7mf004"]]) {
                NSString *twoStr = [NSString stringWithFormat:@"%@%@%@%@",@"必配",[buyTogetherArr[i] valueForKey:@"k7mf012"],[buyTogetherArr[i] valueForKey:@"k7mf011"],[buyTogetherArr[i] valueForKey:@"k7mf008"]];
                NSString *oneStr = [NSString stringWithFormat:@"%@%@%@%@",@"购买:",[buyTogetherArr[i] valueForKey:@"k7mf005"],model.k1dt005,model.k1dt002];
                
                
                NSString *pricInfoStr = [NSString stringWithFormat:@"%@%@%@",oneStr,@",",twoStr];
                label.text = pricInfoStr;
                label.numberOfLines = 0;
                label.tag = 2001;
                label = [BGControl setLabelSpace:label withValue:label.text withFont:[UIFont systemFontOfSize:14]];
                CGFloat height = [BGControl getSpaceLabelHeight:label.text withFont:[UIFont systemFontOfSize:14] withWidth:self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-10];
                label.textColor = kTextGrayColor;
                label.frame = CGRectMake(35, sumHei, self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-10, height);
                [self.xiaView addSubview:label];
                [self.xiaView addSubview:imgView];
                sumHei = sumHei +height;;
            }
        }
        
    }else {
        self.twoImg.hidden = YES;
    }
    if (model.hasPromo==true ) {
        self.threeImg.frame = CGRectMake(marginWidth, 0, 16, 16);
        sum = sum +1;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hui.png"]];
        imgView.frame = CGRectMake(marginWidth,  sumHei +3, 16, 16);
        
        for (int i = 0;i<arrpromo.count ; i++) {
            UILabel *label = [UILabel new];
            if ([model.k1dt001 isEqualToString:[arrpromo[i] valueForKey:@"k7mf004"]]) {
                NSString *oneStr = [NSString stringWithFormat:@"%@%@%@%@%@%@",@"促销:",@"购买",[arrpromo[i] valueForKey:@"k7mf005"],model.k1dt005,model.k1dt002,@","];
                NSString *twoStr = [NSString stringWithFormat:@"%@%@%@",@"可用",[arrpromo[i] valueForKey:@"k7mf017"],@"元"];
                NSString *threeStr = [NSString stringWithFormat:@"%@%@%@%@",@"购买",[arrpromo[i] valueForKey:@"k7mf012"],[arrpromo[i] valueForKey:@"k7mf011"],[arrpromo[i] valueForKey:@"k7mf008"]];
                NSString *pricInfoStr = [NSString stringWithFormat:@"%@%@%@",oneStr,twoStr,threeStr];
                label.text = pricInfoStr;
                label.numberOfLines = 0;
                label.tag = 2001;
                label = [BGControl setLabelSpace:label withValue:label.text withFont:[UIFont systemFontOfSize:14]];
                CGFloat height = [BGControl getSpaceLabelHeight:label.text withFont:[UIFont systemFontOfSize:14] withWidth:self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-10];
                label.textColor = kTextGrayColor;
                if (height<23) {
                    label.frame = CGRectMake(marginWidth+16+4, sumHei, self.contentView.frame.size.width-68, height);
                }else{
                    label.frame = CGRectMake(marginWidth+16+4, sumHei, self.contentView.frame.size.width-68, height);
                }
                [self.xiaView addSubview:label];
                [self.xiaView addSubview:imgView];
                
                sumHei = sumHei +height;;
            }
        }
        self.threeImg.hidden = NO;
        
    }else {
        self.threeImg.hidden = YES;
    }
    if (model.hasPric==true ) {
        self.fourImg.frame = CGRectMake(marginWidth +(16+10)*sum, 0, 16, 16);
        sum = sum +1;
        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pi.png"]];
        imgView.frame = CGRectMake(marginWidth, 3 +sumHei, 16, 16);
        
        for (int i = 0;i<arr.count ; i++) {
            UILabel *label = [UILabel new];
            if ([model.k1dt001 isEqualToString:[arr[i] valueForKey:@"k1dt001"]]) {
                NSString *pricInfoStr = [arr[i] valueForKey:@"pricInfoTemplate"];
                pricInfoStr = [pricInfoStr stringByReplacingOccurrencesOfString:@"\r" withString:@""];
                pricInfoStr = [pricInfoStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
                NSString *trueStr = [pricInfoStr stringByReplacingOccurrencesOfString:@"{K0IT005}" withString:model.k1dt005];
                trueStr = [trueStr stringByReplacingOccurrencesOfString:@"{K0IT002}" withString:model.k1dt002];
                label.text = trueStr;
                label.numberOfLines = 0;
                label.tag = 2001;
                label = [BGControl setLabelSpace:label withValue:label.text withFont:[UIFont systemFontOfSize:14]];
                CGFloat height = [BGControl getSpaceLabelHeight:label.text withFont:[UIFont systemFontOfSize:14] withWidth:self.contentView.frame.size.width - marginWidth-16-4-marginWidth-10-10];
                label.textColor = kTextGrayColor;
                label.frame = CGRectMake(marginWidth+16+4, sumHei, self.contentView.frame.size.width-marginWidth-16-4-marginWidth-10-100, height);
                
                [self.xiaView addSubview:label];
                [self.xiaView addSubview:imgView];
                sumHei = sumHei +height;;
                NSLog(@"%@",trueStr);
            }
        }
    }else {
        self.fourImg.hidden = YES;
    }
    self.xiaBth.tag = 500;
    self.upButton.tag = 501;
    [self.xiaBth addTarget:self action:@selector(other:) forControlEvents:UIControlEventTouchUpInside];
    [self.upButton addTarget:self action:@selector(other:) forControlEvents:UIControlEventTouchUpInside];
    self.xiaView.frame = CGRectMake(0, Imgwidth+52, self.contentView.frame.size.width, sumHei);
    if (model.hasLimiteInfo == true) {
        if (model.maxHei >0) {
            self.bigView.hidden = YES;
            self.xiaView.hidden = NO;
        }else{
            self.bigView.hidden = NO;
            self.xiaView.hidden = YES;
        }
        
    }else {
        self.bigView.hidden = YES;
        self.xiaView.hidden = YES;
    }
    //
    
}

-(void)other:(UIButton *)bth{
    
    CGRect xiaFrame = self.xiaView.frame;
    //    self.xiablock(xiaFrame.size.height, YES);
    if (bth.tag == 500) {
        self.bigView.hidden = YES;
        self.xiaView.hidden = NO;
        if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withKey:withIndex:)]) {
            [_delegate getMaxHei:xiaFrame.size.height withKey:oneModel.keyStr withIndex:oneModel.index];
        }
    }else {
        self.bigView.hidden = NO;
        self.xiaView.hidden = YES;
        if (_delegate &&[_delegate respondsToSelector:@selector(getMaxHei:withKey:withIndex:)]) {
            [_delegate getMaxHei:0 withKey:oneModel.keyStr withIndex:oneModel.index];
        }
        
    }
    
    
}

-(void)reminClick{
    if (_reminDelegate &&[_reminDelegate respondsToSelector:@selector(remindStr:with:)]) {
        [_reminDelegate remindStr:oneModel.k1dt001 with:oneModel];
    }
}
- (void)showOrderNums:(NSDecimalNumber *) count withPrice:(NSDecimalNumber *)price {
    self.orderCountLab.text = [NSString stringWithFormat:@"%@",count];
       NSString *priceStr = [BGControl notRounding:price afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    
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
