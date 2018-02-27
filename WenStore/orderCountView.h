//
//  orderCountView.h
//  WenStore
//
//  Created by 冯丽 on 17/9/11.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NewModel.h"
#import "EditModel.h"
@protocol orderCountDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withKey:(NSString *)key withIndex:(NSInteger)index withPrice:(NSDecimalNumber *)price withStr:(NSString *)str ;

@end
@interface orderCountView : UIView
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *orderFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) NewModel *model;
@property (strong, nonatomic) EditModel *editmodel;
@property (strong, nonatomic) NSMutableDictionary *dict;
@property (strong, nonatomic) NSString *keyStr;
@property (strong, nonatomic) NSString *typeStr;
@property (assign, nonatomic) NSInteger index;
//@property (assign, nonatomic) NSDecimalNumber *orderCount;
@property (strong, nonatomic) id<orderCountDelegate> OrderDelegate;
@end
