//
//  CallOrderFourDetailTwoCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderFourDetailTwoCell.h"
#import "EditModel.h"
#import "BGControl.h"

@implementation CallOrderFourDetailTwoCell {
    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;
    NSInteger lpdt036;
    NSInteger lpdt042;
    
}
-(void)showModel:(EditModel *)model{
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt042"] ] integerValue];
    self.nameLab.text = model.k1dt002;
    NSString *faNum = [BGControl notRounding:model.k1dt101 afterPoint:lpdt036];
    NSString *jiheNum = [BGControl notRounding:model.k1dt104 afterPoint:lpdt036];
    self.tuihuiNumLab.text = [NSString stringWithFormat:@"%@%@",@"退回数量:",faNum];
    
    if ([BGControl isNULLOfString:[NSString stringWithFormat:@"%@",model.k1dt104]]) {
        jiheNum = [BGControl notRounding:[NSDecimalNumber decimalNumberWithString:@"0"] afterPoint:lpdt036];
    }
    self.jiheNumLab.text = [NSString stringWithFormat:@"%@%@",@"稽核数量:",jiheNum];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    oneHei = self.nameLab.frame.size.height;
    maginWidth = 15;
    imgWidth = 80;
    if (kScreenSize.width == 320) {
        oneHei = 20;
        maginWidth = 10;
        imgWidth = 60;
        oneHei = 15;
        maginWidth = 10;
        imgWidth = 60;
        self.headImg.frame = CGRectMake(10, 10, 60, 60);
        self.nameLab.frame = CGRectMake(80, 10, self.contentView.frame.size.width-90, 20);
        self.tuihuiNumLab.frame= CGRectMake(80, 30, self.contentView.frame.size.width-90, 20);
      
        self.jiheNumLab.frame = CGRectMake(80, 50, self.contentView.frame.size.width-90, 20);
          self.priceLab.frame = CGRectMake(maginWidth, CGRectGetMaxY(self.headImg.frame)+5, self.contentView.frame.size.width-maginWidth*2, 20);
    }
    CGFloat jiWidth = [BGControl labelAutoCalculateRectWith:self.jiheLab.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    CGRect jiFrame = self.jiheLab.frame;
    jiFrame.size.width = jiWidth;
    [self.jiheLab setFrame:jiFrame];
  
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
- (void)layoutSubviews {
//    CGRect bottomFrame = self.bottomView.frame;
//    bottomFrame.origin.y = maginWidth+imgWidth+15 +height;
//    [self.bottomView setFrame:bottomFrame];
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
