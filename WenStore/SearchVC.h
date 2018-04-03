//
//  SearchVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@protocol fanDataDelegate <NSObject>

@optional
-(void)fanDict:(NSMutableDictionary *)dict;

@end

@protocol callOrderFanDataDelegate <NSObject>

@optional
-(void)fanDict:(NSMutableDictionary *)dict withTitleStr:(NSString *)titleStr;

@end


@interface SearchVC : BaseViewController

@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *searchTextField;

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *deletView;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (weak, nonatomic)  id<fanDataDelegate > delegate;
@property (weak, nonatomic)  id<callOrderFanDataDelegate > fanDelegate;
@property (nonatomic, assign) NSInteger maxCount;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *rightLab;
@property (strong, nonatomic) IBOutlet UIView *bgView;
@property (strong, nonatomic) IBOutlet UIView *navView;

- (IBAction)TextField_DidEndOnExit:(id)sender;
@end
