//
//  EmailViewController.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface EmailViewController : BaseViewController

@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (strong, nonatomic) IBOutlet UIButton *sendBth;
@property (strong, nonatomic) NSString *idStr;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *rightImg;
@property (strong, nonatomic) IBOutlet UILabel *rightLab;
@end
