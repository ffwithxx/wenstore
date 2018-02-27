//
//  CallOrderThreeDetailTwoCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeDetailTwoCell.h"
#import "BGControl.h"

@implementation CallOrderThreeDetailTwoCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(EditModel *)model{
    CGFloat oneHei = self.titlelAB.frame.size.height;
    CGFloat maginWidth = 15;
     CGFloat imgWidth = 80;
    if (kScreenSize.width == 320) {
        oneHei = 15;
        maginWidth = 10;
        imgWidth = 60;
        self.headImg.frame = CGRectMake(10, 10, 60, 60);
        self.titlelAB.frame = CGRectMake(80, 10, self.contentView.frame.size.width-90, 15);
        self.fahuoLab.frame= CGRectMake(80, 25, self.contentView.frame.size.width-90, 15);
        self.shouhuoLab.frame= CGRectMake(80, 40, self.contentView.frame.size.width-90, 15);
         self.cahyiLab.frame= CGRectMake(80, 55, self.contentView.frame.size.width-90, 15);
        self.priceLab.frame = CGRectMake(maginWidth, CGRectGetMaxY(self.headImg.frame)+5, self.contentView.frame.size.width-maginWidth*2, 20);
    }
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
   
   
   NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
   NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt042"] ] integerValue];
    self.titlelAB.text = model.k1dt002;
    NSString *faNum = [BGControl notRounding:model.k1dt102 afterPoint:lpdt036];
    NSString *shouNum = [BGControl notRounding:model.k1dt103 afterPoint:lpdt036];
    self.fahuoLab.text = [NSString stringWithFormat:@"%@%@",@"配送量:",faNum];
    self.shouhuoLab.text = [NSString stringWithFormat:@"%@%@",@"收货量:",[BGControl notRounding:model.k1dt104 afterPoint:lpdt036]];
    self.cahyiLab.text =[NSString stringWithFormat:@"%@%@",@"差异量:",shouNum];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    CGFloat shuohuoWidth = [BGControl labelAutoCalculateRectWith:self.shouhuoLab.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    CGRect shouFrame = self.shouhuoLab.frame;
    shouFrame.size.width = shuohuoWidth;
    [self.shouhuoLab setFrame:shouFrame];


       NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:faNum]compare:[NSDecimalNumber decimalNumberWithString:shouNum]];
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
