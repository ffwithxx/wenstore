//
//  PhoneTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PhoneTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *phoneLab;

- (void)showModel:(NSString *)str;

@end
