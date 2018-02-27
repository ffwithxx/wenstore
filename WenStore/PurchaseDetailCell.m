//
//  PurchaseDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/24.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "PurchaseDetailCell.h"
#import "BGControl.h"
@implementation PurchaseDetailCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showWithModel:(AddPurchaseModel *)model {
  
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3004lpdt042"] ] integerValue];
    self.nameLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    NSString *jishuStr = [NSString stringWithFormat:@"%@%@%@%@",@"计数(",model.k1dt005,@"):",[NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]]];
    NSString *jijiaStr = [NSString stringWithFormat:@"%@%@%@%@",@"计价(",model.k1dt011,@"):",[NSString stringWithFormat:@"%@",[BGControl notRounding:model.k1dt110 afterPoint:lpdt036]]];
    
    self.danweiLab.text =[NSString stringWithFormat:@"%@",jishuStr];
    self.jijiaLab.text =[NSString stringWithFormat:@"%@",jijiaStr];
     CGFloat jijiaWidth = [BGControl labelAutoCalculateRectWith:self.jijiaLab.text FontSize:14 MaxSize:CGSizeMake(kScreenSize.width -103, 30)].width;
    self.jijiaLab.frame = CGRectMake(105, 70, jijiaWidth, 20);
//    self.priceLab.frame = CGRectMake(105 + jijiaWidth , 50, kScreenSize.width-100-jijiaWidth-15, 20);
    
    if (![[NSString stringWithFormat:@"%@",model.k1dt201] isEqualToString:@"0"]) {
        self.priceLab.text = [NSString stringWithFormat:@"￥%@",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]];
    }else{
        self.priceLab.text = @"";
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
