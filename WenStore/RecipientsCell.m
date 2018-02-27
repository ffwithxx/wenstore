//
//  RecipientsCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/2.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "RecipientsCell.h"
#import "BGControl.h"
@implementation RecipientsCell {
    
    CGFloat height;
    CGFloat oneHei;
    CGFloat maginWidth;
    CGFloat imgWidth;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(RecipientsModel *)model {
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    
    NSInteger lpdt036 =[[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3013lpdt036"] ] integerValue];
    NSInteger lpdt042 =  [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3013lpdt042"] ] integerValue];
    self.titlelAB.text = model.k1dt002;
    
    NSString *Num = [BGControl notRounding:model.k1dt101 afterPoint:lpdt036];
    
    
    self.guigeLab.text = [NSString stringWithFormat:@"%@%@",@"规格:",model.k1dt003];
    self.countLab.text = [NSString stringWithFormat:@"%@%@",@"领用数量:",Num];
    NSString *priceStr = [BGControl notRounding:model.k1dt201 afterPoint:lpdt042];
    self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",priceStr];
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
        self.guigeLab.frame= CGRectMake(80, 25, self.contentView.frame.size.width-90, 15);
        self.countLab.frame= CGRectMake(80, 50, self.contentView.frame.size.width-90, 15);
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end