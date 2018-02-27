//
//  NameTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/9/7.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NameTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
- (void)showNameStr:(NSString *)str;
@end
