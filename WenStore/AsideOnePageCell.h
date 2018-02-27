//
//  AsideOnePageCell.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/30.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AsideOnePageModel.h"

@protocol orderDelegete <NSObject>
@optional
- (void)postoneStr:(NSString* )tagStr withModel:(AsideOnePageModel *)model;

@end

@interface AsideOnePageCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *dateLab;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UILabel *typeLab;
@property (strong, nonatomic) IBOutlet UILabel *storeNameLab;
@property (strong, nonatomic) IBOutlet UILabel *orderNumLab;
@property (strong, nonatomic) IBOutlet UIView *FgView;
@property (strong, nonatomic) IBOutlet UILabel *RemarkTitleLab;
@property (strong, nonatomic) IBOutlet UILabel *RemarkLab;
@property (strong, nonatomic) IBOutlet UIView *LineView;
@property (strong, nonatomic) IBOutlet UILabel *SumCountLab;
@property (strong, nonatomic) IBOutlet UILabel *SumPriceLab;
@property (strong, nonatomic) IBOutlet UIButton *SubMitBth;
@property (strong, nonatomic) IBOutlet UIButton *DeletBth;
@property (strong, nonatomic) IBOutlet UIButton *bianjiBth;
@property (nonatomic,weak)id <orderDelegete> orderDelegate;
-(void)showModel:(AsideOnePageModel *)model;

@end
