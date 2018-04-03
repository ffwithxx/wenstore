//
//  PhoneVC.h
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol PhoneDelegate <NSObject>

@optional

- (void)PhoneStr:(NSString*)str;
@end


@interface PhoneVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *bigTableView;
@property (nonatomic,strong) NSMutableArray *arr;
@property (nonatomic, weak) id<PhoneDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@end
