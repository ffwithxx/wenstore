//
//  FourDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 2018/1/23.
//  Copyright © 2018年 chenghong. All rights reserved.
//

#import "FourDetailCell.h"
#import "BGControl.h"
@implementation FourDetailCell{
    NSInteger lpdt036;
    NSInteger lpdt042;
}
- (void)showModel:(EditModel *)model with:(int)billState withTagStr:(NSString *)tagStr {
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt042"] ] integerValue];
    self.titleLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    if (![[NSString stringWithFormat:@"%@",model.k1dt201] isEqualToString:@"0"]) {
        self.priceLAB.text =[NSString stringWithFormat:@"%@%@",@"￥",[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]];
    }else{
        self.priceLAB.text = @"";
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
        self.priceLAB.hidden = YES;
    }else{
        self.priceLAB.hidden = NO;
    }
    if ([BGControl isNULLOfString:model.k1dt504]) {
        self.jiheResonLab.text = @"";
    }else{
        self.jiheResonLab.text = [NSString stringWithFormat:@"%@%@",@"核定原因:",model.k1dt504];
    }
    
    self.peisongLab.text = [NSString stringWithFormat:@"%@:%@",@"退回量",[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]];
    self.shouhuoLab.text = [NSString stringWithFormat:@"%@:%@",@"核定量",[BGControl notRounding:model.k1dt104 afterPoint:lpdt036]];
    self.jiheLab.text = [NSString stringWithFormat:@"%@:%@",@"稽核量",[BGControl notRounding:model.k1dt105 afterPoint:lpdt036]];
//    if (billState == 30 && [tagStr isEqualToString:@"304"]) {
//        self.jiheResonLab.hidden = YES;
//        self.jiheLab.hidden = YES;
//        self.lineView.frame = CGRectMake(0, 79, kScreenSize.width, 1);
//    }
//    if (billState == 40 &&[tagStr isEqualToString:@"304"]) {
//        self.jiheResonLab.hidden = NO;
//        self.jiheLab.hidden = NO;
//    }
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
