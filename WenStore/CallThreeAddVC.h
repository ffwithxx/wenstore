//
//  CallThreeAddVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/23.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol zengDataDelegate <NSObject>

@optional
-(void)zengDict:(NSMutableDictionary *)dict withArr:(NSMutableArray *)arr;

@end
@interface CallThreeAddVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;

@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UILabel *choiceLab;
@property (strong, nonatomic) IBOutlet UIButton *subMitLab;
@property (strong, nonatomic) NSMutableDictionary *headDict;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (weak, nonatomic)  id<zengDataDelegate > zengdelegate;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (strong, nonatomic) IBOutlet UIView *navView;
@property (strong, nonatomic) IBOutlet UIImageView *leftImg;
@property (strong, nonatomic) IBOutlet UILabel *titLab;


@end
