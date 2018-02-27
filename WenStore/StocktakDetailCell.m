//
//  StocktakDetailCell.m
//  WenStore
//
//  Created by 冯丽 on 2017/10/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StocktakDetailCell.h"
#import "BGControl.h"

@implementation StocktakDetailCell {
    NSInteger lpdt036;
    NSInteger lpdt042;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (void)showModel:(StocktakModel *)model {
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt042"] ] integerValue];
     self.titleLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    [self.headImgView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guiGeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    NSString *maxStr = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@" ,model.k1dt011n],model.k1dt011];
       NSString *middleStr = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@" ,model.k1dt012n],model.k1dt012];
    NSString *minStr = [NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@" ,model.k1dt013n],model.k1dt013];
     self.countNum.text =[NSString stringWithFormat:@"%@|%@|%@",maxStr,middleStr,minStr];
    if ([[NSString stringWithFormat:@"%@",model.k1dt011n] isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",model.k1dt012n] isEqualToString:@"0"] && [[NSString stringWithFormat:@"%@",model.k1dt013n] isEqualToString:@"0"]) {
         self.countNum.text =[NSString stringWithFormat:@"%@%@",[NSString stringWithFormat:@"%@" ,model.k1dt101],model.k1dt005];
    }
    
 
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
