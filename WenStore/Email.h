//
//  Email.h
//  WenStore
//
//  Created by 冯丽 on 2017/10/26.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol EmailDelegate <NSObject>

@optional
- (void)fanDelegate:(NSString *)email;

@end


@interface Email : UIView
@property (strong, nonatomic) IBOutlet UIView *bigView;
@property (strong, nonatomic) IBOutlet UITextField *orderFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;

@property (weak,nonatomic) id<EmailDelegate> emailDelegate;
@end
