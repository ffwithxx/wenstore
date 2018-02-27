//
//  dialOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/31.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DialOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(DialOnePageModel *)model;

@end


@interface dialOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UIView *FgView;
@property (strong, nonatomic) IBOutlet UILabel *RemarkTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *RemarkLab;
@property (strong, nonatomic) IBOutlet UIView *LineView;
@property (strong, nonatomic) IBOutlet UILabel *SumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *SumPriceLab;
@property (strong, nonatomic) IBOutlet UIButton *deletBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
-(void)showModel:(DialOnePageModel *)model;

@end
