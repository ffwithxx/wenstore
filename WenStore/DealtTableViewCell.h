//
//  DealtTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "groupModel.h"
@protocol dealtDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr  withModel:(groupModel *)model;

@end
@protocol maxHeiDelegate <NSObject>

@optional

-(void)getMaxHei:(CGFloat)maxHei  withIndex:(NSInteger)index;
@end

@interface DealtTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
@property (strong, nonatomic) IBOutlet UILabel *moreLab;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property(nonatomic,weak) id<maxHeiDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIButton *detailBth;
@property (strong, nonatomic) IBOutlet UIButton *MoreBth;
@property (nonatomic,weak)id <dealtDelegete> dealtDelegate;
- (void)showWith:(groupModel *)model withIndex:(NSInteger)index;
@end
