//
//  CallOrderThreeDetailThreeCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeDetailThreeCell.h"
#import "BGControl.h"

@implementation CallOrderThreeDetailThreeCell {
    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(EditModel *)model{
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
   
   NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
   NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt042"] ] integerValue];
    self.titlelAB.text = model.k1dt002;
    NSString *faNum = [BGControl notRounding:model.k1dt102 afterPoint:lpdt036];
    NSString *shouNum = [BGControl notRounding:model.k1dt103 afterPoint:lpdt036];
    NSString *jiheNum = [BGControl notRounding:model.k1dt105 afterPoint:lpdt036];
    self.fahuoLab.text = [NSString stringWithFormat:@"%@%@",@"配送量:",faNum];
    self.shouhuoLab.text = [NSString stringWithFormat:@"%@%@",@"收货量:",shouNum];
     self.jiheLab.text = [NSString stringWithFormat:@"%@%@",@"稽核量:",jiheNum];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:faNum]compare:[NSDecimalNumber decimalNumberWithString:shouNum]];
    NSComparisonResult resultTwo = [[NSDecimalNumber decimalNumberWithString:faNum]compare:[NSDecimalNumber decimalNumberWithString:jiheNum]];
    if (result == NSOrderedAscending) {
        
        NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.shouhuoLab.text];
        NSInteger pricelenght = shouStr.length;
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
        [shouStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(5,pricelenght-5)];
        self.shouhuoLab.attributedText = shouStr;
        
    }else if (result == NSOrderedAscending) {
        NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.shouhuoLab.text];
        NSInteger pricelenght = shouStr.length;
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTabBarColor range:NSMakeRange(5,pricelenght-5)];
        self.shouhuoLab.attributedText = shouStr;
        
    }else{
        //     self.shouhuoLab.textColor = kTextGrayColor;
    }
    
    if (resultTwo == NSOrderedAscending) {
        
        NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.jiheLab.text];
        NSInteger pricelenght = shouStr.length;
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
        [shouStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(5,pricelenght-5)];
        self.jiheLab.attributedText = shouStr;
        
    }else if (resultTwo == NSOrderedAscending) {
        NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.jiheLab.text];
        NSInteger pricelenght = shouStr.length;
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
        [shouStr addAttribute:NSForegroundColorAttributeName value:kTabBarColor range:NSMakeRange(5,pricelenght-5)];
        self.jiheLab.attributedText = shouStr;
        
    }else{
        //     self.shouhuoLab.textColor = kTextGrayColor;
    }
    self.resonTwoLab.text = model.k1dt504;
   
//    self.resonTwoLab.text = @"他黑人若若若若还腿疼拖拖拖拖拖拖拖拖拖拖哈哈哈哈哈哈哈哈或或方法东方大道卡夫卡颇为咖啡口味偶尔陪我扶贫款";
     height = [BGControl getSpaceLabelHeight:self.resonTwoLab.text withFont:[UIFont systemFontOfSize:14] withWidth:self.contentView.frame.size.width-52-15];
    self.resonTwoLab.frame = CGRectMake(52, 0, self.contentView.frame.size.width-52-15, height);
    CGRect resonFrame = self.resonView.frame;
    resonFrame.size.height = height;
    [self.resonView setFrame:resonFrame];
    if (height>0) {
         self.resonOneLab.text = @"原因:";
    }
    self.priceLab.textAlignment = NSTextAlignmentLeft;
   oneHei = self.titlelAB.frame.size.height;
   maginWidth = 15;
   imgWidth = 80;
    if (kScreenSize.width == 320) {
        oneHei = 15;
        maginWidth = 10;
        imgWidth = 60;
        oneHei = 15;
        maginWidth = 10;
        imgWidth = 60;
        self.headImg.frame = CGRectMake(10, 10, 60, 60);
        self.titlelAB.frame = CGRectMake(80, 10, self.contentView.frame.size.width-90, 15);
        self.fahuoLab.frame= CGRectMake(80, 25, self.contentView.frame.size.width-90, 15);
        self.shouhuoLab.frame= CGRectMake(80, 40, self.contentView.frame.size.width-90, 15);
        self.jiheLab.frame = CGRectMake(80, 55, self.contentView.frame.size.width-90, 15);
         self.priceLab.frame = CGRectMake(maginWidth, CGRectGetMaxY(self.headImg.frame)+5, self.contentView.frame.size.width-maginWidth*2, 20);
    }
    CGFloat jiWidth = [BGControl labelAutoCalculateRectWith:self.jiheLab.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    CGRect jiFrame = self.jiheLab.frame;
    jiFrame.size.width = jiWidth;
    [self.jiheLab setFrame:jiFrame];

    CGRect resonFrameone = self.resonView.frame;
    resonFrameone.origin.y = maginWidth+imgWidth+15+oneHei;
    [self.resonView setFrame:resonFrameone];
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
- (void)layoutSubviews {
    CGRect bottomFrame = self.bottomView.frame;
    CGFloat oneHei = 20;
    if (kScreenSize.width == 320) {
         CGFloat oneHei = 15;
        
    }
    bottomFrame.origin.y = maginWidth+imgWidth+15 +height + oneHei;
    [self.bottomView setFrame:bottomFrame];
    [super layoutSubviews];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
