//
//  AFClient.h
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kHttpHeader @"https://webpos.winton.com.cn"
#define KHeader @"2DD8F2D2-4C62-4593-B745-AE4254BCBE4C"
@interface AFClient : NSObject

typedef void(^ProgressBlock)(NSProgress *progress);
typedef void(^SuccessBlock)(id responseBody);
typedef void(^FailureBlcok)(NSError *error);

@property (nonatomic,strong)ProgressBlock progressBolck;
@property (nonatomic,strong)SuccessBlock successBlock;
@property (nonatomic,strong)FailureBlcok failureBlock;


+(instancetype)shareInstance;

- (void)GetResource:(NSString *)apptoken withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)postFile:(NSString *)file withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)GetNew:(NSString *)jsob001 withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)GetEdit:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)GetNewWithArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)Destroy:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;


-(void)postValidateCart:(NSMutableDictionary *)mastDict detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr withjsob001:(NSString *)jsob001 progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
-(void)postValidateCart:(NSMutableDictionary *)mastDict withIdStr:(NSString *)k1mf001Str detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
-(void)postValidateCartone:(NSMutableDictionary *)mastDict detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)Create:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)Update:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)OnePage:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)LoginByCustId:(NSString *)custId withUrl:(NSString *)urlStr withAccount:(NSString *)account withPassword:(NSString *)password withStoreId:(NSString *)storeId isShow:(BOOL)isShow withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)loginOutwith:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)All:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

-(void)SalesForecastWith:(NSDictionary *)dict  withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;


/* 3008*/
- (void)WBP3008OnePage:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)WBP3008Approve:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)WBP3008Preview:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)Divert:(NSString *)k1mf100  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)UpdateState:(NSMutableDictionary *)k1mf100  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)NewSendReport:(NSString *)k1mf100  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)SendReport:(NSString *)k1mf100 withDic:(NSMutableDictionary *)dic  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)CheckHostStatuswithUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)UpdatePasswordwithUrl:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)GetNewswithUrl:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
- (void)Masgetpay:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;

- (void)OrderableRemind:(NSString *)k1dt001Str withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
//付款
- (void)GetPaymentResrouce:(NSString *)k1mf100 progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure;
@end
