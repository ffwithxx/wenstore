//
//  NameViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol NameDelegate <NSObject>

@optional

- (void)NameStr:(NSString*)str;
@end

@interface NameViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic, weak) id<NameDelegate> delegate;
@end
