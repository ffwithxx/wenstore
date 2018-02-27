//
//  ScrapCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ScrapCell.h"
#import "BGControl.h"

@implementation ScrapCell {

    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;
    NSInteger lpdt036;
    NSInteger lpdt042;

}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(ScrapModel *)model {
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3002lpdt042"] ] integerValue];
    self.titlelAB.text = model.k1dt002;
      NSString *baofei = [BGControl notRounding:model.k1dt101 afterPoint:lpdt036];
    self.baofeiLab.text = [NSString stringWithFormat:@"%@%@",@"报废数量:",baofei];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
    oneHei = self.titlelAB.frame.size.height;
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
        self.titlelAB.frame = CGRectMake(80, 10, self.contentView.frame.size.width-90, 20);
//        self.tuihuiNumLab.frame= CGRectMake(80, 30, self.contentView.frame.size.width-90, 20);
        
        self.baofeiLab.frame = CGRectMake(80, 50, self.contentView.frame.size.width-90, 20);
        self.priceLab.frame = CGRectMake(CGRectGetMaxX(self.baofeiLab.frame), 50, 50, 15);
    }
    CGFloat jiWidth = [BGControl labelAutoCalculateRectWith:self.baofeiLab.text FontSize:14 MaxSize:CGSizeMake(MAXFLOAT, oneHei)].width;
    CGRect jiFrame = self.baofeiLab.frame;
    jiFrame.size.width = jiWidth;
    [self.baofeiLab setFrame:jiFrame];
    CGRect priceFrame = self.priceLab.frame;
    priceFrame.size.width = CGRectGetWidth(self.contentView.frame)-maginWidth*2-imgWidth-jiWidth-maginWidth;
    priceFrame.origin.x = CGRectGetMaxX(self.baofeiLab.frame);
    [self.priceLab setFrame:priceFrame];
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    self.resonOneLab.text = model.k1dt502;
     self.resonTwoLab.text = model.k1dt503;
    
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
