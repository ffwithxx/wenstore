//
//  AddAddressVC.h
//  WenStore
//
//  Created by 冯丽 on 17/8/16.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseViewController.h"

@interface AddAddressVC : BaseViewController
@property (strong, nonatomic) IBOutlet UITextField *nameLab;
@property (strong, nonatomic) IBOutlet UITextField *mobileLab;
@property (strong, nonatomic) IBOutlet UITextView *addressTextView;
@property (strong, nonatomic) IBOutlet UILabel *tishiLab;

@property (nonatomic,strong) NSString *mobileStr;

@property (nonatomic,strong) NSString *nameStr;
@property (nonatomic,strong) NSString *textViewStr;

@end
