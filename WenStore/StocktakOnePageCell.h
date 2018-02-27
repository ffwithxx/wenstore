//
//  StocktakOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/13.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StocktakOnePageModel.h"
@protocol ScrapDelegate <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withModel:(StocktakOnePageModel *)model;

@end

@interface StocktakOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *pandianDate;
@property (strong, nonatomic) IBOutlet UILabel *billsateLab;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLab;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UIButton *deleteBth;
@property (strong, nonatomic) IBOutlet UIButton *submitBth;
@property (strong, nonatomic) IBOutlet UIView *lasteView;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;

-(void)showModel:(StocktakOnePageModel *)model;
@property (nonatomic,weak)id <ScrapDelegate> ScrapDelegate;
@end
