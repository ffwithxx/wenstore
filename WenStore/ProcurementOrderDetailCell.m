//
//  ProcurementOrderDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "ProcurementOrderDetailCell.h"
#import "BGControl.h"
@implementation ProcurementOrderDetailCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)showModel:(AddProcurementModel *)model{
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3022lpdt042"] ] integerValue];
    self.nameLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    if (![[NSString stringWithFormat:@"%@",model.k1dt201] isEqualToString:@"0"]) {
         self.priceLab.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]];
    }else{
        self.priceLab.text = @"";
    }
  
    
    NSString *jishuStr = [NSString stringWithFormat:@"计数(%@):%@",model.k1dt005,[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]];
    NSString *jijiaStr = [NSString stringWithFormat:@"计价(%@):%@",model.k1dt011UnitText,[BGControl notRounding:model.k1dt110 afterPoint:lpdt036]];
    
    self.danweiLab.text = [NSString stringWithFormat:@"%@",jishuStr];
    self.jijiaLab.text = [NSString stringWithFormat:@"%@",jijiaStr];

}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
