//
//  OrderDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@protocol HeiDelegate <NSObject>

@optional

-(void)getHei:(CGFloat)maxHei  withIndex:(NSInteger)index ;
@end

@interface OrderDetailCell : UITableViewCell
-(void)showModelWith:(NewModel *)model withDict:(NSMutableDictionary *)dict withSelfDict:(NSMutableDictionary *)selfDict withIndex:(NSInteger)index;

@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic)  UIView *fgView;

@property (strong, nonatomic) IBOutlet UIImageView *iconImgView;
@property(nonatomic,weak) id<HeiDelegate> delegate;

@end
