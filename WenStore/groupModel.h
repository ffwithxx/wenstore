//
//  groupModel.h
//  WenStore
//
//  Created by 冯丽 on 17/9/14.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "BaseModel.h"

@interface groupModel : BaseModel
@property (nonatomic)int groupSno;//分組序號
@property (nonatomic)NSString *groupName;//分組名稱
@property (nonatomic)NSDictionary *topTodo;//分組第一個待辦
@property (nonatomic)NSArray *allTodos;//分組內所有待辦
@property (nonatomic)BOOL hasMoreTodo;//有更多待辦
@property (nonatomic)NSInteger maxHei;
@end
