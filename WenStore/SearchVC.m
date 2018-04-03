//
//  SearchVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/19.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "SearchVC.h"
#import "HotLabelView.h"
#import "NewModel.h"
#import "BGControl.h"

@interface SearchVC ()<UITextFieldDelegate,HotLabelViewDelegate>
{
    NSArray *arr;
    NSMutableArray *_searArray ;
    NSArray *_namesArray;
}
@property (nonatomic,strong)HotLabelView *hotLabelView;
@end

@implementation SearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self IsIphoneX];
    _searArray = [NSMutableArray array];
    _namesArray = [NSArray array];
    [self first];
    
    // Do any additional setup after loading the view.
}
- (void)IsIphoneX {
    if (kiPhoneX) {
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        
        self.leftImg.frame = CGRectMake(15, 49, 22, 19);
        self.rightLab.frame = CGRectMake(kScreenSize.width-50, 34, 35, 50);
        self.topView.frame = CGRectMake(65, 40, kScreenSize.width-130, 35);
        self.bgView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        
    }
}

- (void)first {
    NSString *strName = @"nameArray";
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; //1
    NSString *addressName = [NSString stringWithFormat:@"%@/%@",documentPath,strName];
    NSLog(@"%@", documentPath);
    NSData *data = [NSData dataWithContentsOfFile:addressName];
    // 2.创建反归档对象
    NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
    // 3.解码并存到数组中
    _namesArray = [unArchiver decodeObjectForKey:@"names"];
    // 4.循环打印
    for (NSString *name in _namesArray) {
        
        NSLog(@"%@",name);
        
    }

//   arr= @[@"脱脂牛奶",@"大豆油",@"枣夹核桃",@"芭比娃娃",@"亮晶晶的小皮鞋",@"MAC"];
    self.searchTextField.delegate = self;
    [self.searchTextField becomeFirstResponder];
    self.topView.clipsToBounds = YES;
    self.topView.layer.cornerRadius = 15.f;
    [self.searchTextField setTintColor:[UIColor whiteColor]];
    self.searchTextField.returnKeyType =UIReturnKeyGoogle;
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary]; // 创建属性字典
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:15];
    // 设置font
    attrs[NSForegroundColorAttributeName] = [UIColor whiteColor];
    // 设置颜色
    NSAttributedString *attStr = [[NSAttributedString alloc] initWithString:@"搜索商品、品牌名称" attributes:attrs];
    // 初始化富文本占位字符串
    self.searchTextField.attributedPlaceholder = attStr;
    
    CGFloat hotLabelViewX =   0.0;
    CGFloat hotLabelViewY = 10;
    CGFloat hotLabelViewW = self.bigView.frame.size.width;
    CGFloat hotLabelViewH =  self.bigView.frame.size.height - hotLabelViewY;
    self.hotLabelView = [[HotLabelView alloc] initWithFrame:CGRectMake(hotLabelViewX, hotLabelViewY, hotLabelViewW, hotLabelViewH)];
    self.hotLabelView.delegate = self;
    [self.bigView addSubview:self.hotLabelView];
    self.hotLabelView.labelArray =_namesArray;
//    saveButton.enabled = YES;

    
   
}

- (void)hotLabelViewHotLabelClick:(HotLabelView *)hotLabelView lastIndex:(NSInteger)lastIndex currentIndex:(NSInteger)currentIndex {
    NSLog(@"%ld%@%ld",currentIndex,@"加",lastIndex);
    self.searchTextField.text = _namesArray[currentIndex];
}
- (IBAction)buttonClick:(UIButton *)sender {
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else {
//     [self Alert:@"点了"];
        [self.searchTextField resignFirstResponder];
        
        NSMutableArray *searArr = [NSMutableArray array];
        NSString *searchStr = self.searchTextField.text;
        NSMutableArray *tempResults = [NSMutableArray array];
        //    isHave = NO;
        NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
        
        for (int i = 0; i<self.maxCount; i++) {
            NSMutableArray *arrone = [NSMutableArray arrayWithArray:[self.dataDict valueForKey:[NSString stringWithFormat:@"%d",i]]];
            for (int j = 0; j < arrone.count; j++) {
                NewModel *model = arrone[j];
                NSString *storeString = model.k1dt002;
                //  NSString *storeImageString=[(ContactModel *)self.dataArr[i] portrait]?[(ContactModel *)self.dataArr[i] portrait]:@"";
                
                NSRange storeRange = NSMakeRange(0, storeString.length);
                
                NSRange foundRange = [storeString rangeOfString:searchStr options:searchOptions range:storeRange];
                
                if (foundRange.length) {
                    NSDictionary *dic=@{@"k1dt002":storeString};
                    model.xianStr = @"1";
                    [tempResults addObject:dic];
                }else{
                model.xianStr = @"2";
                }
                [arrone replaceObjectAtIndex:j withObject:model];
                
            }
            [self.dataDict setObject:arrone forKey:[NSString stringWithFormat:@"%d",i]];
            [searArr removeAllObjects];
            [searArr addObjectsFromArray:tempResults];
            NSMutableArray *categoryArray = [[NSMutableArray alloc] init];
            for (unsigned i = 0; i < [searArr count]; i++) {
                @autoreleasepool {
                    if ([categoryArray containsObject:[searArr objectAtIndex:i]] == NO) {
                        NSDictionary *dict =searArr[i];
                        [categoryArray addObject:dict];
                    }
                }
            }
            [searArr removeAllObjects];
            for (NSDictionary *dict in categoryArray) {
                [searArr addObject:dict];
            }
            
        }
         [self guidang:self.searchTextField.text];
        if (_delegate && [_delegate respondsToSelector:@selector(fanDict:)]) {
            [_delegate fanDict:self.dataDict];
        }
        if (_fanDelegate && [_fanDelegate respondsToSelector:@selector(fanDict:withTitleStr:)]) {
            [_fanDelegate fanDict:self.dataDict withTitleStr:self.searchTextField.text];
        }
        
        
 [self.navigationController popViewControllerAnimated:YES];
    }
    
    
}
- (IBAction)allClick:(UIButton *)sender {
    NSString *strName = @"nameArray";
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; //1
    NSString *addressName = [NSString stringWithFormat:@"%@/%@",documentPath,strName];
    NSMutableData *datamu = [NSMutableData data];
    // 2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:datamu];
    // 3.把对象编码
    NSArray *array = [NSArray new];
    [archiver encodeObject:array forKey:@"names"];
    // 4.编码完成
    [archiver finishEncoding];
    // 5.保存归档
    [datamu writeToFile:addressName atomically:YES];
    CGFloat hotLabelViewX =   0.0;
    CGFloat hotLabelViewY = 10;
    CGFloat hotLabelViewW = self.bigView.frame.size.width;
    CGFloat hotLabelViewH =  self.bigView.frame.size.height - hotLabelViewY;
    [self.hotLabelView removeFromSuperview];
    self.hotLabelView = [[HotLabelView alloc] initWithFrame:CGRectMake(hotLabelViewX, hotLabelViewY, hotLabelViewW, hotLabelViewH)];
    self.hotLabelView.delegate = self;
    [self.bigView addSubview:self.hotLabelView];
    _namesArray = [NSArray array];
    self.hotLabelView.labelArray =_namesArray;


}

- (void)guidang:(NSString *)str {
    NSString *strName = @"nameArray";
    NSString* documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]; //1
    NSString *addressName = [NSString stringWithFormat:@"%@/%@",documentPath,strName];
    NSLog(@"%@", addressName);
    [_searArray removeAllObjects];
    if (_namesArray.count != 0) {
        NSData *data = [NSData dataWithContentsOfFile:addressName];
        // 2.创建反归档对象
        NSKeyedUnarchiver *unArchiver = [[NSKeyedUnarchiver alloc] initForReadingWithData:data];
        // 3.解码并存到数组中
        _searArray = [unArchiver decodeObjectForKey:@"names"];
        // 4.循环打印
        
    }
    //判断如果还没有归档对象并且搜索内容不为空，则把搜索的内容归档
    if (_searArray.count == 0&&![BGControl isNULLOfString:str]) {
        [_searArray addObject:str];
        
    }else  if (_searArray.count != 0&&![BGControl isNULLOfString:str]){
        int i = 0;
        NSString *isture = @"2";
        for (i = 0; i<_searArray.count; i++) {
            if ([str isEqualToString:_searArray[i]]) {
                isture = @"1";
            }
        }
        if (!([isture isEqualToString:@"1"])&&!([str isEqualToString:@""]||str ==nil)) {
            if (_searArray.count >20) {
                [_searArray replaceObjectAtIndex:0 withObject:str];
            }else  {
                [_searArray addObject:str];
            }
        }
    }
    
    
    
    NSLog(@"%@",_searArray);
    NSMutableData *datamu = [NSMutableData data];
    // 2.创建归档对象
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:datamu];
    // 3.把对象编码
    [archiver encodeObject:_searArray forKey:@"names"];
    // 4.编码完成
    [archiver finishEncoding];
    // 5.保存归档
    [datamu writeToFile:addressName atomically:YES];
}
-(BOOL) textFieldShouldReturn: (UITextField *) textField {
//    [self Alert:@"点了"];
    [self.searchTextField resignFirstResponder];
    
    
    return YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
