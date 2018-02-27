//
//  testTableViewCell.m
//  WenStore
//
//  Created by 冯丽 on 17/8/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "testTableViewCell.h"

@implementation testTableViewCell {
    UIButton *button;

    UIView *bigView;
    NSInteger *num;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)priceLabel
{
    if (!_labl) {
        _labl = [[UILabel alloc] init];
    }
    return _labl;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customCell];
    }
    return self;
}
- (void)customCell {
    for (UIView *view in [self.contentView subviews]) {
        if (view.tag ==1001) {
            [view removeFromSuperview];
        }
    }
    bigView = [UIView new];
    bigView.frame = CGRectMake(20, 10, kScreenSize.width-40, 80);
    bigView.tag=1001;
    [self.contentView addSubview:bigView];
   
    [bigView addSubview:self.labl];
    button = [UIButton new];
    [button addTarget:self action:@selector(buttonclick) forControlEvents:UIControlEventTouchUpInside];
    [bigView addSubview: button];
    
}

-(void)buttonclick {
    num = num++;
    __weak typeof (self) weakself = self;
    
    weakself.block(num, YES);
}
- (void)layoutSubviews {
    [super layoutSubviews];
    self.labl.backgroundColor = [UIColor redColor];
    self.labl.frame = CGRectMake(0, 0, bigView.frame.size.width, bigView.frame.size.height-50);
    button.frame = CGRectMake(0, 0, bigView.frame.size.width, bigView.frame.size.height);
    
    //    CGFloat detailHei = [self heightForString:detailLab.text fontSize:[UIFont systemFontOfSize:<#(CGFloat)#>] andWidth:<#(float)#>]
}

-(void)showModel{
    
  
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
