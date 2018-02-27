//
//  ScrapOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 17/10/12.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PurchaseOnePageModel.h"
@protocol ScrapDelegate <NSObject>
@optional
- (void)postoneStr:(NSString* )idStr twoStr:(NSString *)str withModel:(PurchaseOnePageModel *)model;

@end

@interface ScrapOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIButton *buttonClick;

@property (strong, nonatomic) IBOutlet UILabel *tuiDate;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UILabel *orderCountLab;
@property (strong, nonatomic) IBOutlet UILabel *sumPriceLab;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;

@property (strong, nonatomic) IBOutlet UIView *lastView;

-(void)showModel:(PurchaseOnePageModel *)model;
@property (nonatomic,weak)id <ScrapDelegate> ScrapDelegate;
@end
