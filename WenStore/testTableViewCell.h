//
//  testTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^btnPulsBlock)(NSInteger count, BOOL animated);
@interface testTableViewCell : UITableViewCell
-(void)showModel;
@property (nonatomic, strong) __block  btnPulsBlock block;
@property(nonatomic,strong) UILabel *labl;
@end
