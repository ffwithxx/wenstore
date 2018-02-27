//
//  PurchaseOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(PurchaseOnePageModel *)model;

@end

@interface PurchaseOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *jinhuoDate;
@property (strong, nonatomic) IBOutlet UILabel *billSateLab;
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIView *fgView;
@property (strong, nonatomic) IBOutlet UILabel *remarkNameLab;
@property (strong, nonatomic) IBOutlet UIView *remarkView;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIImageView *lineImg;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIView *lastView;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
-(void)showModel:(PurchaseOnePageModel *)model;
@end
