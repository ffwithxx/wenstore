//
//  RemarkVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@class RemarkVC;
@protocol RemarkDelegate <NSObject>

@optional

- (void)RemarkStr:(NSString*)str;
@end

@interface RemarkVC : BaseViewController
@property (strong, nonatomic) IBOutlet UILabel *tishiLab;
@property (strong, nonatomic) IBOutlet UITextView *remarkTextView;
@property (nonatomic, weak) id<RemarkDelegate> delegate;
@property (nonatomic, strong) NSString *remarkStr;

@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UILabel *titLab;
@property (strong, nonatomic) IBOutlet UIImageView *rightIMG;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *saveLab;
@property (strong, nonatomic) IBOutlet UIView *bigView;

@end
