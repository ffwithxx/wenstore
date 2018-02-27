//
//  Choice.h
//  WenStore
//
//  Created by 冯丽 on 17/8/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol choiceDelegate <NSObject>

@optional
- (void)postChoiceStr:(NSString *)choiceStr;
@end

@interface Choice : UIView
@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIButton *fourBth;
@property(nonatomic,weak) id<choiceDelegate> delegate;

@end
