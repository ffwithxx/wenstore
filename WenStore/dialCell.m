//
//  dialCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "dialCell.h"
#import "BGControl.h"
@implementation dialCell{
    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;
    
}

-(void)showModel:(DialModel *)model withBillstate:(NSString *)billstate
{
     NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    
    NSInteger lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3010lpdt036"] ] integerValue];
    NSInteger lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3010lpdt042"] ] integerValue];
    self.titlelAB.text = model.k1dt002;
    NSString *faNum = [BGControl notRounding:model.k1dt101 afterPoint:lpdt036];
    NSString *shouNum = [BGControl notRounding:model.k1dt102 afterPoint:lpdt036];
    
   
        self.bochuLab.text = [NSString stringWithFormat:@"%@%@",@"拨出数量:",faNum];
        self.boruLab.text = [NSString stringWithFormat:@"%@%@",@"拨入数量:",shouNum];
        NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
        self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
        NSComparisonResult result = [[NSDecimalNumber decimalNumberWithString:faNum]compare:[NSDecimalNumber decimalNumberWithString:shouNum]];
        NSComparisonResult resultTwo = [[NSDecimalNumber decimalNumberWithString:faNum]compare:[NSDecimalNumber decimalNumberWithString:shouNum]];
        if (result == NSOrderedDescending) {
            
            NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.boruLab.text];
            NSInteger pricelenght = shouStr.length;
            [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
            [shouStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(5,pricelenght-5)];
            self.boruLab.attributedText = shouStr;
            
        }else if (result == NSOrderedAscending) {
            NSMutableAttributedString *shouStr = [[NSMutableAttributedString alloc] initWithString:self.boruLab.text];
            NSInteger pricelenght = shouStr.length;
            [shouStr addAttribute:NSForegroundColorAttributeName value:kTextGrayColor range:NSMakeRange(0, 5)];
            [shouStr addAttribute:NSForegroundColorAttributeName value:kTabBarColor range:NSMakeRange(5,pricelenght-5)];
            self.boruLab.attributedText = shouStr;
            
        }else{
            //     self.shouhuoLab.textColor = kTextGrayColor;
        }
        
        
   
    
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
        self.bochuLab.frame= CGRectMake(80, 35, self.contentView.frame.size.width-90, 15);
        self.boruLab.frame= CGRectMake(80, 50, self.contentView.frame.size.width-90, 15);
        self.priceLab.frame= CGRectMake(15, CGRectGetMaxY(self.headImg.frame)+5, self.contentView.frame.size.width-maginWidth*2, 15);
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
- (void)layoutSubviews {
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.origin.y = maginWidth+imgWidth+15+20;
    [self.bottomView setFrame:bottomFrame];
    [super layoutSubviews];
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
