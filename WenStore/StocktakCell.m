//
//  StocktakCell.m
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "StocktakCell.h"
#import "BGControl.h"

@implementation StocktakCell{
    
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
- (void)showModel:(StocktakModel *)model {
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3003lpdt042"] ] integerValue];
    self.titleLab.text = model.k1dt002;
    NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
     [self.headImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"/FileCenter/ProductPicture/ExportMedium",@"productId=",model.k1dt001,@"imge004=",model.imge004]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
    oneHei = self.titleLab.frame.size.height;
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
        self.oneLab.frame = CGRectMake(80, 10, self.contentView.frame.size.width-90, oneHei);
        self.twoLab.frame = CGRectMake(80, 30, self.contentView.frame.size.width-90, 20);
        self.threeLab.frame = CGRectMake(80, 50, self.contentView.frame.size.width-90, 20);
        self.detailVIew.frame = CGRectMake(0, 40, self.contentView.frame.size.width, 80);
        self.xiaView.frame = CGRectMake(0, 120, self.contentView.frame.size.width, 40);
    }
    NSInteger danweiCount = 0;
    if (![BGControl isNULLOfString:model.k1dt011]) {
        self.oneLab.text = [NSString stringWithFormat:@"%@:%@",model.k1dt011,[BGControl notRounding:model.k1dt011n afterPoint:lpdt036]];
        danweiCount = danweiCount + 1;
        
    }else {
        self.oneLab.text = @"";
    }
    if (![BGControl isNULLOfString:model.k1dt012]) {
        self.twoLab.text = [NSString stringWithFormat:@"%@:%@",model.k1dt012,[BGControl notRounding:model.k1dt012n afterPoint:lpdt036]];
        danweiCount = danweiCount + 1;
    }else {
        self.twoLab.text = @"";
    }
    if (![BGControl isNULLOfString:model.k1dt013]) {
        self.threeLab.text = [NSString stringWithFormat:@"%@:%@",model.k1dt013,[BGControl notRounding:model.k1dt013n afterPoint:lpdt036]];
        danweiCount = danweiCount + 1;
    }else {
    self.threeLab.text = @"";
    }
    if (danweiCount == 0) {
        self.oneLab.text = [NSString stringWithFormat:@"%@:%@",model.k1dt005,[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]];
    }
    if (![BGControl isNULLOfString:model.k1dt003]) {
        self.guigeLab.text = [NSString stringWithFormat:@"%@:%@",@"规格",model.k1dt003];
    }
    CGFloat guiWidth = [BGControl labelAutoCalculateRectWith:self.guigeLab.text FontSize:15 MaxSize:CGSizeMake(MAXFLOAT, 40)].width;
    CGRect guiFrame = self.guigeLab.frame;
    guiFrame.size.width = guiWidth;
    [self.guigeLab setFrame:guiFrame];
    
    CGRect countFrame = self.countLab.frame;
    countFrame.origin.x = maginWidth+guiWidth;
    
    countFrame.size.width = self.contentView.frame.size.width - maginWidth*2 - guiWidth;
    [self.countLab setFrame:countFrame];
    self.countLab.text = [NSString stringWithFormat:@"%@%@",@"数量:",[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]];


}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
