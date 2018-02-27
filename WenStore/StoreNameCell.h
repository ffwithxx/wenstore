//
//  StoreNameCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreNameCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UILabel *numLab;
- (void)showModel:(NSDictionary *)dict;
@end
