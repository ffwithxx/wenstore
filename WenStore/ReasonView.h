//
//  ReasonView.h
//  WenStore
//
//  Created by 冯丽 on 17/9/22.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol resonDelegate <NSObject>

- (void)resonStr:(NSString *)str withKey:(NSString *)key withIndex:(NSInteger )index;

@end

@interface ReasonView : UIView
@property (strong, nonatomic) IBOutlet UITextView *resonTextFile;
@property (strong, nonatomic) IBOutlet UIButton *subMitBth;
@property (weak, nonatomic) id<resonDelegate>delegate;
@property (strong, nonatomic) NSString *keyStr;
@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) NSString *fileStr;
@end
