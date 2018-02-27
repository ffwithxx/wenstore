//
//  orderTwoView.h
//  WenStore
//
//  Created by 冯丽 on 17/9/11.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
@protocol ProDelegate <NSObject>

@optional

-(void)getpro:(NSMutableArray *)payArr  withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount ;
@end
@protocol PeiDelegate <NSObject>

@optional

-(void)getpei:(NSMutableArray *)payArr  withIndex:(NSInteger)index withDec:(NSDecimalNumber *)dec withYunCount:(NSDecimalNumber *)yuanCount withNowCount:(NSDecimalNumber *)nowCount ;
@end

@interface orderTwoView : UIView
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *orderFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) NewModel *model;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSString *keyStr;
@property (strong, nonatomic) NSString *typeStr;
@property (assign, nonatomic) NSInteger index;
@property (assign, nonatomic) NSInteger orderCount;

@property (assign, nonatomic) NSString *tag;
@property (strong, nonatomic) id<PeiDelegate> PeiDelegate;
@property (strong, nonatomic) id<ProDelegate> prooneDelegate;
//@property (strong, nonatomic) id<orderCountDelegate> orderDelegate;
@end
