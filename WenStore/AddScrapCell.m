//
//  AddScrapCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "AddScrapCell.h"
#import "BGControl.h"

@implementation AddScrapCell {
    AddScrapModel *oneModel;
    NSDecimalNumber *priceOne;;
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
    
    self.aView = [UIView new];
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
    self.bigView = [UIView new];
    [self.contentView addSubview:self.bigView];
    self.lastView.backgroundColor = kBackGroungColor;
    self.resonView = [UIView new];
    [self.bigView addSubview:self.resonView];
    self.resonButton = [UIButton new];
    
    self.addOneImg = [UIImageView new];
    [self.resonView addSubview:self.addOneImg];
    self.resonTextFile = [UITextField new];
    [self.resonView addSubview:self.resonTextFile];
    self.fgTwoView = [UIView  new];
    self.fgTwoView.backgroundColor = kLineColor;
    [self.resonView addSubview:self.fgTwoView];
    self.resonView.backgroundColor = [UIColor whiteColor];
    [self.resonView addSubview:self.resonButton];
    //    @property (strong, nonatomic)  UIView *fgTwoView;
    //    @property (strong, nonatomic)  UIView *resonSmView;
    //    @property (strong, nonatomic)  UIImageView *addTwoImg;
    //    @property (strong, nonatomic)  UITextField *resonSmTextFile;
    //    @property (strong, nonatomic)  UIView *fgThreeView;
    //    @property (strong, nonatomic)  UIButton *resonSMbTH;
    //    @property (strong, nonatomic)  UIView *imgSrvView;
    self.resonSmView = [UIView new];
    [self.bigView addSubview:self.resonSmView];
    self.addTwoImg = [UIImageView new];
    [self.resonSmView  addSubview:self.addTwoImg];
    self.resonSmTextFile = [UITextField new];
    [self.resonSmView  addSubview:self.resonSmTextFile];
    self.fgThreeView = [UIView new];
    [self.resonSmView  addSubview:self.fgThreeView];
    self.fgThreeView.backgroundColor = kLineColor;
    self.resonSMbTH = [UIButton new];
    
    self.imgSrvView = [UIView new];
    //    [self.resonSmView  addSubview:self.imgSrvView];
    self.resonSmTextFile.font = [UIFont systemFontOfSize:14];
    self.resonTextFile.font = [UIFont systemFontOfSize:14];
    [self.resonSmView  addSubview:self.resonSMbTH];
    [self.contentView addSubview:self.orderButton];
    
    
}
- (void)layoutSubviews {
    CGFloat  onwidth = self.contentView.frame.size.width;
    //    self.headImg.image = [UIImage imageNamed:@"icon_moren(1).png"];;
    self.jiaImg.image =  [UIImage imageNamed:@"jiaGree.png"];
    self.addOneImg.image = [UIImage imageNamed:@"add.png"];;
    self.addTwoImg.image = [UIImage imageNamed:@"add.png"];;
    self.jianImg.image = [UIImage imageNamed:@"jianGree.png"];;
    
    [self.minuBth addTarget:self action:@selector(clickMins:) forControlEvents:UIControlEventTouchUpInside];
    [self.resonSMbTH addTarget:self action:@selector(other:) forControlEvents:UIControlEventTouchUpInside];
    [self.resonButton addTarget:self action:@selector(otherone:) forControlEvents:UIControlEventTouchUpInside];
    [self.jiaBth addTarget:self action:@selector(plusclicks) forControlEvents:UIControlEventTouchUpInside];
    self.lastView.frame = CGRectMake(0, CGRectGetMaxY(self.bigView.frame), onwidth, 10);
    //    [self.jiaBth addTarget:self action:@selector(plusclicks) forControlEvents:UIControlEventTouchUpInside];
    
    
    
    
    [super layoutSubviews];
}
- (void)showModel:(AddScrapModel *)model{
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt042"] ] integerValue];
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
    self.resonTextFile.placeholder = @"请选择报废原因";
    self.resonSmTextFile.placeholder = @"请选择报废原因说明";
    self.resonSmTextFile.text = model.k1dt503;
     self.resonTextFile.text = model.k1dt501;

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
    self.bigView.frame = CGRectMake(0, Imgwidth+marginWidth*3+shopWidth+1, onwidth, 80);
    self.resonView.frame = CGRectMake(0, 0, onwidth, 40);
    self.addOneImg.frame = CGRectMake(onwidth-marginWidth-10, 17, 10, 7);
    self.resonTextFile.frame = CGRectMake(marginWidth, 0, onwidth-marginWidth*2-10, 40);
    self.fgTwoView.frame = CGRectMake(0, 39, onwidth, 1);
    self.resonButton.frame =CGRectMake(0, 0, onwidth, 40);
    self.resonSmView.frame = CGRectMake(0, 40, onwidth, 40);
    self.addTwoImg.frame = CGRectMake(onwidth-marginWidth-10, 17, 10, 7);
    self.resonSmTextFile.frame = CGRectMake(marginWidth, 0, onwidth-marginWidth*2-10, 40);
    self.fgThreeView.frame = CGRectMake(0, 39, onwidth, 1);
    self.resonSMbTH.frame = CGRectMake(0, 0, onwidth, 40);;
    //    self.bigView.backgroundColor = kTabBarColor;
    //    self.imgSrvView.frame = CGRectMake(0, 80, onwidth, 60);
    self.numCount =model.orderCount;
    self.orderNumLab.text = [BGControl notRounding:model.orderCount afterPoint:lpdt036];
    if ([[NSString stringWithFormat:@"%@",model.orderCount] isEqualToString:@"0"]) {
        _jianImg.hidden = YES;
        self.minuBth.hidden = YES;
        self.orderNumLab.hidden = YES;
        self.orderButton.hidden = YES;
        self.bigView.hidden = YES;
        //        self.bigView.frame = CGRectMake(0, 120, onwidth, 0);
        self.bigView.frame = CGRectMake(0, Imgwidth+marginWidth*3+shopWidth+1, onwidth, 0);
    }else {
        _jianImg.hidden = NO;
        self.minuBth.hidden = NO;
        self.orderNumLab.hidden = NO;
        self.orderButton.hidden = NO;
        self.bigView.hidden = NO;
    }
    self.nameLab.text = model.k1dt002;
    if ([BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = @"";
    }else {
        self.guigeLab.text = [NSString stringWithFormat:@"%@ %@",@"规格:",model.k1dt003];
    }
    CGFloat orderWidth = [BGControl labelAutoCalculateRectWith:self.orderNumLab.text FontSize:15 MaxSize:CGSizeMake(kScreenSize.width -91, 30)].width;
    
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
    
    //    self.numCount =[NSDecimalNumber decimalNumberWithString: [BGControl notRounding:jiafa afterPoint:lpdt036]];
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

-(void)other:(UIButton *)bth{
    if (_resonDelegate && [_resonDelegate respondsToSelector:@selector(resonTan:withModel:)]) {
        [_resonDelegate resonTan:@"xia" withModel:oneModel];
    }
}
-(void)otherone:(UIButton *)bth{
    if (_resonOneDelegate && [_resonOneDelegate respondsToSelector:@selector(choiceResonTan:withModel:)]) {
        [_resonOneDelegate choiceResonTan:@"up" withModel:oneModel];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
