//
//  AddressListVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@class AddressListVC;
@protocol AddressDelegate <NSObject>

@optional

- (void)AddressStr:(NSString*)str;
@end
@interface AddressListVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (nonatomic, weak) id<AddressDelegate> delegate;
@property (nonatomic,strong) NSMutableArray *arr;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;

@end

