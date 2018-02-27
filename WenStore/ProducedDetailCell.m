//
//  ProducedDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/11/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProducedDetailCell.h"
#import "BGControl.h"
@implementation ProducedDetailCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
}

- (void)showModel:(ProducedModel *)model {
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3007lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3007lpdt042"] ] integerValue];
    self.nameLab.text = model.k1dt002;
     NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    self.priceLab.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]];
    
    
    self.countLab.text = [NSString stringWithFormat:@"%@%@",@"×",model.k1dt101];
    
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



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end