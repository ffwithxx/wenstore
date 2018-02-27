//
//  PSOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PSOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(PSOnePageModel *)model;

@end

@interface PSOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *idStrLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIView *fgView;
@property (strong, nonatomic) IBOutlet UIImageView *lineImg;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
-(void)showModel:(PSOnePageModel *)model;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;

@end
