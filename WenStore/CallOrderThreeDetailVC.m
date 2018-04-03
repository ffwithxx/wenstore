//
//  CallOrderThreeDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 2017/12/27.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "CallOrderThreeDetailVC.h"
#import "BGControl.h"
#import "EditModel.h"
#import "CallOrderThreeDetailCell.h"
#define kCellName @"CallOrderThreeDetailCell"
#import "kantuViewController.h"
@interface CallOrderThreeDetailVC ()<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    NSInteger lpdt042;
    NSInteger lpdt043;
     NSInteger lpdt036;
    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
    CallOrderThreeDetailCell *_cell;
    NSMutableArray *uploadImages;
    UIImageView *_imageview;
    UIButton *_button;
    
    
    NSMutableArray *chongArr;
    NSMutableArray *_images;
    NSMutableArray *_array;
    NSInteger _viewTag ;
    NSDecimalNumber *sumCount;
}

@end

@implementation CallOrderThreeDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self isIphoneX];
    self.bigTableView.delegate = self;
    self.bigTableView.dataSource = self;
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3008lpdt042"] ] integerValue];
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
    self.shouDateFile.enabled = NO;
    self.peiTextFile.enabled = NO;
    
    _array = [NSMutableArray new];
    _imageview = [UIImageView new];
    uploadImages = [NSMutableArray array];
    uploadImages = [self.dataDict valueForKey:@"uploadImages"];
    if (uploadImages.count> 0) {
         self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 420);
        [self setScrollView];
        
    }else{
       self.topView.frame = CGRectMake(0, 0, kScreenSize.width, 325);
         self.TwoView.frame = CGRectMake(0, 195, kScreenSize.width, 115);
        self.ZZview.hidden = YES;
    }
    
    [self.bigTableView setTableHeaderView:self.topView];
    [self.bigTableView setTableFooterView:self.footerView];
    [self Progress];
    [self setView];
    
    [self first];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    
}
- (void)isIphoneX {
    if (kiPhoneX) {
        
        self.navView.frame = CGRectMake(0, 0, kScreenSize.width, kNavHeight);
        self.titLab.frame = CGRectMake(0, 34, kScreenSize.width, 50);
        self.leftImg.frame = CGRectMake(15, 51, 22, 19);
        
        
        self.bigView.frame = CGRectMake(0, kNavHeight, kScreenSize.width, kScreenSize.height-kNavHeight);
        
        
    }
}
/**
 进度条
 */
- (void)Progress {
    NSString *oneDateStr = [BGControl dateToDateStringTwo:_orderModel.k1mf997];
    NSArray *oneTimeArr = [oneDateStr componentsSeparatedByString:@" "];
    self.oneDateLab.text = oneTimeArr[0];
    self.oneTimeLab.text = oneTimeArr[1];
    self.oneImgView.image = [UIImage imageNamed:@"greeQuan.png"];
    
    NSString *twoDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf600 ];
    if ([BGControl isNULLOfString:twoDateStr]) {
        self.twoImgView.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.twoImgView.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateArr = [twoDateStr componentsSeparatedByString:@" "];
        self.twoDateLab.text = dateArr[0];
        self.twoTimeLab.text = dateArr[1];
    }
    NSString *threeDateStr =  [BGControl dateToDateStringTwo:_orderModel.k1mf007 ];
    if ([BGControl isNULLOfString:threeDateStr]) {
        self.threeImgView.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.threeImgView.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateArr = [threeDateStr componentsSeparatedByString:@" "];
        self.threeDateLab.text = dateArr[0];
        self.threeTimeLab.text = dateArr[1];
    }
    
    NSDictionary *otherBillStateDict = _orderModel.otherBillState;
    NSString *fourDateStr = [BGControl dateToDateStringTwo:[otherBillStateDict valueForKey:@"s40" ]];
    
  
    if ([BGControl isNULLOfString:fourDateStr]) {
        self.fourImgView.image = [UIImage imageNamed:@"grayQuan.png"];
    }else{
        self.fourImgView.image = [UIImage imageNamed:@"greeQuan.png"];
        NSArray *dateArr = [fourDateStr componentsSeparatedByString:@" "];
        self.fourDateLab.text = dateArr[0];
        self.fourTimeLab.text = dateArr[1];
    }
    
   

}

/**
 是否显示金额
 */
- (void)setView {
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPrice = false;
    BOOL isyun = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF301"]) {
            isyun = true;
        }
    }
    NSInteger priceNum = 0;
    if (!isPrice) {
        
        priceNum++;
        self.sumPriceLab.hidden = YES;
       
        
        
    }
 
}

/**
 处理数据源
 */
-(void)first{
    //点击稽核按钮 k1dt105 稽核量 k1dt102配送量 k1dt103收获量
    NSArray *dataArr = [self.dataDict valueForKey:@"groupDetail"];
    sumCount = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i<dataArr.count; i++) {
        NSString *titleStr = [dataArr[i] valueForKey:@"groupTitleValue"];
        NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
        NSMutableArray *arr =[NSMutableArray array];
        for (int j = 0; j<dictDetail.count; j++) {
            EditModel *model  = [EditModel new];
            NSDictionary *dictOne = dictDetail[j];
           
            model.keyStr = [NSString stringWithFormat:@"%ld",(long)i];
            model.keyOneStr = [NSString stringWithFormat:@"%ld",(long)i];
            model.index = j;
            model.indexOne = j;
            model.xianStr = @"1";
            [model setValuesForKeysWithDictionary:dictOne];
            if ([self.tagStr isEqualToString:@"301"]) {
                 model.orderCount = [dictOne valueForKey:@"k1dt105"];
                NSString *jiheStr =[NSString stringWithFormat:@"%@",model.orderCount];
                if (![jiheStr isEqualToString:@"0"] && ![BGControl isNULLOfString:jiheStr] &&![jiheStr isEqualToString:@"(null)"]) {
                    [postArr addObject:model];
                    sumCount = [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.k1dt103]] decimalNumberByAdding:sumCount];
                }
            }else {
                if (![[NSString stringWithFormat:@"%@",model.k1dt102] isEqualToString:@"0"] ||![[NSString stringWithFormat:@"%@",model.k1dt103] isEqualToString:@"0"]) {
                    [postArr addObject:model];
                    sumCount =  [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",model.k1dt103]] decimalNumberByAdding:sumCount];
                }
            }
            
//            [arr addObject:model];
        }
     
    }
    [self setdata];
    [self.bigTableView reloadData];
}

-(void)setdata {
    
    
    CGFloat maxHei;
    CGFloat oneHei;
    NSDictionary *masterDict = [self.dataDict valueForKey:@"master"];

    
    self.beiLab.text = [masterDict valueForKey:@"k1mf010"];
    
    if (![BGControl isNULLOfString:self.beiLab.text]) {
        self.beiLab = [BGControl setLabelSpace:self.beiLab withValue:self.beiLab.text withFont:[UIFont systemFontOfSize:14]];
        CGFloat heightone = [BGControl getSpaceLabelHeight:self.beiLab.text withFont:[UIFont systemFontOfSize:14] withWidth:kScreenSize.width-110] +10;
        
        if (heightone<50) {
            self.beiLab.frame = CGRectMake(95, 0, kScreenSize.width-110, 50);
        }else{
            CGRect beizhuFile = self.beiLab.frame;
            beizhuFile.size.height = heightone;
            [self.beiLab setFrame:beizhuFile];
            
            CGRect beizhuTitleFrame = self.beiTitle.frame;
            beizhuTitleFrame.size.height = heightone;
            [self.beiTitle setFrame:beizhuTitleFrame];
            CGRect beiViewFrame = self.beiView.frame;
            beiViewFrame.size.height = heightone;
            [self.beiView setFrame:beiViewFrame];
            
            self.topView.frame = CGRectMake(0, 0, kScreenSize.width,325+heightone);
            [self.bigTableView setTableHeaderView:self.topView];
     
        }
        
    }
    NSArray *time = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf003"]] componentsSeparatedByString:@" "];
    self.shouDateFile.text = time[0];
    NSArray *timeOne = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf004"]] componentsSeparatedByString:@" "];
    self.peiTextFile.text = timeOne[0];
    self.peiTextFile.placeholder = @"";
    NSString *orderCountStr = [BGControl notRounding:sumCount afterPoint:lpdt036];
    self.countLab.text = [NSString stringWithFormat:@"%@%@%@",@"已收",orderCountStr,@"件商品"];
    
    NSString *zongpriceStr = [BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043];
    
    if (![[NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
        self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ￥",zongpriceStr ];
        NSMutableAttributedString *zongStr = [[NSMutableAttributedString alloc] initWithString:self.sumPriceLab.text];
        NSInteger zonglenght = zongStr.length;
        [zongStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
        [zongStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,zonglenght-5)];
        self.sumPriceLab.attributedText = zongStr;
        
    }else{
        self.sumPriceLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ",@"--"];
       
    }
    
    
    self.xiadanLab.text = [masterDict valueForKey:@"k1mf998"];
    self.xiadanIdLab.text = [masterDict valueForKey:@"k1mf100"];
    self.menshiNameLab.text = [masterDict valueForKey:@"k1mf011"];
    self.menshiNumLab.text = [masterDict valueForKey:@"k1mf001"];
    
    
    
    
    
    
}
#pragma mark --- 凭证
- (void)setScrollView {
    UIView *BJView = [[UIView alloc] init];
    BJView.tag = 500;
    //            BJView.backgroundColor = [UIColor redColor];
    CGRect workingFrame = CGRectMake(self.view.center.x-30, self.view.center.y-30, 60, 60);
    workingFrame.origin.x = 0;
    workingFrame.origin.y = 10;
    CGFloat maxWidth = 0;
    if (uploadImages.count >0) {
        
        
        for (int i = 0; i<uploadImages.count; i++) {
            //                UIImage *image = _images[i];
            _imageview = [[UIImageView alloc] init];
            NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
          [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"FileCenter/StoreAttachment/ExportXsmall",@"pict001=",[uploadImages[i] valueForKey:@"systemFileName"],@"imageSize=",30]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
            NSLog(@"%@", [NSString stringWithFormat:@"%@?%@%@",@"https://fc.winton.com.cn/FileCenter/StoreAttachment/ExportMedium",@"pict001=",[uploadImages[i] valueForKey:@"systemFileName"]]);
            _imageview.tag = 200+i;
            _imageview.backgroundColor = kTextGrayColor;
            _imageview.contentMode = UIViewContentModeScaleAspectFill;
            _imageview.autoresizingMask = UIViewAutoresizingNone;
            _imageview.clipsToBounds = YES;
            _imageview.frame = workingFrame;
            _button = [BGControl creatButtonWithFrame:_imageview.frame target:self sel:@selector(deletImg:) tag:100+i image:nil isBackgroundImage:NO title:nil isLayer:NO cornerRadius:0];
            [BJView addSubview:_imageview];
            [BJView addSubview:_button];
            [self.bigScrollView setPagingEnabled:YES];
            
            workingFrame.origin.x = workingFrame.origin.x + 5 + workingFrame.size.width;
            
            
        }
        maxWidth = workingFrame.origin.x + 5 ;
        [self.bigScrollView setContentSize:CGSizeMake(uploadImages.count*60+(uploadImages.count-1)*5 +65, workingFrame.size.height)];
        BJView.frame = CGRectMake(0, 0, uploadImages.count*60+(uploadImages.count-1)*5, 80);
    }
    
    
    
    [self.bigScrollView addSubview:BJView];
}
#pragma mark --- 查看大图
- (void)deletImg:(UIButton *)button {
    _viewTag = button.tag - 100;
    
    _array =  [NSMutableArray arrayWithArray:uploadImages];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    kantuViewController *picVC = [storyboard instantiateViewControllerWithIdentifier:@"kantuViewController"];
    picVC.IMGArray = _array;
    picVC.typestr = @"kan";
    picVC.IMGNum = [NSString stringWithFormat:@"%d",_viewTag];
    [self.navigationController pushViewController:picVC animated:YES];
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[CallOrderThreeDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    // _cell.delegate = self;
    EditModel *model = postArr[indexPath.row];
    
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    [_cell showModel:model with:self.billstate withTagStr:self.tagStr];
    return _cell;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat hei = 100;
    if (self.billstate == 30 && [self.tagStr isEqualToString:@"304"]) {
        hei = 80;
    }
    
    
    return hei;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return postArr.count;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
    
}
- (IBAction)buttonClick:(UIButton *)sender {
    [self.navigationController popViewControllerAnimated:YES];
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
