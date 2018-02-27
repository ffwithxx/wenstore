//
//  CallOrderOneCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/18.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
#import "BuyModel.h"
@protocol bottomHeiDelegate <NSObject>

@optional

-(void)getBottomHei:(CGFloat)maxHei  withIndex:(NSInteger)index ;
@end


@protocol orderCountDelegate <NSObject>

@optional



-(void) getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price withStr:(NSString *)str  ;;

@end
@protocol TanDelegate <NSObject>

@optional

-(void) getwithKey:(NSString *)key withIndex:(NSInteger)index withModel:(NewModel *)model withweizhi:(NSString *)weizhi ;
@end

@protocol TanLitterDelegate <NSObject>

@optional

-(void)getWithModel:(NewModel *)model withTag:(NSString *)tag withIndex:(NSInteger)index withType:(NSString *)type ;
@end


@protocol PeiDelegate <NSObject>

@optional

-(void)getpei:(NSMutableArray *)payArr  withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount ;
@end

@protocol ProDelegate <NSObject>

@optional

-(void)getpro:(NSMutableArray *)payArr  withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount ;
@end

@interface CallOrderOneCell : UITableViewCell

@property (nonatomic, strong) NSDecimalNumber *numCount;
@property(nonatomic,weak) id<bottomHeiDelegate> Bottomdelegate;
@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@property (strong, nonatomic) id<PeiDelegate> peiDelegate;
@property (strong, nonatomic) id<ProDelegate> proDelegate;
- (void)showModel:(NewModel*)model withDict:(NSMutableDictionary *)dict widtRight:(NSMutableDictionary *)rightDict withselfIndex:(NSInteger) selfIndext withIndex:(NSInteger) currentIndex;
@property (strong, nonatomic) id<TanDelegate> tanDelegate;
@property (strong, nonatomic) id<TanLitterDelegate> tanLitterDelegate;

@end
