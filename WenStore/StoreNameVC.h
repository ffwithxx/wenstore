//
//  StoreNameVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol StoreNameDelegate <NSObject>

@optional

- (void)StoreNameDict:(NSDictionary*)dict;
@end

@interface StoreNameVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSArray *detpsArr;
@property (nonatomic, weak) id<StoreNameDelegate> delegate;
@end
