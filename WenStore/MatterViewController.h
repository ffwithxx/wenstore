//
//  MatterViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "groupModel.h"

@interface MatterViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) groupModel *dataDict;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@end
