//
//  CallOrderOneCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderOneCell.h"
#import "BGControl.h"
#import "BuyModel.h"
#import <objc/runtime.h>
@implementation CallOrderOneCell {
    UIView *bigView;
    UILabel *titleLab;
    UILabel *priceLab;
    UIImageView *jianImg;
    UITextField *orderCountField;
    UIImageView *jiaImg;
    UIButton *minBth;
    UIButton *addBth;
    UIView *otherView;
    UIView *lineView;
    NewModel *oneModel;
//    NSInteger index;
    NSString *keyStr;
    NSMutableDictionary *rightDic;
    NSMutableDictionary *bigDic;
    UIView *bottomView;
    NSInteger selfIndex;
    UIButton *orderButton;
    UIImageView *peiImgView;
    NSInteger lpdt036;
    NSInteger lpdt043;
//    NSString *idStr;
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
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
    bigView = [UIView new];
    peiImgView = [[UIImageView alloc] init];
    [self.contentView addSubview:bigView];
    titleLab = [UILabel new];
    titleLab.textColor = kBlackTextColor;
    titleLab.font = [UIFont systemFontOfSize:15];
    [bigView addSubview:titleLab];
    priceLab = [UILabel new];
    priceLab.textColor = kredColor;
    priceLab.font = [UIFont systemFontOfSize:15];
    [bigView addSubview:priceLab];
    jiaImg = [UIImageView new];
    jiaImg.image = [UIImage imageNamed:@"jiaGree.png"];
    [bigView addSubview:jiaImg];
    orderCountField = [UITextField new];
    orderCountField.textColor = kBlackTextColor;
    orderCountField.font = [UIFont systemFontOfSize:15];
    orderButton = [UIButton new];
    [bigView addSubview:orderCountField];
    [bigView addSubview:orderButton];
    jianImg = [UIImageView new];
    jianImg.image = [UIImage imageNamed:@"jianGree.png"];
    [bigView addSubview:jianImg];
    minBth = [UIButton new];
    [bigView addSubview:minBth];
    addBth = [UIButton new];
    [bigView addSubview:addBth];
    otherView  = [UIView new];
   
    [bigView addSubview:otherView];
    [bigView addSubview:peiImgView];
    peiImgView.image = [UIImage imageNamed:@"pei.png"];
    lineView = [UIView new];
    lineView.backgroundColor = kBackGroungColor;
    [bigView addSubview:lineView];
    orderCountField.enabled = NO;
    bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    orderCountField.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview: bottomView];
    bottomView.tag = 1001;
    
}
- (void)layoutSubviews {
    
       [super layoutSubviews];
    //    self.contentView.backgroundColor = kTabBarColor;
}

- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict withselfIndex:(NSInteger) selfIndext withIndex:(NSInteger) currentIndex{
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    for (UIView *view in [bottomView subviews]) {
        [view removeFromSuperview];
    }
   
    NSString  * lpdt036Str = [[NSUserDefaults standardUserDefaults]valueForKey:@"lpdt036"];
    selfIndext = selfIndext;
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    
    
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
    }
    CGFloat peiWidth =marginWidth+10+16;
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
    peiImgView.frame= CGRectMake(marginWidth+10, 19, 16, 16);
    peiImgView.hidden = NO;
    if (model.ispei == 1) {
        peiWidth = 0;
        peiImgView.hidden = YES;
    }
    CGFloat marginHei = (50-shopWidth)/2;
    bottomView.frame = CGRectMake(0, 50, kScreenSize.width, 0);
    bigView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
    bigView.backgroundColor = [UIColor whiteColor];
    jiaImg.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHei, shopWidth, shopWidth);
    jianImg.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-numWidth, marginHei, shopWidth, shopWidth);
    addBth.frame = jiaImg.frame;
    minBth.frame =jianImg.frame;
    orderCountField.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth-numWidth, marginHei, numWidth, shopWidth);
    orderButton.frame = orderCountField.frame;
    priceLab.frame = CGRectMake(kScreenSize.width-marginWidth-shopWidth*2-numWidth-10, 10, 48, 30);
    titleLab.frame = CGRectMake(marginWidth +peiWidth, 10, 95, 30);
    otherView.frame = CGRectMake(0, 45, self.contentView.frame.size.width, 80);
    //    otherView.backgroundColor = [UIColor redColor];
    [minBth addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
    [addBth addTarget:self action:@selector(plusclick) forControlEvents:UIControlEventTouchUpInside];
    [orderButton addTarget:self action:@selector(orderButton) forControlEvents:UIControlEventTouchUpInside];
    bottomView.backgroundColor = [UIColor whiteColor];
    bigView.backgroundColor = [UIColor whiteColor];
    
    self.numCount =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]]];;
    bigView.tag = 1001;
    oneModel = model;
    rightDic = rightDict;
    
    bigDic = dict;
    titleLab.text = model.k1dt002;
    orderCountField.text = [BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]];
    
//    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:orderCountField.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
//    if (orderWidth>shopWidth) {
//        orderCountField.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        orderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        
//        jianImg.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//        minBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//    }
    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
        jianImg.hidden = YES;
        minBth.hidden = YES;
        orderCountField.hidden = YES;
        orderButton.hidden = YES;
    }else {
        jianImg.hidden = NO;
        minBth.hidden = NO;
        orderCountField.hidden = NO;
        orderButton.hidden = NO;
    }
    NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
  //  NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
    
   // priceLab.text =  [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
    NSDecimalNumber *maxPrice = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.orderCount]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.originaltest]]];
    NSString *str = [NSString stringWithFormat:@"%@",maxPrice];
    if (![str isEqualToString:@"0"]) {
        priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:maxPrice afterPoint:lpdt043]];
    }else{
      priceLab.text = @"";
    }
   
    CGFloat priceWidth = [BGControl labelAutoCalculateRectWith:priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
    priceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-10 -priceWidth-orderCountField.frame.size.width, 10, priceWidth, 30);
    
    priceLab.textAlignment = NSTextAlignmentRight;
    titleLab.frame = CGRectMake(marginWidth +peiWidth, 10, kScreenSize.width - marginWidth-shopWidth*2-10-priceWidth -10-orderCountField.frame.size.width -peiWidth, 30);
    NSArray *arr = [rightDict valueForKey:@"pricConfigs"];
    NSInteger sum = 0;
    CGFloat sumHei = 0;
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
        priceLab.hidden = YES;
    }else{
        priceLab.hidden = NO;
    }
    if (model.hasLimiteInfo == true) {
     CGFloat marginHeiTwo = (40-shopWidth)/2;
        if (model.hasFree == true) {
            NSArray *freeArr = [model.freeDict valueForKey:@"arrFree"];
            
            for (int i = 0; i < freeArr.count ; i++) {
                BuyModel *freeModel = freeArr[i];
                if (![[NSString stringWithFormat:@"%@",freeModel.orderCount] isEqualToString:@"0"]) {
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  sumHei , self.contentView.frame.size.width, 40)];
                view.tag = 2001;
                [bottomView addSubview:view];
                for (UIView *view1 in [view subviews]) {
                    
                    [view1 removeFromSuperview];
                    
                }
                
                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zeng.png"]];
                imgView.frame = CGRectMake(marginWidth+10, 12, 16, 16);
                
                [view addSubview:imgView];
                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
                jiaImgView.image = [UIImage imageNamed:@"jiagray.png"];
                
                [view addSubview:jiaImgView];
                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*2-numWidth-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
                
                jianImgView.image = [UIImage imageNamed:@"jiangray.png"];
                [view addSubview:jianImgView];
                UILabel *zengOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth-numWidth, marginHeiTwo, numWidth, shopWidth)];
                
                zengOrderLab.text = [BGControl notRounding:freeModel.orderCount afterPoint:[lpdt036Str integerValue]];
                ;
                zengOrderLab.textColor = kTextGrayColor;

                zengOrderLab.font = [UIFont systemFontOfSize:15];
                [view addSubview:zengOrderLab];
                zengOrderLab.textAlignment = NSTextAlignmentCenter;
                UILabel *ZpriceLab = [[UILabel alloc] init];
                NSString *str = [NSString stringWithFormat:@"%@",freeModel.k7mf017];
                if (![str isEqualToString:@"0"]) {
                ZpriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:freeModel.k7mf017 afterPoint:lpdt042]];
                }else{
                    ZpriceLab.text = @"";
                }
                ZpriceLab.textAlignment = NSTextAlignmentRight;
                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, 24)].width;
//                CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//                if (jianorderWidth>shopWidth) {
//                    zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth-24, marginHeiTwo, shopWidth, shopWidth);
//                    
//                }
                
                ZpriceLab.font = [UIFont systemFontOfSize:15];
                ZpriceLab.textColor = kredColor;
                
                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
                [view addSubview:ZpriceLab];
                //                         ZpriceLab.tag = 2002;
                ZpriceLab.textAlignment = NSTextAlignmentCenter;
                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
                
                FreetitleLab.text = [NSString stringWithFormat:@"%@",freeModel.k7mf008];
                FreetitleLab.textColor = kTextGrayColor;
                FreetitleLab.font = [UIFont systemFontOfSize:15];
                FreetitleLab.textAlignment = NSTextAlignmentLeft;
                [view addSubview:FreetitleLab];
                sumHei = sumHei +40;
                if (!isPrice) {
                    ZpriceLab.hidden = YES;
                }else{
                    ZpriceLab.hidden = NO;
                }
            }
            }
        }//赠送
        if (model.hasPromo==true ) {
            NSArray *promArr = [model.promDict valueForKey:@"promoArr"];
            for (int i = 0;i<promArr.count ; i++) {
                BuyModel *promModel = promArr[i];
                
                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sumHei , self.contentView.frame.size.width, 40)];
                view.tag = 2001;
                [bottomView addSubview:view];
                for (UIView *view1 in [view subviews]) {
                    
                    [view1 removeFromSuperview];
                    
                }
                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hui.png"]];
                imgView.frame =  CGRectMake(marginWidth+10, 12, 16, 16);
                [view addSubview:imgView];
                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
                jiaImgView.image = [UIImage imageNamed:@"jiaGree.png"];
                [view addSubview:jiaImgView];
                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*2-numWidth-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
                jianImgView.image = [UIImage imageNamed:@"jianGree.png"];
                [view addSubview:jianImgView];
                UIButton *peiJiaBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
                UIButton *peiJianBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*2-numWidth-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
                peiJianBth.tag = [promModel.k7mf007 integerValue];
                peiJiaBth.tag = [promModel.k7mf007 integerValue];
                objc_setAssociatedObject(peiJianBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                objc_setAssociatedObject(peiJiaBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                [peiJiaBth addTarget:self action:@selector(proJia:) forControlEvents:UIControlEventTouchUpInside];
                [peiJianBth addTarget:self action:@selector(proJian:) forControlEvents:UIControlEventTouchUpInside];
                UILabel *zengOrderLab =[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth-numWidth, marginHeiTwo, numWidth, shopWidth)];
                zengOrderLab.text = [BGControl notRounding:promModel.orderCount afterPoint:[lpdt036Str integerValue]];
                zengOrderLab.textColor = kTextGrayColor;
                zengOrderLab.textAlignment = NSTextAlignmentCenter;
                zengOrderLab.font = [UIFont systemFontOfSize:15];
                [view addSubview:zengOrderLab];
                UIButton *zengOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth-numWidth, marginHeiTwo, numWidth, shopWidth)];
//                zengOrderButton.tag = [promModel.k7mf007 integerValue];
                [zengOrderButton addTarget:self action:@selector(zengFile:) forControlEvents:UIControlEventTouchUpInside];
                objc_setAssociatedObject(zengOrderButton, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
                UILabel *ZpriceLab = [[UILabel alloc] init];
                NSDecimalNumber *maxPriceOne = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promModel.orderCount]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",promModel.k7mf017]]];
                NSString *str = [NSString stringWithFormat:@"%@",maxPriceOne];
                if (![str isEqualToString:@"0"]) {
                    ZpriceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:maxPriceOne afterPoint:lpdt043]];
                }else{
                    ZpriceLab.text = @"";
                }
                

              //  ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:promModel.k7mf017 afterPoint:lpdt042],@"/",promModel.k7mf011];
                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, shopWidth)].width;
                ZpriceLab.font = [UIFont systemFontOfSize:15];
                ZpriceLab.textColor = kredColor;
                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
                [view addSubview:ZpriceLab];
                //                        ZpriceLab.tag = 2002;
                ZpriceLab.textAlignment = NSTextAlignmentCenter;
                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
                
                FreetitleLab.text = [NSString stringWithFormat:@"%@",promModel.k7mf008];
                FreetitleLab.textColor = kTextGrayColor;
                FreetitleLab.font = [UIFont systemFontOfSize:15];
                FreetitleLab.textAlignment = NSTextAlignmentLeft;
                [view addSubview:FreetitleLab];
                peiJiaBth.enabled = YES;
                [view addSubview:peiJiaBth];
                [view addSubview:peiJianBth];
                [view addSubview:zengOrderButton];
                sumHei = sumHei +40;
                
                if (!isPrice) {
                    ZpriceLab.hidden = YES;
                }else{
                    ZpriceLab.hidden = NO;
                }
                
            }

        }//优惠
        
        
        
    }
    if (sumHei != 0) {
        bottomView.frame = CGRectMake(0, 50, kScreenSize.width, sumHei);
        lineView.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame), kScreenSize.width, 15);
        
        if (_Bottomdelegate && [_Bottomdelegate respondsToSelector:@selector(getBottomHei:withIndex:)]) {
            [_Bottomdelegate getBottomHei:sumHei+50+15 withIndex:selfIndext];
        }

    }else {
    lineView.frame = CGRectMake(0, CGRectGetMaxY(bigView.frame), kScreenSize.width, 15);
    }
    

    
}


- (void)zengFile:(UIButton *)bth {
     id first = objc_getAssociatedObject(bth, "firstObject");
    if (_tanLitterDelegate &&[_tanLitterDelegate respondsToSelector:@selector(getWithModel:withTag:withIndex:withType:)]) {
        [_tanLitterDelegate getWithModel:oneModel withTag:first withIndex:selfIndex withType:@"1"];
    }

}
-(void)zengOneFile:(UIButton *)bth {
    
//    if (_tanLitterDelegate &&[_tanLitterDelegate respondsToSelector:@selector(getWithModel:withTag:withIndex:withType:)]) {
//        [_tanLitterDelegate getWithModel:oneModel withTag:bth.tag withIndex:selfIndex withType:@"2"];
//    }
}
- (void)proJia:(UIButton *)bth {
    NSDecimalNumber *restDec;
    NSMutableArray *promoArr = [NSMutableArray new];
    NSDecimalNumber *orderCount;
    NSDecimalNumber *chu;
     id first = objc_getAssociatedObject(bth, "firstObject");
    promoArr = [oneModel.promDict valueForKey:@"promoArr"];
    for (int i = 0; i<promoArr.count; i++) {
        BuyModel *proModel = promoArr[i];
        if ([first isEqualToString:proModel.k7mf007]) {
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:NSRoundDown
                                               
                                               scale:0
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
           orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.orderCount]];
            
            NSDecimalNumber *bigOrder= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.orderCount]];
            NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf005]];
            NSDecimalNumber *base =  [bigOrder decimalNumberByDividingBy:meijiao];
            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
            NSDecimalNumber *total = [base decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
            
            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf012]] decimalNumberByMultiplyingBy:total];
            NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
            chu =  [orderCount decimalNumberByAdding:jia withBehavior:roundUp];
            NSComparisonResult result = [chu compare:zengText];
                        if (result == NSOrderedDescending  ) {
                            restDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",chu]];
                        }else {
            proModel.orderCount = chu;
            [promoArr replaceObjectAtIndex:i withObject:proModel];
            
                        }
            
        }
    }
    if ( _proDelegate && [_peiDelegate respondsToSelector:@selector(getpro:withIndex:withDec:withYunCount:withNowCount:)]) {
        [_proDelegate getpro:promoArr withIndex:selfIndex withDec:restDec withYunCount:orderCount withNowCount:chu];
    }
    

}

- (void)proJian:(UIButton *)bth {
    NSDecimalNumber *bijiao = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSDecimalNumber *restDec;
    NSMutableArray *promoArr = [NSMutableArray new];
    promoArr = [oneModel.promDict valueForKey:@"promoArr"];
    NSDecimalNumber *chu;
    NSDecimalNumber *orderCount;
      id first = objc_getAssociatedObject(bth, "firstObject");
    for (int i = 0; i<promoArr.count; i++) {
        BuyModel *proModel = promoArr[i];
        if ([first isEqualToString:proModel.k7mf007]) {
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:NSRoundDown
                                               
                                               scale:0
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
            orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.orderCount]];
            
            NSDecimalNumber *bigOrder= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.orderCount]];
            NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf005]];
            NSDecimalNumber *base =  [bigOrder decimalNumberByDividingBy:meijiao];
            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
            NSDecimalNumber *total = [base decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
            
            NSDecimalNumber *zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",proModel.k7mf012]] decimalNumberByMultiplyingBy:total];
            NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
           
//            if ([[NSString stringWithFormat:@"%@",chu] isEqualToString:@"0"]  ) {
//                restDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",chu]];
//            }else {
            
            chu =  [orderCount decimalNumberBySubtracting:jia withBehavior:roundUp];
            NSString *str = [NSString stringWithFormat:@"%@",chu];
            if ([str floatValue]>=0) {
                
                proModel.orderCount = chu;
                [promoArr replaceObjectAtIndex:i withObject:proModel];
            }
           
//            }
            
        }
    }
    if ( _proDelegate && [_peiDelegate respondsToSelector:@selector(getpro:withIndex:withDec:withYunCount:withNowCount:)]) {
        [_proDelegate getpro:promoArr withIndex:selfIndex withDec:restDec withYunCount:orderCount withNowCount:chu];
    }
  
}
- (void)peiJIa:(UIButton *)bth {
 NSMutableArray *buyArr = [oneModel.buyDict valueForKey:@"buyArr"];
    NSDecimalNumber *orderCount;
    NSDecimalNumber *chu;
      id first = objc_getAssociatedObject(bth, "firstObject");
    for (int i = 0; i<buyArr.count; i++) {
        BuyModel *buyModel = buyArr[i];
        if ([first isEqualToString:buyModel.k7mf007]) {
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:NSRoundDown
                                               
                                               scale:0
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
             orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.orderCount]];
               NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
           chu =  [orderCount decimalNumberByAdding:jia withBehavior:roundUp];
            buyModel.orderCount = chu;
            [buyArr replaceObjectAtIndex:i withObject:buyModel];

        }
    }
    if ( _peiDelegate && [_peiDelegate respondsToSelector:@selector(getpei:withIndex:withDec:withYunCount:withNowCount:)]) {
        [_peiDelegate getpei:buyArr withIndex:selfIndex withDec:nil withYunCount:orderCount withNowCount:chu];
    }
}
- (void)peiJIan:(UIButton *)bth {
    NSDecimalNumber *restDec;
    NSMutableArray *buyArr = [NSMutableArray new];
    buyArr = [oneModel.buyDict valueForKey:@"buyArr"];
    NSDecimalNumber *orderCount;
    NSDecimalNumber *zengText;
    NSDecimalNumber *chu;
     id first = objc_getAssociatedObject(bth, "firstObject");
    for (int i = 0; i<buyArr.count; i++) {
        BuyModel *buyModel = buyArr[i];
        if ([first isEqualToString:buyModel.k7mf007]) {
            NSDecimalNumberHandler *roundUp = [NSDecimalNumberHandler
                                               
                                               decimalNumberHandlerWithRoundingMode:NSRoundDown
                                               
                                               scale:0
                                               
                                               raiseOnExactness:NO
                                               
                                               raiseOnOverflow:NO
                                               
                                               raiseOnUnderflow:NO
                                               
                                               raiseOnDivideByZero:YES];
           orderCount= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.orderCount]];
            
            NSDecimalNumber *bigOrder= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%ld",(long)oneModel.orderCount]];
            NSDecimalNumber * meijiao = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.k7mf005]];
            NSDecimalNumber *base =  [bigOrder decimalNumberByDividingBy:meijiao];
            NSDecimalNumber*discount = [NSDecimalNumber decimalNumberWithString:@"1.0000"];
            NSDecimalNumber *total = [base decimalNumberByMultiplyingBy:discount withBehavior:roundUp];
            
            zengText = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",buyModel.k7mf012]] decimalNumberByMultiplyingBy:total];
            NSDecimalNumber *jia= [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1.0000"]];
            chu =  [orderCount decimalNumberBySubtracting:jia withBehavior:roundUp];
               NSComparisonResult result = [chu compare:zengText];
            if (result == NSOrderedAscending  ) {
                restDec = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",zengText]];
            }else {
                buyModel.orderCount = chu;
                [buyArr replaceObjectAtIndex:i withObject:buyModel];

            }
            
        }
    }
    if ( _peiDelegate && [_peiDelegate respondsToSelector:@selector(getpei:withIndex:withDec:withYunCount:withNowCount:)]) {
        [_peiDelegate getpei:buyArr withIndex:selfIndex withDec:restDec withYunCount:orderCount withNowCount:chu];
    }

}
-(void)orderButton {

    if (_tanDelegate &&[_tanDelegate respondsToSelector:@selector(getwithKey:withIndex:withModel:withweizhi:)]) {
        [_tanDelegate getwithKey:oneModel.keyStr withIndex:oneModel.index withModel:oneModel withweizhi:@"xia"];
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
        if (yu == 0) {
            count = shang *beiNum;
        }else{
            count = (shang+1)*beiNum;
        }
        self.numCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",count]];
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
    

        NSDecimalNumber *num = self.numCount;
    
        if (![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"0"]&& ![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"无货"]&&![[NSString stringWithFormat:@"%@",oneModel.sys001Text] isEqualToString:@"有货"]&&![BGControl isNULLOfString:oneModel.sys001Text]) {
            num = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.sys001Text]];
            
        }
        NSComparisonResult res = [self.numCount compare:num];
        if (res == NSOrderedDescending) {
            self.numCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.sys001Text]];
            desStr = [NSString stringWithFormat:@"%@%@%@%@",oneModel.k1dt002,@"可定量最多为",[BGControl notRounding:num afterPoint:lpdt036],oneModel.k1dt005];
            
            
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
                
                if (result == NSOrderedDescending) {
                    price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.originalK1dt201]];
                }
            }
            if (result == NSOrderedAscending ||result == NSOrderedSame) {
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
            //                NSString *str = [NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]];
            NSDecimalNumber *str = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[arrone[i] valueForKey:@"pric002"]]];
            NSComparisonResult result = [self.numCount compare:str];
            if (i == 0) {
                if (result == NSOrderedDescending) {
                    price = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",oneModel.originalK1dt201]];
                }
            }
            if (result == NSOrderedAscending || result == NSOrderedSame) {
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

- (void)showOrderNums:(NSDecimalNumber *) count withPrice:(NSDecimalNumber *)price {
//    orderCountField.text = [NSString stringWithFormat:@"%@",count];
    NSInteger lpdt042 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
    
    NSString *priceStr = [BGControl notRounding:price afterPoint:lpdt042];
    priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
