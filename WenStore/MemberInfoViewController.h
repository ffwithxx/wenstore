//
//  MemberInfoViewController.h
//  WenStore
//
//  Created by 冯丽 on 17/8/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
#import "MMDrawerController.h"

@interface MemberInfoViewController : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *mobileLab;
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) IBOutlet UILabel *tyleLabel;
@property (nonatomic,strong) MMDrawerController *drawerController;
@end
