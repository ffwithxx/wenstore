//
//  MatterTableViewCell.h
//  WenStore
//
//  Created by 冯丽 on 17/8/15.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MatterTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIView *readView;
@property (strong, nonatomic) IBOutlet UILabel *titleLab;
@property (strong, nonatomic) IBOutlet UILabel *timeLab;
@property (strong, nonatomic) IBOutlet UILabel *detailLab;
- (void)showModelWithDict:(NSDictionary *)dict;
@end
