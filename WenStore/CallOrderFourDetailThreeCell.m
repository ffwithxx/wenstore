//
//  CallOrderFourDetailThreeCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderFourDetailThreeCell.h"

@implementation CallOrderFourDetailThreeCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

//- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict withselfIndex:(NSInteger) selfIndext withIndex:(NSInteger) currentIndex{
//    for (UIView *view in [bottomView subviews]) {
//        //        if (view.tag ==2001 ||view.tag == 2002 || view.tag == 2003)  {
//        [view removeFromSuperview];
//        //        }
//    }
//    NSLog(@"%f",kScreenSize.width);
//    NSString  * lpdt036Str = [[NSUserDefaults standardUserDefaults]valueForKey:@"lpdt036"];
//    selfIndext = selfIndext;
//    CGFloat Imgwidth = 80;
//    CGFloat shopWidth = 24;
//    CGFloat marginWidth = 15;
//    if (kScreenSize.width == 320) {
//        Imgwidth = 60;
//        shopWidth = 18;
//        marginWidth = 10;
//    }
//    CGFloat marginHei = (50-shopWidth)/2;
//    bottomView.frame = CGRectMake(0, 50, kScreenSize.width, 0);
//    bigView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
//    bigView.backgroundColor = [UIColor whiteColor];
//    jiaImg.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHei, shopWidth, shopWidth);
//    jianImg.frame = CGRectMake(kScreenSize.width   -marginWidth-shopWidth*3, marginHei, shopWidth, shopWidth);
//    addBth.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth, marginHei, shopWidth, shopWidth);
//    minBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*3, marginHei, shopWidth, shopWidth);
//    orderCountField.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth*2, marginHei, shopWidth, shopWidth);
//    orderButton.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth*2, marginHei, shopWidth, shopWidth);
//    priceLab.frame = CGRectMake(kScreenSize.width-marginWidth-shopWidth*3-10, 10, 48, 30);
//    titleLab.frame = CGRectMake(marginWidth, 10, 95, 30);
//    otherView.frame = CGRectMake(0, 45, self.contentView.frame.size.width, 80);
//    //    otherView.backgroundColor = [UIColor redColor];
//    [minBth addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
//    [addBth addTarget:self action:@selector(plusclick) forControlEvents:UIControlEventTouchUpInside];
//    [orderButton addTarget:self action:@selector(orderButton) forControlEvents:UIControlEventTouchUpInside];
//    bottomView.backgroundColor = [UIColor whiteColor];
//    bigView.backgroundColor = [UIColor whiteColor];
//    
//    self.numCount =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]]];;
//    bigView.tag = 1001;
//    oneModel = model;
//    rightDic = rightDict;
//    
//    bigDic = dict;
//    titleLab.text = model.k1dt002;
//    orderCountField.text = [BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]];
//    
//    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:orderCountField.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
//    if (orderWidth>shopWidth) {
//        orderCountField.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        orderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        
//        jianImg.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//        minBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//    }
//    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
//        jianImg.hidden = YES;
//        minBth.hidden = YES;
//    }else {
//        jianImg.hidden = NO;
//        minBth.hidden = NO;
//    }
//    NSDictionary *lpdt042dict = [dict valueForKey:@"precisionSetting"] ;
//    NSString *str2  = [NSString stringWithFormat:@"%@",[lpdt042dict valueForKey:@"lpdt042"]];
//    NSInteger lpdt042 = [str2 integerValue];
//    NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
//    priceLab.text =  [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
//    CGFloat priceWidth = [BGControl labelAutoCalculateRectWith:priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
//    priceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-10 -priceWidth-orderCountField.frame.size.width, 10, priceWidth, 30);
//    
//    priceLab.textAlignment = NSTextAlignmentRight;
//    titleLab.frame = CGRectMake(marginWidth, 10, kScreenSize.width - marginWidth-shopWidth*2-10-priceWidth -10-orderCountField.frame.size.width, 30);
//    NSArray *arr = [rightDict valueForKey:@"pricConfigs"];
//    //    NSArray *arrFree = [rightDict valueForKey:@"freeActivities"];
//    //    NSArray *arrpromo= [rightDict valueForKey:@"promoActivities"];
//    //    NSArray *buyTogetherArr= [rightDict valueForKey:@"buyTogetherActivities"];
//    NSInteger sum = 0;
//    CGFloat sumHei = 0;
//    if (model.hasLimiteInfo == true) {
//        CGFloat marginHeiTwo = (40-shopWidth)/2;
//        if (model.hasFree == true) {
//            NSArray *freeArr = [model.freeDict valueForKey:@"arrFree"];
//            
//            for (int i = 0; i < freeArr.count ; i++) {
//                BuyModel *freeModel = freeArr[i];
//                
//                
//                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  sumHei , self.contentView.frame.size.width, 40)];
//                view.tag = 2001;
//                [bottomView addSubview:view];
//                for (UIView *view1 in [view subviews]) {
//                    
//                    [view1 removeFromSuperview];
//                    
//                }
//                
//                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zeng.png"]];
//                imgView.frame = CGRectMake(marginWidth+10, 12, 16, 16);
//                
//                [view addSubview:imgView];
//                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jiaImgView.image = [UIImage imageNamed:@"jiagray.png"];
//                
//                [view addSubview:jiaImgView];
//                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                
//                jianImgView.image = [UIImage imageNamed:@"jiangray.png"];
//                [view addSubview:jianImgView];
//                UILabel *zengOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                
//                zengOrderLab.text = [BGControl notRounding:freeModel.orderCount afterPoint:[lpdt036Str integerValue]];
//                ;
//                zengOrderLab.textColor = kTextGrayColor;
//                zengOrderLab.textAlignment = NSTextAlignmentCenter;
//                zengOrderLab.font = [UIFont systemFontOfSize:15];
//                [view addSubview:zengOrderLab];
//                UILabel *ZpriceLab = [[UILabel alloc] init];
//                ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:freeModel.k7mf017 afterPoint:lpdt042],@"/",freeModel.k7mf011];
//                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, 24)].width;
//                CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//                if (jianorderWidth>shopWidth) {
//                    zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth-24, marginHeiTwo, shopWidth, shopWidth);
//                    
//                }
//                
//                ZpriceLab.font = [UIFont systemFontOfSize:15];
//                ZpriceLab.textColor = kredColor;
//                
//                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
//                [view addSubview:ZpriceLab];
//                //                         ZpriceLab.tag = 2002;
//                ZpriceLab.textAlignment = NSTextAlignmentRight;
//                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
//                
//                FreetitleLab.text = [NSString stringWithFormat:@"%@",freeModel.k7mf008];
//                FreetitleLab.textColor = kTextGrayColor;
//                FreetitleLab.font = [UIFont systemFontOfSize:15];
//                FreetitleLab.textAlignment = NSTextAlignmentLeft;
//                [view addSubview:FreetitleLab];
//                //                         zengOrderLab.tag = 2002;
//                //                         FreetitleLab.tag = 2003;
//                //                         jiaImgView.tag = 2002;
//                //                         imgView.tag = 2002;
//                //                         jianImgView.tag = 2002;
//                sumHei = sumHei +40;
//                
//                
//            }
//            
//        }
//        
//        if (model.hasBuyTogether==true ) {
//            //            NSArray *buyArr = [model.buyDict valueForKey:@"buyArr"];
//            //            for (int i = 0; i <buyArr.count; i++) {
//            //                BuyModel *buyModel = buyArr[i];
//            //
//            //                        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  sumHei , self.contentView.frame.size.width, 40)];
//            //                        view.tag = 2001;
//            //                        [bottomView addSubview:view];
//            //                        for (UIView *view1 in [view subviews]) {
//            //
//            //                            [view1 removeFromSuperview];
//            //
//            //                        }
//            //                        UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"pei.png"]];
//            //                        imgView.frame = CGRectMake(marginWidth+10, 12, 16, 16);
//            //                        [bottomView addSubview:imgView];
//            //                        UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//            //                         jiaImgView.image = [UIImage imageNamed:@"jiaGree.png"];
//            //                        [view addSubview:jiaImgView];
//            //                        UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//            //                        jianImgView.image = [UIImage imageNamed:@"jianGree.png"];
//            //                        [view addSubview:jianImgView];
//            //                        UIButton *peiJiaBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//            //                        UIButton *peiJianBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//            //
//            //                        objc_setAssociatedObject(peiJianBth, "firstObject", buyModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            //                        objc_setAssociatedObject(peiJiaBth, "firstObject", buyModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            //                        [peiJiaBth addTarget:self action:@selector(peiJIa:) forControlEvents:UIControlEventTouchUpInside];
//            //                         [peiJianBth addTarget:self action:@selector(peiJIan:) forControlEvents:UIControlEventTouchUpInside];
//            //                        UILabel *zengOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//            //                        zengOrderLab.text = [BGControl notRounding:buyModel.orderCount afterPoint:[lpdt036Str integerValue]];
//            //;
//            //                        zengOrderLab.textColor = kTextGrayColor;
//            //                        zengOrderLab.textAlignment = NSTextAlignmentCenter;
//            //                        zengOrderLab.font = [UIFont systemFontOfSize:15];
//            //                        [view addSubview:zengOrderLab];
//            //                        UIButton *zengOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//            //                        zengOrderButton.tag = [buyModel.k7mf007 integerValue];
//            //                        //                        zengOrderButton.backgroundColor = kTabBarColor;
//            //                        [zengOrderButton addTarget:self action:@selector(zengOneFile:) forControlEvents:UIControlEventTouchUpInside];
//            //                        [view addSubview:zengOrderButton];
//            //
//            //                        CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//            //                        if (jianorderWidth>shopWidth) {
//            //                            zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//            //                            zengOrderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//            ////                            zengOrderLab.backgroundColor = kTabBarColor;
//            //                            peiJianBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//            //                            jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//            //
//            //                        }
//            //
//            //
//            //
//            //                        UILabel *ZpriceLab = [[UILabel alloc] init];
//            //                        ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:buyModel.k7mf017 afterPoint:lpdt042],@"/",buyModel.k7mf011];
//            //                        CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, shopWidth)].width;
//            //                        ZpriceLab.font = [UIFont systemFontOfSize:15];
//            //                        ZpriceLab.textColor = kredColor;
//            //                       ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);                      [view addSubview:ZpriceLab];
//            ////                        ZpriceLab.tag = 2002;
//            //                        ZpriceLab.textAlignment = NSTextAlignmentRight;
//            //                       UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
//            //                        FreetitleLab.text = [NSString stringWithFormat:@"%@",buyModel.k7mf008];
//            //                        FreetitleLab.textColor = kTextGrayColor;
//            //                        FreetitleLab.font = [UIFont systemFontOfSize:15];
//            //                        FreetitleLab.textAlignment = NSTextAlignmentLeft;
//            //                        [view addSubview:FreetitleLab];
//            //                        peiJiaBth.enabled = YES;
//            //                        [view addSubview:peiJiaBth];
//            //                        [view addSubview:peiJianBth];
//            ////                        zengOrderLab.tag = 2002;
//            ////                        FreetitleLab.tag = 2003;
//            ////                        jiaImgView.tag = 2002;
//            ////                        imgView.tag = 2002;
//            ////                        jianImgView.tag = 2002;
//            //
//            //                        sumHei = sumHei +40;
//            //                        if (model.orderCount<0) {
//            //                            jianImgView.hidden = YES;
//            //                            peiJianBth.hidden = YES;
//            //                        }else {
//            //                            jianImgView.hidden = NO;
//            //                            peiJianBth.hidden = NO;
//            //                        }
//            //
//            //
//            //                    }
//            
//            
//            
//        }
//        
//        if (model.hasPromo==true ) {
//            NSArray *promArr = [model.promDict valueForKey:@"promoArr"];
//            for (int i = 0;i<promArr.count ; i++) {
//                BuyModel *promModel = promArr[i];
//                
//                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sumHei , self.contentView.frame.size.width, 40)];
//                view.tag = 2001;
//                [bottomView addSubview:view];
//                for (UIView *view1 in [view subviews]) {
//                    
//                    [view1 removeFromSuperview];
//                    
//                }
//                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hui.png"]];
//                imgView.frame =  CGRectMake(marginWidth+10, 12, 16, 16);
//                [view addSubview:imgView];
//                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jiaImgView.image = [UIImage imageNamed:@"jiaGree.png"];
//                [view addSubview:jiaImgView];
//                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jianImgView.image = [UIImage imageNamed:@"jianGree.png"];
//                [view addSubview:jianImgView];
//                UIButton *peiJiaBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                UIButton *peiJianBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                peiJianBth.tag = [promModel.k7mf007 integerValue];
//                peiJiaBth.tag = [promModel.k7mf007 integerValue];
//                objc_setAssociatedObject(peiJianBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                objc_setAssociatedObject(peiJiaBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                [peiJiaBth addTarget:self action:@selector(proJia:) forControlEvents:UIControlEventTouchUpInside];
//                [peiJianBth addTarget:self action:@selector(proJian:) forControlEvents:UIControlEventTouchUpInside];
//                UILabel *zengOrderLab =[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                zengOrderLab.text = [BGControl notRounding:promModel.orderCount afterPoint:[lpdt036Str integerValue]];
//                zengOrderLab.textColor = kTextGrayColor;
//                zengOrderLab.textAlignment = NSTextAlignmentCenter;
//                zengOrderLab.font = [UIFont systemFontOfSize:15];
//                [view addSubview:zengOrderLab];
//                UIButton *zengOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                zengOrderButton.tag = [promModel.k7mf007 integerValue];
//                [zengOrderButton addTarget:self action:@selector(zengFile:) forControlEvents:UIControlEventTouchUpInside];
//                
//                CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//                if (jianorderWidth>shopWidth) {
//                    zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    zengOrderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    
//                    peiJianBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//                    jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//                }
//                UILabel *ZpriceLab = [[UILabel alloc] init];
//                ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:promModel.k7mf017 afterPoint:lpdt042],@"/",promModel.k7mf011];
//                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, shopWidth)].width;
//                ZpriceLab.font = [UIFont systemFontOfSize:15];
//                ZpriceLab.textColor = kredColor;
//                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
//                [view addSubview:ZpriceLab];
//                //                        ZpriceLab.tag = 2002;
//                ZpriceLab.textAlignment = NSTextAlignmentRight;
//                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
//                
//                FreetitleLab.text = [NSString stringWithFormat:@"%@",promModel.k7mf008];
//                FreetitleLab.textColor = kTextGrayColor;
//                FreetitleLab.font = [UIFont systemFontOfSize:15];
//                FreetitleLab.textAlignment = NSTextAlignmentLeft;
//                [view addSubview:FreetitleLab];
//                peiJiaBth.enabled = YES;
//                [view addSubview:peiJiaBth];
//                [view addSubview:peiJianBth];
//                [view addSubview:zengOrderButton];
//                sumHei = sumHei +40;
//                
//            }
//            
//            
//        }
//        
//        bottomView.frame = CGRectMake(0, 50, kScreenSize.width, sumHei);
//        lineView.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame), kScreenSize.width, 15);
//        
//        if (_Bottomdelegate && [_Bottomdelegate respondsToSelector:@selector(getBottomHei:withIndex:)]) {
//            [_Bottomdelegate getBottomHei:sumHei+50+15 withIndex:selfIndext];
//        }
//    }else {
//        lineView.frame = CGRectMake(0, CGRectGetMaxY(bigView.frame), kScreenSize.width, 15);
//    }
//}






//- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict withselfIndex:(NSInteger) selfIndext withIndex:(NSInteger) currentIndex{
//    for (UIView *view in [bottomView subviews]) {
//        [view removeFromSuperview];
//    }
//    
//    NSString  * lpdt036Str = [[NSUserDefaults standardUserDefaults]valueForKey:@"lpdt036"];
//    selfIndext = selfIndext;
//    CGFloat Imgwidth = 80;
//    CGFloat shopWidth = 24;
//    CGFloat marginWidth = 15;
//    if (kScreenSize.width == 320) {
//        Imgwidth = 60;
//        shopWidth = 18;
//        marginWidth = 10;
//    }
//    CGFloat marginHei = (50-shopWidth)/2;
//    bottomView.frame = CGRectMake(0, 50, kScreenSize.width, 0);
//    bigView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
//    bigView.backgroundColor = [UIColor whiteColor];
//    jiaImg.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHei, shopWidth, shopWidth);
//    jianImg.frame = CGRectMake(kScreenSize.width   -marginWidth-shopWidth*3, marginHei, shopWidth, shopWidth);
//    addBth.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth, marginHei, shopWidth, shopWidth);
//    minBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*3, marginHei, shopWidth, shopWidth);
//    orderCountField.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth*2, marginHei, shopWidth, shopWidth);
//    orderButton.frame = CGRectMake(kScreenSize.width  -marginWidth-shopWidth*2, marginHei, shopWidth, shopWidth);
//    priceLab.frame = CGRectMake(kScreenSize.width-marginWidth-shopWidth*3-10, 10, 48, 30);
//    titleLab.frame = CGRectMake(marginWidth, 10, 95, 30);
//    otherView.frame = CGRectMake(0, 45, self.contentView.frame.size.width, 80);
//    //    otherView.backgroundColor = [UIColor redColor];
//    [minBth addTarget:self action:@selector(clickMin:) forControlEvents:UIControlEventTouchUpInside];
//    [addBth addTarget:self action:@selector(plusclick) forControlEvents:UIControlEventTouchUpInside];
//    [orderButton addTarget:self action:@selector(orderButton) forControlEvents:UIControlEventTouchUpInside];
//    bottomView.backgroundColor = [UIColor whiteColor];
//    bigView.backgroundColor = [UIColor whiteColor];
//    
//    self.numCount =[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]]];;
//    bigView.tag = 1001;
//    oneModel = model;
//    rightDic = rightDict;
//    
//    bigDic = dict;
//    titleLab.text = model.k1dt002;
//    orderCountField.text = [BGControl notRounding:model.orderCount afterPoint:[lpdt036Str integerValue]];
//    
//    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:orderCountField.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
//    if (orderWidth>shopWidth) {
//        orderCountField.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        orderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-orderWidth, marginHei, orderWidth, shopWidth);
//        
//        jianImg.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//        minBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-orderWidth, marginHei, shopWidth, shopWidth);
//    }
//    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
//        jianImg.hidden = YES;
//        minBth.hidden = YES;
//    }else {
//        jianImg.hidden = NO;
//        minBth.hidden = NO;
//    }
//    NSDictionary *lpdt042dict = [dict valueForKey:@"precisionSetting"] ;
//    NSString *str2  = [NSString stringWithFormat:@"%@",[lpdt042dict valueForKey:@"lpdt042"]];
//    NSInteger lpdt042 = [str2 integerValue];
//    NSString *priceStr = [BGControl notRounding:model.originaltest afterPoint:lpdt042];
//    priceLab.text =  [NSString stringWithFormat:@"%@%@%@%@",@"￥",priceStr,@"/",model.k1dt005];
//    CGFloat priceWidth = [BGControl labelAutoCalculateRectWith:priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
//    priceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-10 -priceWidth-orderCountField.frame.size.width, 10, priceWidth, 30);
//    
//    priceLab.textAlignment = NSTextAlignmentRight;
//    titleLab.frame = CGRectMake(marginWidth, 10, kScreenSize.width - marginWidth-shopWidth*2-10-priceWidth -10-orderCountField.frame.size.width, 30);
//    NSArray *arr = [rightDict valueForKey:@"pricConfigs"];
//    NSInteger sum = 0;
//    CGFloat sumHei = 0;
//    if (model.hasLimiteInfo == true) {
//        CGFloat marginHeiTwo = (40-shopWidth)/2;
//        if (model.hasFree == true) {
//            NSArray *freeArr = [model.freeDict valueForKey:@"arrFree"];
//            
//            for (int i = 0; i < freeArr.count ; i++) {
//                BuyModel *freeModel = freeArr[i];
//                
//                
//                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0,  sumHei , self.contentView.frame.size.width, 40)];
//                view.tag = 2001;
//                [bottomView addSubview:view];
//                for (UIView *view1 in [view subviews]) {
//                    
//                    [view1 removeFromSuperview];
//                    
//                }
//                
//                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"zeng.png"]];
//                imgView.frame = CGRectMake(marginWidth+10, 12, 16, 16);
//                
//                [view addSubview:imgView];
//                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jiaImgView.image = [UIImage imageNamed:@"jiagray.png"];
//                
//                [view addSubview:jiaImgView];
//                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                
//                jianImgView.image = [UIImage imageNamed:@"jiangray.png"];
//                [view addSubview:jianImgView];
//                UILabel *zengOrderLab = [[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                
//                zengOrderLab.text = [BGControl notRounding:freeModel.orderCount afterPoint:[lpdt036Str integerValue]];
//                ;
//                zengOrderLab.textColor = kTextGrayColor;
//                zengOrderLab.textAlignment = NSTextAlignmentCenter;
//                zengOrderLab.font = [UIFont systemFontOfSize:15];
//                [view addSubview:zengOrderLab];
//                UILabel *ZpriceLab = [[UILabel alloc] init];
//                ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:freeModel.k7mf017 afterPoint:lpdt042],@"/",freeModel.k7mf011];
//                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, 24)].width;
//                CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//                if (jianorderWidth>shopWidth) {
//                    zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth-24, marginHeiTwo, shopWidth, shopWidth);
//                    
//                }
//                
//                ZpriceLab.font = [UIFont systemFontOfSize:15];
//                ZpriceLab.textColor = kredColor;
//                
//                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
//                [view addSubview:ZpriceLab];
//                //                         ZpriceLab.tag = 2002;
//                ZpriceLab.textAlignment = NSTextAlignmentRight;
//                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
//                
//                FreetitleLab.text = [NSString stringWithFormat:@"%@",freeModel.k7mf008];
//                FreetitleLab.textColor = kTextGrayColor;
//                FreetitleLab.font = [UIFont systemFontOfSize:15];
//                FreetitleLab.textAlignment = NSTextAlignmentLeft;
//                [view addSubview:FreetitleLab];
//                sumHei = sumHei +40;
//            }
//            
//        }//赠送
//        if (model.hasPromo==true ) {
//            NSArray *promArr = [model.promDict valueForKey:@"promoArr"];
//            for (int i = 0;i<promArr.count ; i++) {
//                BuyModel *promModel = promArr[i];
//                
//                UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, sumHei , self.contentView.frame.size.width, 40)];
//                view.tag = 2001;
//                [bottomView addSubview:view];
//                for (UIView *view1 in [view subviews]) {
//                    
//                    [view1 removeFromSuperview];
//                    
//                }
//                UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"hui.png"]];
//                imgView.frame =  CGRectMake(marginWidth+10, 12, 16, 16);
//                [view addSubview:imgView];
//                UIImageView *jiaImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jiaImgView.image = [UIImage imageNamed:@"jiaGree.png"];
//                [view addSubview:jiaImgView];
//                UIImageView *jianImgView = [[UIImageView alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                jianImgView.image = [UIImage imageNamed:@"jianGree.png"];
//                [view addSubview:jianImgView];
//                UIButton *peiJiaBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - marginWidth-shopWidth, marginHeiTwo, shopWidth, shopWidth)];
//                UIButton *peiJianBth = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width - shopWidth*3-marginWidth, marginHeiTwo, shopWidth, shopWidth)];
//                peiJianBth.tag = [promModel.k7mf007 integerValue];
//                peiJiaBth.tag = [promModel.k7mf007 integerValue];
//                objc_setAssociatedObject(peiJianBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                objc_setAssociatedObject(peiJiaBth, "firstObject", promModel.k7mf007, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//                [peiJiaBth addTarget:self action:@selector(proJia:) forControlEvents:UIControlEventTouchUpInside];
//                [peiJianBth addTarget:self action:@selector(proJian:) forControlEvents:UIControlEventTouchUpInside];
//                UILabel *zengOrderLab =[[UILabel alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                zengOrderLab.text = [BGControl notRounding:promModel.orderCount afterPoint:[lpdt036Str integerValue]];
//                zengOrderLab.textColor = kTextGrayColor;
//                zengOrderLab.textAlignment = NSTextAlignmentCenter;
//                zengOrderLab.font = [UIFont systemFontOfSize:15];
//                [view addSubview:zengOrderLab];
//                UIButton *zengOrderButton = [[UIButton alloc] initWithFrame:CGRectMake(kScreenSize.width -marginWidth-shopWidth*2, marginHeiTwo, shopWidth, shopWidth)];
//                zengOrderButton.tag = [promModel.k7mf007 integerValue];
//                [zengOrderButton addTarget:self action:@selector(zengFile:) forControlEvents:UIControlEventTouchUpInside];
//                
//                CGFloat jianorderWidth = [BGControl labelAutoCalculateRectWith:zengOrderLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -shopWidth*3-marginWidth, 30)].width;
//                if (jianorderWidth>shopWidth) {
//                    zengOrderLab.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    zengOrderButton.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth-jianorderWidth, marginHeiTwo, jianorderWidth, shopWidth);
//                    
//                    peiJianBth.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//                    jianImgView.frame = CGRectMake(kScreenSize.width -marginWidth-shopWidth*2-jianorderWidth, marginHeiTwo, shopWidth, shopWidth);
//                }
//                UILabel *ZpriceLab = [[UILabel alloc] init];
//                ZpriceLab.text = [NSString stringWithFormat:@"%@%@%@%@",@"￥",[BGControl notRounding:promModel.k7mf017 afterPoint:lpdt042],@"/",promModel.k7mf011];
//                CGFloat priceWid = [BGControl labelAutoCalculateRectWith:ZpriceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width, shopWidth)].width;
//                ZpriceLab.font = [UIFont systemFontOfSize:15];
//                ZpriceLab.textColor = kredColor;
//                ZpriceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-5 - priceWid-zengOrderLab.frame.size.width, marginHeiTwo, priceWid, shopWidth);
//                [view addSubview:ZpriceLab];
//                //                        ZpriceLab.tag = 2002;
//                ZpriceLab.textAlignment = NSTextAlignmentRight;
//                UILabel *FreetitleLab = [[UILabel alloc] initWithFrame:CGRectMake(marginWidth*2+16 +10, 0, kScreenSize.width - marginWidth*2-16-ZpriceLab.frame.size.width-10-marginWidth-shopWidth*2-orderCountField.frame.size.width, 40)];
//                
//                FreetitleLab.text = [NSString stringWithFormat:@"%@",promModel.k7mf008];
//                FreetitleLab.textColor = kTextGrayColor;
//                FreetitleLab.font = [UIFont systemFontOfSize:15];
//                FreetitleLab.textAlignment = NSTextAlignmentLeft;
//                [view addSubview:FreetitleLab];
//                peiJiaBth.enabled = YES;
//                [view addSubview:peiJiaBth];
//                [view addSubview:peiJianBth];
//                [view addSubview:zengOrderButton];
//                sumHei = sumHei +40;
//                
//            }
//            
//        }//优惠
//        
//        
//        
//    }
//    if (sumHei != 0) {
//        bottomView.frame = CGRectMake(0, 50, kScreenSize.width, sumHei);
//        lineView.frame = CGRectMake(0, CGRectGetMaxY(bottomView.frame), kScreenSize.width, 15);
//        
//        if (_Bottomdelegate && [_Bottomdelegate respondsToSelector:@selector(getBottomHei:withIndex:)]) {
//            [_Bottomdelegate getBottomHei:sumHei+50+15 withIndex:selfIndext];
//        }
//        
//    }else {
//        lineView.frame = CGRectMake(0, CGRectGetMaxY(bigView.frame), kScreenSize.width, 15);
//    }
//    
//    
//    
//}
//

@end
