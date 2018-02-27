//
//  ProcurementOrderOnePagCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProcurementOrderOnePagModel.h"
@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withCount:(NSDecimalNumber *)count withModel:(ProcurementOrderOnePagModel *)model;

@end


@interface ProcurementOrderOnePagCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *caigouDate;
@property (strong, nonatomic) IBOutlet UILabel *otherLab;
@property (strong, nonatomic) IBOutlet UILabel *yujiaoDate;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLab;

@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNum;
@property (strong, nonatomic) IBOutlet UILabel *sumLab;
@property (strong, nonatomic) IBOutlet UILabel *remarkLab;

@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIView *fgview;
@property (strong, nonatomic) IBOutlet UIView *orderNumView;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIView *lastView;
//@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;

@property (nonatomic,weak)id <orderDelegete> orderDelegate;

- (void)showModel:(ProcurementOrderOnePagModel *)model withDict:(NSMutableDictionary *)dict;
@end
