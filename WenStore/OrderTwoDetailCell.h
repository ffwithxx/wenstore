//
//  OrderTwoDetailCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@protocol TwoHeiDelegate <NSObject>

@optional

-(void)getHei:(CGFloat)maxHei  withIndex:(NSInteger)index ;
@end
@interface OrderTwoDetailCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *headImg;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *guigeLab;
@property (strong, nonatomic) IBOutlet UILabel *priceLab;
@property (strong, nonatomic) IBOutlet UILabel *countLab;
@property (strong, nonatomic) IBOutlet UIView *fgView;
@property(nonatomic,weak) id<TwoHeiDelegate> delegate;
-(void)showModel:(NewModel *)model withDict:(NSMutableDictionary *)dict withIndex:(NSInteger)index;
@end
