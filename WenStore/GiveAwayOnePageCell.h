//
//  GiveAwayOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/1.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GiveAwayOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(GiveAwayOnePageModel *)model;

@end
@interface GiveAwayOnePageCell : UITableViewCell
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
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
-(void)showModel:(GiveAwayOnePageModel *)model;
@end
