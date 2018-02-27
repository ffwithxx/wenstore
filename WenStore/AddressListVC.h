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
@end

