//
//  AsideCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AsideModel.h"
@interface AsideCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titlelAB;
@property (strong, nonatomic) IBOutlet UILabel *bochuLab;
@property (strong, nonatomic) IBOutlet UILabel *boruLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
-(void)showModel:(AsideModel *)model withBillstate:(NSString *)billstate;
@end
