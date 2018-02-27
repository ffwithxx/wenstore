//
//  AddressListTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AddressListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *nameLab;
@property (strong, nonatomic) IBOutlet UILabel *mobileLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
- (void)showModel:(NSString *)addressStr;
@end
