//
//  ProducedOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProducedOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(ProducedOnePageModel *)model;

@end
@interface ProducedOnePageCell : UITableViewCell
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
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIImageView *lineImg;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
-(void)showModel:(ProducedOnePageModel *)model;

@end
