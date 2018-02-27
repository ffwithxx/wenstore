//
//  IP.h
//  WenStore
//
//  Created by 冯丽 on 17/8/10.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IP : UIView

@property (strong, nonatomic) IBOutlet UIButton *sybmitBth;
@property (strong, nonatomic) IBOutlet UITextField *ipText;
@property (strong, nonatomic) IBOutlet UILabel *ipLabel;
@property (nonatomic,copy) void(^getIpBlock)(NSArray *ipArr);
@end
