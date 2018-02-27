//
//  orderCountThree.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/25.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddProcurementModel.h"
#import "AddPurchaseModel.h"
#import "AddScrapModel.h"
#import "StocktakModel.h"
#import "AddPSModel.h"
#import "AsideModel.h"
#import "DialModel.h"
#import "ProducedModel.h"
#import "TryEatModel.h"
#import "GiveAwayModel.h"
#import "RecipientsModel.h"
#import "EditModel.h"
@protocol procurementdelegate <NSObject>

@optional

-(void)procurementWithModel:(AddProcurementModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end

@protocol purchasedelegate <NSObject>

@optional

-(void)procurementWithModel:(AddPurchaseModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end

@protocol scrapDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withModel:(AddScrapModel *)model;;

@end

@protocol stockOneDelegate <NSObject>

@optional

- (void)stockWithModel:(StocktakModel *)model withTag:(NSInteger)tag with:(NSDecimalNumber *)count;

@end

@protocol psOnedelegate <NSObject>

@optional

-(void)pstWithModel:(AddPSModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end
@protocol asideDelegate <NSObject>

@optional

-(void) getOrderCount:(NSDecimalNumber *)count withModel:(AsideModel *)model;;

@end

@protocol dialDelegate <NSObject>

@optional

-(void) getdialOrderCount:(NSDecimalNumber *)count withModel:(DialModel *)model;;

@end


@protocol producedDelegate <NSObject>

@optional

-(void) getproducedOrderCount:(NSDecimalNumber *)count withModel:(ProducedModel *)model;;

@end
@protocol tryEatDelegate <NSObject>

@optional

-(void) getTryEatOrderCount:(NSDecimalNumber *)count withModel:(TryEatModel *)model;

@end
@protocol giveAwayCountDelegate <NSObject>

@optional

-(void) getGiveAwayOrderCount:(NSDecimalNumber *)count withModel:(GiveAwayModel *)model;

@end

@protocol RecipientsCountDelegate <NSObject>

@optional

-(void) getRecipientsOrderCount:(NSDecimalNumber *)count withModel:(RecipientsModel *)model;

@end
@protocol oneBackdelegate <NSObject>

@optional

-(void)backWithModel:(EditModel *)model withTag:(NSInteger)tag withCount:(NSDecimalNumber *)count;

@end

@protocol Threedelegate <NSObject>

@optional

-(void)getOrderCount:(NSDecimalNumber *)count withKey:(NSString*)key withIndex:(NSInteger )index withPrice:(NSDecimalNumber *)price;

@end

@interface orderCountThree : UIView
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *orderFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) NSString *typeStr;
@property (strong, nonatomic) NSString *tagStr;
@property (strong, nonatomic) AddProcurementModel *procurementModel;
@property (strong, nonatomic) AddPurchaseModel *PurchaseModel;
@property (strong, nonatomic) AddScrapModel *AddScrapModel;
@property (strong, nonatomic) StocktakModel *StocktaModel;
@property (strong, nonatomic) AddPSModel *addPSModel;
@property (strong, nonatomic) AsideModel *asideModel;
@property (strong, nonatomic) DialModel *dialModel;
@property (strong, nonatomic) TryEatModel *tryEatModel;
@property (strong, nonatomic) ProducedModel *producedModel;
@property (strong, nonatomic) GiveAwayModel *giveAwayModel;
@property (strong, nonatomic) EditModel *editModel;
@property (strong, nonatomic) RecipientsModel *recipientsModel;
@property (weak,nonatomic) id<procurementdelegate > procurementDelegate;
@property (weak,nonatomic) id<purchasedelegate > purchaseDelegate;
@property (weak,nonatomic) id<scrapDelegate > scrapDelegate;
@property (weak,nonatomic) id<stockOneDelegate > stockDelegate;
@property (weak,nonatomic) id<psOnedelegate > psOnedelegate;
@property (weak,nonatomic) id<asideDelegate > asideDelegate;
@property (weak,nonatomic) id<dialDelegate > dialDelegate;
@property (weak,nonatomic) id<producedDelegate > producedDelegate;
@property (weak,nonatomic) id<tryEatDelegate > tryEatDelegate;
@property (weak,nonatomic) id<giveAwayCountDelegate > giveAwayCountDelegate;
@property (weak,nonatomic) id<RecipientsCountDelegate > recipientsCountDelegate;
@property (weak,nonatomic) id<oneBackdelegate > oneBackDelegate;
@property (weak,nonatomic) id<Threedelegate > threeDelegate;
@end
