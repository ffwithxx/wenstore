//
//  Forecast.h
//  WenStore
//
//  Created by 冯丽 on 17/8/25.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol forecastDelegate <NSObject>

@optional
-(void)postForecastStr:(NSString *)tagStr;
@end

@interface Forecast : UIView
@property (strong, nonatomic) IBOutlet UIView *bigview;
@property (strong, nonatomic) IBOutlet UITextField *bigTextField;
@property (strong, nonatomic) IBOutlet UIView *lineView;
@property (strong, nonatomic) IBOutlet UIView *litterView;
@property (strong, nonatomic) IBOutlet UIButton *oneBth;
@property (strong, nonatomic) IBOutlet UIButton *twoBth;
@property (strong, nonatomic) IBOutlet UIButton *threeBth;
@property (strong, nonatomic) IBOutlet UIButton *fourBth;
@property (strong, nonatomic) IBOutlet UIButton *changeBth;
@property (strong, nonatomic) IBOutlet UIButton *submitBth;
@property (nonatomic,weak) id<forecastDelegate> delegate;
@property (strong, nonatomic) IBOutlet UIView *ciView;
@property (strong, nonatomic) IBOutlet UITextField *ciFile;
@property (strong, nonatomic) IBOutlet UIButton *ciButton;
@property (strong, nonatomic) IBOutlet UIView *ciLineView;
@property (strong, nonatomic) IBOutlet UITableView *ciPicker;
@property (strong, nonatomic) IBOutlet UITextField *beginTime;
@property (strong, nonatomic) IBOutlet UITextField *endTimeFile;
@property (strong, nonatomic) IBOutlet UIView *dateView;

@property (strong, nonatomic) IBOutlet UIView *dateBigView;
@property (strong, nonatomic) IBOutlet UIButton *beginBth;
@property (strong, nonatomic) IBOutlet UIButton *endBth;

@end
