//
//  BackCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/6.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BackCell.h"
#import "EditModel.h"
#import "BGControl.h"
@implementation BackCell{
    UIView *bigView;
    UILabel *titleLab;
    UILabel *priceLab;
    UIImageView *jianImg;
    UITextField *orderCountField;
    UIImageView *jiaImg;
    UIButton *minBth;
    UIButton *addBth;
    UIView *bottomView;
    NSInteger selfIndex;
    UIButton *orderButton;
    NSInteger lpdt036;
    NSInteger lpdt042;
    EditModel *oneModel;
    
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
    orderCountField.enabled = NO;
    bottomView = [UIView new];
    bottomView.backgroundColor = [UIColor whiteColor];
    orderCountField.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview: bottomView];
    bottomView.tag = 1001;
    addBth.tag = 1002;
    minBth.tag = 1003;
    orderButton.tag = 1004;
    [addBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [minBth addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [orderButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)layoutSubviews {
    
    [super layoutSubviews];
    //    self.contentView.backgroundColor = kTabBarColor;
}
- (void)showModelWithModel:(EditModel *)model{
    oneModel = model;
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt042"] ] integerValue];
    for (UIView *view in [bottomView subviews]) {
        [view removeFromSuperview];
    }
    CGFloat Imgwidth = 80;
    CGFloat shopWidth = 24;
    CGFloat marginWidth = 15;
    
    
    if (kScreenSize.width == 320) {
        Imgwidth = 60;
        shopWidth = 18;
        marginWidth = 10;
    }
  
    CGFloat numWidth = [BGControl labelAutoCalculateRectWith:@"9999.999" FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, 50)].width;
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
    titleLab.text = model.k1dt002;
    priceLab.text = [NSString stringWithFormat:@"￥%@/%@",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042],model.k1dt005];
    orderCountField.text = [BGControl notRounding:model.orderCount afterPoint:lpdt036];;;
    CGFloat priceWidth = [BGControl labelAutoCalculateRectWith:priceLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
    priceLab.frame = CGRectMake(kScreenSize.width - marginWidth-shopWidth*2-10 -priceWidth-orderCountField.frame.size.width, 10, priceWidth, 30);
    
    titleLab.frame = CGRectMake(marginWidth , 10, kScreenSize.width - marginWidth-shopWidth*2-10-priceWidth -10-orderCountField.frame.size.width, 30);
    
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
}

-(void)buttonClick:(UIButton *)bth {
    NSDecimalNumber *numCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    NSDecimalNumber*jiafa1 = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",@"1"]];
    if (bth.tag == 1004) {
        if (_inputOnedelegate && [_inputOnedelegate respondsToSelector:@selector(backWithModel:withTag:)]) {
            [_inputOnedelegate  backWithModel:oneModel withTag:bth.tag];
        }
    }else{
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
            
        }
        if (_backDelegate && [_backDelegate respondsToSelector:@selector(backWithModel:withTag:withCount:)]) {
            [_backDelegate backWithModel:oneModel withTag:bth.tag withCount:numCount];
        }

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
