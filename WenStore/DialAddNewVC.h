//
//  DialAddNewVC.h
//  WenStore
//
//  Created by 冯丽 on 2017/11/2.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"
@protocol zengDataDelegate <NSObject>

@optional
-(void)zengDict:(NSMutableDictionary *)dict withArr:(NSMutableArray *)arr;

@end

@interface DialAddNewVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITableView *leftTableView;
@property (strong, nonatomic) IBOutlet UITableView *rightTableView;
@property (strong, nonatomic) IBOutlet UILabel *sumCountLab;
@property (strong, nonatomic) IBOutlet UIImageView *searchImg;
@property (strong, nonatomic) NSMutableDictionary *headDict;
@property (strong, nonatomic) NSMutableDictionary *ruleDita;
@property (strong, nonatomic) NSMutableArray *ruleArr;
@property (strong, nonatomic) NSMutableDictionary *dataDict;
@property (strong, nonatomic) IBOutlet UIButton *searchBth;
@property (weak, nonatomic)  id<zengDataDelegate > zengdelegate;
@end
