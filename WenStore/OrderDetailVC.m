//
//  OrderDetailVC.m
//  WenStore
//
//  Created by 冯丽 on 17/8/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "OrderDetailVC.h"
#import "OrderDetailCell.h"
#import "BGControl.h"
#import "AddressListVC.h"
#import "RemarkVC.h"
#import "PayViewController.h"
#import "OrderTwoDetailVC.h"
#define kCellName @"OrderDetailCell"
#import "NewModel.h"
#import "SZCalendarPicker.h"
#import "AFClient.h"
#import "NameViewController.h"
#import "PhoneVC.h"
#import "OrderTwoVC.h"
#import "CMInputView.h"
#import "BGControl.h"
#import "ELCImagePickerHeader.h"
#import "kantuViewController.h"

@interface OrderDetailVC ()<AddressDelegate,RemarkDelegate,HeiDelegate,NameDelegate,PhoneDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,ELCImagePickerControllerDelegate,postArrDelegate>{
    OrderDetailCell *_cell;
        NSString *peiStr;
    NSMutableDictionary *masterDictone;
    NSMutableArray *postOneArr;
    NSString *addressStr;
    NSInteger lpdt043;
    NSInteger lpdt042;
    NSInteger lpdt036;
    NSString *postStr;
    NSMutableArray *uploadImagesArr;
    
    
    NSMutableArray *chongArr;
    NSMutableArray *_images;
    NSMutableArray *_array;
    UIImageView *_imageview;
    NSInteger _viewTag ;
    NSMutableArray *posImgArr;
    NSMutableArray *getArr;
    NSString *typeStr;
    NSInteger num;
    NSString *bthStr;
   UIButton *_button;
    NSString *isShan;
    NSString *isEnablePayment;
    NSMutableArray *oldImgArr;
     NSString *jsob001Str;
 
    
}
@property (nonatomic,strong) CMInputView *inputView;
@end

@implementation OrderDetailVC
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
    
    if ([isShan isEqualToString:@"2"]) {
        uploadImagesArr =chongArr;
        for (UIView *view in [self.bigScrollView subviews]) {
            if (view.tag ==500) {
                [view removeFromSuperview];
            }
        }
        [self creatImgScr];
//        [uploadImagesArr removeAllObjects];
//        NSMutableArray *arr = [NSMutableArray arrayWithArray:uploadImagesArr];
//        for (int i = 0; i<arr.count; i++) {
//
//            [self uploadPicturewithInsdex:i withArr:arr];
//
//        }



    }

}

- (void)viewDidLoad {
    [super viewDidLoad];
    isShan = @"1";
    [self firstTwo];
    jsob001Str = [self.datadict valueForKey:@"jsob001"];
    isEnablePayment = [[NSUserDefaults standardUserDefaults] valueForKey:@"isEnablePayment"];
    uploadImagesArr = [NSMutableArray array];
    oldImgArr = [NSMutableArray array];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"lpdt042"] ] integerValue];
    postOneArr = [NSMutableArray array];
    self.topview.frame = CGRectMake(0, 0, kScreenSize.width, 485);
//     self.bottomView.frame = CGRectMake(0, 0, kScreenSize.width, 100);
    [self.bigTableVIew setTableHeaderView:self.topview];
    [self.bigTableVIew setTableFooterView:self.bottomView];
    
    self.bigTableVIew.showsVerticalScrollIndicator = NO;
    self.bigTableVIew.separatorStyle = UITableViewCellSelectionStyleNone;
    [self first];
    self.phoneFile.returnKeyType =UIReturnKeyDone;
     self.nameFile.returnKeyType =UIReturnKeyDone;
    self.phoneFile.delegate = self;
    self.nameFile.delegate = self;
    self.addressFile.delegate = self;
    _inputView = [[CMInputView alloc]initWithFrame:CGRectMake(10, 10, kScreenSize.width-50, 30)];
    
    _inputView.font = [UIFont systemFontOfSize:15];
    
      _inputView.returnKeyType =UIReturnKeyDone;
    _inputView.delegate = self;
    
  _inputView.txtStr = [[self.datadict valueForKey:@"master"] valueForKey:@"k1mf104"];
    
    if ([BGControl isNULLOfString: [[self.datadict valueForKey:@"master"] valueForKey:@"k1mf104"]]) {
          _inputView.placeholder = @"请输入联系地址";
    }
    _inputView.cornerRadius = 4;
    _inputView.placeholderColor = kTextLighColor;
    //_inputView.placeholderFont = [UIFont systemFontOfSize:22];
    // 设置文本框最大行数
    [_inputView textValueDidChanged:^(NSString *text, CGFloat textHeight) {
        addressStr = text;
       
        CGRect frame = _inputView.frame;
        frame.size.height = textHeight;
     
        
        if (textHeight > 50) {
              frame.origin.y = 0;
            CGRect addressFrame = self.AddressView.frame;
            addressFrame.size.height = textHeight;
            [self.AddressView setFrame:addressFrame];
            
            CGRect xiaFrame = self.xiaView.frame;
            xiaFrame.origin.y = CGRectGetMaxY(self.AddressView.frame)+1;
            [self.xiaView setFrame:xiaFrame];
            
            self.topview.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.xiaView.frame));
            self.fgView.frame = CGRectMake(0,CGRectGetMaxY(self.xiaView.frame)-1, kScreenSize.width, 1);
            self.pushImg.frame = CGRectMake(kScreenSize.width-23, (textHeight+1-13)/2, 8, 13);
            [self.bigTableVIew setTableHeaderView:self.topview];

        }
        _inputView.frame = frame;
    }];
    [self.AddressView addSubview:self.fgView];
    
    _inputView.maxNumberOfLines = 4;
    [self.AddressView addSubview:_inputView];
    masterDictone = [[NSMutableDictionary alloc] initWithDictionary:[self.datadict valueForKey:@"master"]];
;


    // Do any additional setup after loading the view.
}

-(void)firstTwo {

    _images = [NSMutableArray array];
    _array = [NSMutableArray new];
    _imageview = [UIImageView new];
    posImgArr = [NSMutableArray new];
    getArr = [NSMutableArray new];
   
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deletImgView) name:@"TakePhotoViewPicture" object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hiddenAllJumpView) name:@"allHidden" object:nil];

}


#pragma mark---- 初始化 ----
- (void)first {
    NSLog(@"%@",self.datadict);
    self.dataArray = [NSMutableArray array];
    self.peiTypeView.clipsToBounds = YES;
    self.peiTypeView.layer.cornerRadius = 10.f;
    self.oneBth.layer.cornerRadius = 15.f;
    self.oneBth.layer.borderColor = kTabBarColor.CGColor;
    self.oneBth.layer.borderWidth = 1.f;
    self.twoBth.layer.cornerRadius = 15.f;
    self.twoBth.layer.borderColor = kTabBarColor.CGColor;
    self.twoBth.layer.borderWidth = 1.f;
    
    self.threeBth.layer.cornerRadius = 15.f;
    self.threeBth.layer.borderColor = kTabBarColor.CGColor;
    self.threeBth.layer.borderWidth = 1.f;
    self.fourBth.layer.cornerRadius = 15.f;
    self.fourBth.layer.borderColor = kTabBarColor.CGColor;
    self.fourBth.layer.borderWidth = 1.f;

    CGRect peiFrame = self.peiTypeView.frame;
    peiFrame.size.width = kScreenSize.width - 40;
    [self.peiTypeView setFrame:peiFrame];
    self.peiTypeView.center = self.view.center;
  
    NSArray *ImgArr = [self.datadict valueForKey:@"uploadImages"];
    for ( int i = 0; i < ImgArr.count; i++) {
        NSDictionary *dic =ImgArr[i];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        [dict setValue:[dic valueForKey:@"systemFileName"] forKey:@"systemFileName"];
        [dict setValue:[dic valueForKey:@"pict001"] forKey:@"pict001"];
        [dict setValue:[dic valueForKey:@"pict800"] forKey:@"pict800"];
        [dict setValue:[dic valueForKey:@"fileName"] forKey:@"fileName"];
        [dict setValue:@"old" forKey:@"type"];
        [uploadImagesArr addObject:dict];
        [oldImgArr addObject:dict];
    }
    
    [self creatImgScr];
    self.jiaoField.text = [BGControl dateToDateString:[[self.datadict valueForKey:@"master"] valueForKey:@"k1mf003"]];
     self.peiField.text = [BGControl dateToDateString:[[self.datadict valueForKey:@"master"] valueForKey:@"k1mf004"]];
  
 
    NSDictionary *masterDict = [self.datadict valueForKey:@"master"];
    int peiType = [[masterDict valueForKey:@"k1mf201"] intValue];
    if (peiType == 0) {
        self.peiTypeField.text = @"自提";
        peiStr = @"0";
    }else if (peiType == 1) {
        self.peiTypeField.text = @"货运";
        peiStr = @"1";
    }
     self.noticeField.text = [masterDict valueForKey:@"k1mf010"];
    self.yunPrice.text = [NSString stringWithFormat:@"%@%@",@"运费: ￥", [BGControl notRounding:[masterDict valueForKey:@"k1mf301"] afterPoint:lpdt043]];
        NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.yunPrice.text];
        NSInteger pricelenght = priceStr.length;
        [priceStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
        [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,pricelenght-5)];
        self.yunPrice.attributedText = priceStr;
    
    
    
    
    NSString *zongpriceStr = [BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043];

    if (![[NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf302"]] isEqualToString:@"0"]) {
         self.buyPriceLab.text = [NSString stringWithFormat:@"%@%@",@"合计: ￥", zongpriceStr];
        NSMutableAttributedString *buyStr = [[NSMutableAttributedString alloc] initWithString:self.buyPriceLab.text];
        NSInteger buylenght = buyStr.length;
        [buyStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 4)];
        [buyStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(3,buylenght-5)];
        self.buyPriceLab.attributedText = buyStr;
    }else{
        self.buyPriceLab.text = [NSString stringWithFormat:@"%@%@",@"合计: ", @""];
    }
   
    
    
    
    NSDecimalNumber *yunDec = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:[masterDict valueForKey:@"k1mf301"] afterPoint:lpdt043]];
    NSString *zongji = [BGControl notRounding:[[NSDecimalNumber decimalNumberWithString:zongpriceStr] decimalNumberByAdding:yunDec] afterPoint:lpdt043];
    if (![[NSString stringWithFormat:@"%@",[[NSDecimalNumber decimalNumberWithString:zongpriceStr] decimalNumberByAdding:yunDec]] isEqualToString:@"0"]) {
        self.zongjiOneLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ￥",zongji ];
        NSMutableAttributedString *zongStr = [[NSMutableAttributedString alloc] initWithString:self.zongjiOneLab.text];
        NSInteger zonglenght = zongStr.length;
        [zongStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
        [zongStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,zonglenght-5)];
        self.zongjiOneLab.attributedText = zongStr;
    }else{
       self.zongjiOneLab.text = [NSString stringWithFormat:@"%@%@",@"总计: ",@"" ];
    }
    
   
    
    

    if (![[NSString stringWithFormat:@"%@",[[NSDecimalNumber decimalNumberWithString:zongpriceStr] decimalNumberByAdding:yunDec]] isEqualToString:@"0"]) {
          self.priceLab.text = [NSString stringWithFormat:@"%@%@",@"￥",zongji];
    }else{
         self.priceLab.text = @"";
    }
   
    NSString *countStr = [NSString stringWithFormat:@"%@",[masterDict valueForKey:@"k1mf303"]];
    self.buyOrdedrCount.text = [NSString stringWithFormat:@"%@%@%@",@"已购",countStr,@"件商品"];
    self.nameFile.text = [masterDict valueForKey:@"k1mf113"];
    self.phoneFile.text = [masterDict valueForKey:@"k1mf112"];
//    self.addressFile.text = [masterDict valueForKey:@"k1mf104"];
    
    
    [self contentSizeToFit];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPhone= false;
    BOOL isPrice = false;
    BOOL isName = false;
    BOOL isAddress = false;
    BOOL isPei = false;
    BOOL isyun = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1DT201"]) {
            isPrice = true;
        }
        if ([visiableFieldsStr isEqualToString:@"K1MF201"]) {
            isPei = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF113"]) {
            isName = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF104"]) {
            isAddress = true;
        }
        
        if ([visiableFieldsStr isEqualToString:@"K1MF112"]) {
            isPhone = true;
        }
        if ([visiableFieldsStr isEqualToString:@"K1MF301"]) {
            isyun = true;
        }
    }
    
/*判断姓名 电话、地址、配送方式是否显示*/
    
    
    NSInteger num = 0;
    if (!isName) {
        num ++;
        self.nameView.hidden = YES;
    }
    
    if (!isPhone) {
        num++;
        self.phoneView.hidden = YES;
    }else{
        
        self.phoneView.frame = CGRectMake(0,65-num*50, kScreenSize.width, 50);
    }
    if (!isAddress) {
        num++;
        self.AddressView.hidden = YES;
    }else{
        self.AddressView.frame = CGRectMake(0, 110-num*50, kScreenSize.width, 50);
    }
    self.xiaView.frame = CGRectMake(0, 160-50*num, kScreenSize.width, 325);
    if (!isPei) {
        num++;
        self.peiView.hidden = YES;
        self.beiView.frame = CGRectMake(0, 165-50, kScreenSize.width, 50);
        self.updateImgVIew.frame = CGRectMake(0, 230-50, kScreenSize.width, 80);
         self.xiaView.frame = CGRectMake(0, 160-50*(num - 1), kScreenSize.width, 275);
    }
    self.topview.frame = CGRectMake(0, 0, kScreenSize.width, 485-50*num);
  /*判断金额是否显示*/
    NSInteger priceNum = 0;
    if (!isPrice) {
       
        priceNum++;
        self.buyPriceLab.hidden = YES;
        self.allPriceView.hidden = YES;
        self.priceLab.hidden = YES;
        
    }
    if (!isyun) {
        priceNum ++;
        self.yunView.hidden = YES;
        
    }
    CGRect bottomFrame = self.bottomView.frame;
    bottomFrame.size.height = 150 - priceNum*50;
    [self.bottomView setFrame:bottomFrame];
     [self.bigTableVIew setTableFooterView:self.bottomView];
    if ([self.typeStr isEqualToString:@"2"]) {
        NSArray *dataArr = [self.datadict valueForKey:@"groupDetail"];
        NSMutableArray *detailArr = [[NSMutableArray alloc] init];
        for (int i = 0; i<dataArr.count; i++) {
            
            NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
            
            for (int j = 0; j<dictDetail.count; j++) {
                NewModel *model = [NewModel new];
                NSDictionary *dict = dictDetail[j];
                model.bottomHei = 0;
               
                
                NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dict valueForKey:@"k1dt102"]]];
                NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                if (compar == NSOrderedDescending) {
                    [model setValuesForKeysWithDictionary:dict];
                    [self.dataArray addObject:model];
                    
                }
              
            }
        }
        
       
    }else{
        NSArray *oneArr = [self.datadict valueForKey:@"detail"];
        for (int i = 0; i<oneArr.count; i++) {
            NewModel *model = [NewModel new];
            NSDictionary *dict = oneArr[i];
            model.bottomHei = 0;
            [model setValuesForKeysWithDictionary:dict];
            [self.dataArray addObject:model];
            
        }
    }
    
    [self.bigTableVIew reloadData];
    
    
}
-(void)blackButtonClick {
    self.blackButton.hidden = YES;

    [self.peiTypeView removeFromSuperview];
}
- (IBAction)peiClick:(UIButton *)sender {
    if (sender.tag == 801) {
        self.blackButton.hidden = YES;
      
        [self.peiTypeView removeFromSuperview];
       

    }else if (sender.tag == 802) {
        peiStr = @"0";
        self.peiTypeField.text = @"自提";
         NSNumber *numone =[NSNumber numberWithInt:0 ];
        [masterDictone setObject:numone forKey:@"k1mf201"];
    }else if (sender.tag == 803) {
        peiStr = @"1";
        self.peiTypeField.text = @"货运";
        NSNumber *numone =[NSNumber numberWithInt:1 ];
        [masterDictone setObject:numone forKey:@"k1mf201"];  }
    //else if (sender.tag == 804) {
//        peiStr = @"2";
//        self.peiTypeField.text = @"冷藏配送";
//          NSNumber *numtwo =[NSNumber numberWithInt:2 ];
//
//        [masterDictone setObject:numtwo forKey:@"k1mf202"];
//    }
//    else if (sender.tag == 805){
//     peiStr = @"3";
//         self.peiTypeField.text = @"冷冻配送";
//          NSNumber *numthree =[NSNumber numberWithInt:3 ];
//        [masterDictone setObject:numthree forKey:@"k1mf202"];
//    }
    self.blackButton.hidden = YES;
    __block OrderDetailVC *orderVC = self;
    [self.peiTypeView removeFromSuperview];
    
}
- (void)contentSizeToFit {
    //先判断一下有没有文字（没文字就没必要设置居中了）
    if([self.addressFile.text length]>0) {
        //textView的contentSize属性
        CGSize contentSize = self.addressFile.contentSize;
        //textView的内边距属性
        UIEdgeInsets offset; CGSize newSize = contentSize;
        //如果文字内容高度没有超过textView的高度
        if(contentSize.height <= self.addressFile.frame.size.height) {
            //textView的高度减去文字高度除以2就是Y方向的偏移量，也就是textView的上内边距
            CGFloat offsetY = (self.addressFile.frame.size.height - contentSize.height)/2;
            offset = UIEdgeInsetsMake(offsetY, 0, 0, 0); } else
                //如果文字高度超出textView的高度
            { newSize = self.addressFile.frame.size; offset = UIEdgeInsetsZero; CGFloat fontSize = 18;
                //通过一个while循环，设置textView的文字大小，使内容不超过整个textView的高度（这个根据需要可以自己设置）
                while (contentSize.height > self.addressFile.frame.size.height) {
                    [self.addressFile setFont:[UIFont fontWithName:@"Helvetica Neue" size:fontSize--]];
                    contentSize = self.addressFile.contentSize; }
                newSize = contentSize;
            }
        //根据前面计算设置textView的ContentSize和Y方向偏移量
        [self.addressFile setContentSize:newSize];
        [self.addressFile setContentInset:offset];
    }

}
    




- (IBAction)buttonClick:(UIButton *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 202){
        
    //地址
        AddressListVC *listVC = [storyboard instantiateViewControllerWithIdentifier:@"AddressListVC" ];
        listVC.delegate = self;
       
             listVC.arr = [NSMutableArray arrayWithArray:self.adreessArr];
//        }else {
//           listVC.arr = [NSMutableArray arrayWithArray:[self.datadict valueForKey:@"recentAddresses"]];
//
//        }
       
        [self.navigationController pushViewController:listVC animated:YES];
        
    }else if (sender.tag == 203){
        //叫货日期
        
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        calendarPicker.frame = CGRectMake(20, 0.15*self.view.frame.size.height, self.view.frame.size.width-40, 0.7*self.view.frame.size.height);
        calendarPicker.center = self.view.center;
        calendarPicker.clipsToBounds = YES;
        
        calendarPicker.layer.cornerRadius = 10.f;
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
            NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)day];
            NSString *monthStr = [NSString stringWithFormat:@"%ld",(long)month];;
            NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)year];;
            if (day < 10) {
                dayStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)day];
            }
            if (month < 10) {
                monthStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)month];
            }
            self.jiaoField.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
            NSDate *jiaoDate = [BGControl stringToDate:self.jiaoField.text];
            NSString *jiaoSter = [NSString stringWithFormat:@"%@",jiaoDate];
            [masterDictone setObject:jiaoSter forKey:@"k1mf003"];
        };

    }else if (sender.tag == 204){
        //配送日期
        SZCalendarPicker *calendarPicker = [SZCalendarPicker showOnView:self.view];
        calendarPicker.today = [NSDate date];
        calendarPicker.date = calendarPicker.today;
        calendarPicker.frame = CGRectMake(20, 0.15*self.view.frame.size.height, self.view.frame.size.width-40, 0.7*self.view.frame.size.height);
        calendarPicker.center = self.view.center;
        calendarPicker.clipsToBounds = YES;
        
        calendarPicker.layer.cornerRadius = 10.f;
        calendarPicker.calendarBlock = ^(NSInteger day, NSInteger month, NSInteger year){
            NSString *dayStr = [NSString stringWithFormat:@"%ld",(long)day];
            NSString *monthStr = [NSString stringWithFormat:@"%ld",(long)month];;
            NSString *yearStr = [NSString stringWithFormat:@"%ld",(long)year];;
            if (day < 10) {
                dayStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)day];
            }
            if (month < 10) {
                monthStr = [NSString stringWithFormat:@"%@%ld",@"0",(long)month];
            }
            self.peiField.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
           
            NSDate *peiDate = [BGControl stringToDate:self.peiField.text];
             NSString *peiSter = [NSString stringWithFormat:@"%@",peiDate];
             [masterDictone setObject:peiSter forKey:@"k1mf004"];
        };
    }else if (sender.tag == 205){
        //配送方式
        self.blackButton.hidden = NO;
        [self.view addSubview:self.peiTypeView];
        if ([peiStr isEqualToString:@"0"]) {
            [self.oneBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.oneBth setBackgroundColor:kTabBarColor];
            
            [self.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.twoBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.threeBth setBackgroundColor:[UIColor whiteColor]];

            [self.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.fourBth setBackgroundColor:[UIColor whiteColor]];

            
        }else if ([peiStr isEqualToString:@"1"]) {
            [self.twoBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.twoBth setBackgroundColor:kTabBarColor];
            [self.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.oneBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.threeBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.fourBth setBackgroundColor:[UIColor whiteColor]];
        }else if ([peiStr isEqualToString:@"2"]) {
            [self.threeBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.threeBth setBackgroundColor:kTabBarColor];
            [self.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.oneBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.twoBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.fourBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.fourBth setBackgroundColor:[UIColor whiteColor]];
        }else if ([peiStr isEqualToString:@"3"]) {
            [self.fourBth setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            [self.fourBth setBackgroundColor:kTabBarColor];
            [self.oneBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.oneBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.twoBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.twoBth setBackgroundColor:[UIColor whiteColor]];
            
            [self.threeBth setTitleColor:kTextGrayColor forState:UIControlStateNormal];
            [self.threeBth setBackgroundColor:[UIColor whiteColor]];
        }

        
    }else if (sender.tag == 206){
        //配送备注
        RemarkVC *remark = [storyboard instantiateViewControllerWithIdentifier:@"RemarkVC"];
        remark.remarkStr = self.noticeField.text;
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
    }else if (sender.tag == 207){
        //转账凭证
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        [sheet showInView:self.view];
    }else if (sender.tag == 208){
        //保存
        
        [self baocunClient];
    }else if (sender.tag == 209){
        //提交
        [self tijiaoClient];
      
    }else if (sender.tag == 210){
        //名字
        NameViewController *listVC = [storyboard instantiateViewControllerWithIdentifier:@"NameViewController" ];
        listVC.delegate = self;
//        if ([self.typeStr isEqualToString:@"1"]) {
            listVC.arr = [NSMutableArray arrayWithArray:self.nameArr];
//        }else {
//            listVC.arr = [NSMutableArray arrayWithArray:[self.datadict valueForKey:@"recentContactWindows"]];
//
//        }
//
        
        
       
        [self.navigationController pushViewController:listVC animated:YES];

    }else if (sender.tag == 211){
        //名字
        PhoneVC *listVC = [storyboard instantiateViewControllerWithIdentifier:@"PhoneVC" ];
        listVC.delegate = self;
//        if ([self.typeStr isEqualToString:@"1"]) {
          listVC.arr = [NSMutableArray arrayWithArray:self.phoneArr];
//        }else {
//            listVC.arr = [NSMutableArray arrayWithArray:[self.datadict valueForKey:@"recentContactPhones"]];
//
//        }
       
        [self.navigationController pushViewController:listVC animated:YES];
        
    }

}

-(void)baocunClient {
    [masterDictone setObject:self.nameFile.text forKey:@"k1mf113"];
    [masterDictone setObject:self.phoneFile.text forKey:@"k1mf112"];
    [masterDictone setObject:_inputView.text forKey:@"k1mf104"];

     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self show];
    NSNumber *num1 = [NSNumber numberWithBool:NO];
      [masterDictone setObject:_inputView.text forKey:@"k1mf104"];
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:masterDictone,@"master", num1,@"isConfirmed",[self.datadict valueForKey:@"detail"],@"detail",uploadImagesArr,@"uploadImages",nil];
    [postMast setObject:[self.datadict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    [postMast setObject:[self.datadict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    if (![BGControl isNULLOfString:jsob001Str]) {
        [postMast setObject:jsob001Str forKey:@"jsob001"];
    }
    if ([self.typeStr isEqualToString:@"1"]) {
        [[AFClient shareInstance] Create:postMast withArr:postOneArr withUrl:@"App/Wbp3001/Create" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            [self dismiss];
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                    OrderTwoVC *orderDetailTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                    [self.navigationController pushViewController:orderDetailTwo animated:YES];
                }else {
                    [self dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                    if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        }];
                        [alertController addAction:cancelAction];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                            [self baocunClient];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self baocunClient];
                                
                                ;
                            }];
                            [alertController addAction:home1Action];
                        }
                        //取消style:UIAlertActionStyleDefault
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                    }
                    //添加取消到UIAlertController中
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    

                }
                
            }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        } failure:^(NSError *error) {
            [self dismiss];
        }];
        
    }else {
        if ([BGControl isNULLOfString:self.k1mf800]) {
            [masterDictone setObject:[[self.datadict valueForKey:@"master"]valueForKey:@"k1mf800"] forKey:@"k1mf800"];
        }else{
            [masterDictone setObject:self.k1mf800 forKey:@"k1mf800"];
        }
        if ([BGControl isNULLOfString:self.idStr]) {
            [masterDictone setObject:[[self.datadict valueForKey:@"master"]valueForKey:@"k1mf100"] forKey:@"k1mf100"];
        }else{
            [masterDictone setObject:self.idStr forKey:@"k1mf100"];
        }
        [masterDictone setObject:_inputView.text forKey:@"k1mf104"];
        NSMutableDictionary *postMast = [[NSMutableDictionary alloc] init];
        [postMast setObject:masterDictone forKey:@"master"];
        [postMast setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"isConfirmed"];
        [postMast setObject:uploadImagesArr forKey:@"uploadImages"];
        if ([self.typeStr isEqualToString:@"2"]) {
            NSArray *dataArr = [self.datadict valueForKey:@"groupDetail"];
            NSMutableArray *detailArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<dataArr.count; i++) {
                
                NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                
                for (int j = 0; j<dictDetail.count; j++) {
                    NewModel *model  = [NewModel new];
                    NSDictionary *dictOne = dictDetail[j];
                    NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt102"]]];
                    NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                    if (compar == NSOrderedDescending) {
                        [model setValuesForKeysWithDictionary:dictOne];
                        [self.dataArray addObject:model];
                        [detailArr addObject:dictOne];
                    }
                  
                }
            }
            
            [postMast setObject:detailArr forKey:@"detail"];
            
        }else{
            [postMast setObject:[self.datadict valueForKey:@"detail"] forKey:@"detail"];
            
        }
        
        [postMast setObject:[self.datadict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
        [postMast setObject:[self.datadict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
        [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3001/Update" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            [self dismiss];
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                 NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                    OrderTwoVC *orderDetailTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                    
                    [self.navigationController pushViewController:orderDetailTwo animated:YES];
                }else {
                
                    [self dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                    if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        }];
                        [alertController addAction:cancelAction];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                            [self baocunClient];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self baocunClient];
                                
                                ;
                            }];
                            [alertController addAction:home1Action];
                        }
                        //取消style:UIAlertActionStyleDefault
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                    }
                    //添加取消到UIAlertController中
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    

                }
               
            }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        } failure:^(NSError *error) {
            [self dismiss];
        }];
        
        
        
    }

}
-(void)tijiaoClient{
    [masterDictone setObject:self.nameFile.text forKey:@"k1mf113"];
    [masterDictone setObject:self.phoneFile.text forKey:@"k1mf112"];
    [masterDictone setObject:_inputView.text forKey:@"k1mf104"];

     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    [self show];
    NSNumber *num2 = [NSNumber numberWithBool:YES];
    
    NSMutableDictionary *postMast = [NSMutableDictionary dictionaryWithObjectsAndKeys:masterDictone,@"master", num2,@"isConfirmed",[self.datadict valueForKey:@"detail"],@"detail",uploadImagesArr,@"uploadImages",nil];
    [postMast setObject:[self.datadict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
    [postMast setObject:[self.datadict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
    if (![BGControl isNULLOfString:jsob001Str]) {
        [postMast setObject:jsob001Str forKey:@"jsob001"];
    }
    if ([self.typeStr isEqualToString:@"1"]) {
        [[AFClient shareInstance] Create:postMast withArr:postOneArr withUrl:@"App/Wbp3001/CreateAndConfirm" progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            [self dismiss];
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                  NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                    if ([isEnablePayment isEqualToString:@"1"]) {
                        PayViewController *payVC = [storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
                            payVC.fanStr = @"OrderDetailVC";
                        NSDictionary *paymentDict = [[responseBody valueForKey:@"data"] valueForKey:@"data"];
                        payVC.k1mf100 = [paymentDict valueForKey:@"k1mf100"];
                        payVC.sumPrice = [paymentDict valueForKey:@"payment"];
                        NSDictionary *masterDict = [self.datadict valueForKey:@"master"];
                        NSDecimalNumber *sumPrice = [[masterDict valueForKey:@"k1mf301"] decimalNumberByAdding:[masterDict valueForKey:@"k1mf302"]];
                        payVC.sumPrice =sumPrice;
                            [self.navigationController pushViewController:payVC animated:YES];
                    }else {
                        OrderTwoVC *orderDetailTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                        
                        [self.navigationController pushViewController:orderDetailTwo animated:YES];
                    }
                   

                    
                }else{
                    [self dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                    if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        }];
                        [alertController addAction:cancelAction];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                            [self tijiaoClient];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self tijiaoClient];
                                
                                ;
                            }];
                            [alertController addAction:home1Action];
                        }
                        //取消style:UIAlertActionStyleDefault
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                    }
                    //添加取消到UIAlertController中
                    
                    [self presentViewController:alertController animated:YES completion:nil];

                }
               
            }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        } failure:^(id erroresponseBody) {
            NSString *str = [erroresponseBody valueForKey:@"errors"][0];
            [self Alert:str];
            [self dismiss];
        }];
        
    }else {
        
            if ([BGControl isNULLOfString:self.k1mf800]) {
                  [masterDictone setObject:[[self.datadict valueForKey:@"master"]valueForKey:@"k1mf800"] forKey:@"k1mf800"];
            }else{
                 [masterDictone setObject:self.k1mf800 forKey:@"k1mf800"];
            }
            if ([BGControl isNULLOfString:self.idStr]) {
                [masterDictone setObject:[[self.datadict valueForKey:@"master"]valueForKey:@"k1mf100"] forKey:@"k1mf100"];
            }else{
                 [masterDictone setObject:self.idStr forKey:@"k1mf100"];
            }
           
        
        
        NSMutableDictionary *postMast = [[NSMutableDictionary alloc] init];
        
        [postMast setObject:masterDictone forKey:@"master"];
        [postMast setObject:[NSString stringWithFormat:@"%ld",num] forKey:@"isConfirmed"];
        //self.typeStr = 2是从订单列表页面来的单据
        if ([self.typeStr isEqualToString:@"2"]) {
            NSArray *dataArr = [self.datadict valueForKey:@"groupDetail"];
            NSMutableArray *detailArr = [[NSMutableArray alloc] init];
            for (int i = 0; i<dataArr.count; i++) {
                
                NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
                
                for (int j = 0; j<dictDetail.count; j++) {
                    NewModel *model  = [NewModel new];
                    NSDictionary *dictOne = dictDetail[j];
                    NSDecimalNumber *orderCount = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",[dictOne valueForKey:@"k1dt102"]]];
                    NSComparisonResult compar = [orderCount compare:[NSDecimalNumber decimalNumberWithString:@"0"]];
                    if (compar == NSOrderedDescending) {
                        [model setValuesForKeysWithDictionary:dictOne];
                        [self.dataArray addObject:model];
                        [detailArr addObject:dictOne];
                    }
                    
                }
            }
            
            [postMast setObject:detailArr forKey:@"detail"];
           
        }else{
         [postMast setObject:[self.datadict valueForKey:@"detail"] forKey:@"detail"];
        
        }
        [postMast setObject:[self.datadict valueForKey:@"promoOrders"] forKey:@"promoOrders"];
        [postMast setObject:[self.datadict valueForKey:@"freeOrders"] forKey:@"freeOrders"];
        [postMast setObject:uploadImagesArr forKey:@"uploadImages"];
        
        [[AFClient shareInstance] Update:postMast withArr:postOneArr withUrl:@"App/Wbp3001/UpdateAndConfirm"  progressBlock:^(NSProgress *progress) {
            
        } success:^(id responseBody) {
            [self dismiss];
            if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
                 NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
                if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                    [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
//                    PayViewController *payVC = [storyboard instantiateViewControllerWithIdentifier:@"PayViewController"];
//                    payVC.fanStr = @"OrderDetailVC";
//                    [self.navigationController pushViewController:payVC animated:YES];
                    OrderTwoVC *orderDetailTwo = [storyboard instantiateViewControllerWithIdentifier:@"OrderTwoVC"];
                    
                    [self.navigationController pushViewController:orderDetailTwo animated:YES];

                }else {
                    [self dismiss];
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:[userResponseDict valueForKey:@"title"] message:[userResponseDict valueForKey:@"message"] preferredStyle:UIAlertControllerStyleAlert ];
                    if ([[userResponseDict valueForKey:@"code"] intValue]== 1 ) {
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                        }];
                        [alertController addAction:cancelAction];
                        UIAlertAction *confirmAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_1"]];
                            [self baocunClient];
                            ;
                        }];
                        [alertController addAction:confirmAction];
                        
                    }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                        NSArray *options = [userResponseDict valueForKey:@"options" ];
                        for (int i = 0; i < options.count; i++) {
                            UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                                [postOneArr removeAllObjects];
                                [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                                [self baocunClient];
                                
                                ;
                            }];
                            [alertController addAction:home1Action];
                        }
                        //取消style:UIAlertActionStyleDefault
                        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]; [alertController addAction:cancelAction];
                    }
                    //添加取消到UIAlertController中
                    
                    [self presentViewController:alertController animated:YES completion:nil];
                    

                }
            }else {
                NSString *str = [responseBody valueForKey:@"errors"][0];
                [self Alert:str];
                
            }
        } failure:^(id erroresponseBody) {
          NSString *str = [erroresponseBody valueForKey:@"errors"][0];
         [self Alert:str];

            [self dismiss];
        }];
        
    }

}
- (void)NameStr:(NSString *)str {
    self.nameFile.text = str;
     [masterDictone setObject:str forKey:@"k1mf113"];
}
-(void)RemarkStr:(NSString *)str {
    self.noticeField.text = str;
     [masterDictone setObject:str forKey:@"k1mf010"];
}
-(void)AddressStr:(NSString *)str {
    _inputView.txtStr = str;
     [masterDictone setObject:str forKey:@"k1mf104"];
    
}
-(void)PhoneStr:(NSString *)str {
    self.phoneFile.text = str;
    [masterDictone setObject:str forKey:@"k1mf112"];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[OrderDetailCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    NewModel *model = self.dataArray[indexPath.section];
    _cell.delegate = self;
    [_cell showModelWith:model withDict:self.zongdict withSelfDict:self.datadict withIndex:indexPath.section];
    return _cell;
    
    
}
-(void)getHei:(CGFloat)maxHei withIndex:(NSInteger)index {

    NewModel *model = self.dataArray[index];
    model.bottomHei = maxHei;
    [self.dataArray replaceObjectAtIndex:index withObject:model];
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
     NewModel *model = self.dataArray[indexPath.section];
    if (model.bottomHei == 0) {
        return 80;
    }else{
    return model.bottomHei ;
    }
    
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.dataArray.count;
    
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0://拍照
        {
//            [self takePhoto];
             [self takepic];
        }
            break;
        case 1://从相册选取
        {[self LocalPic];
//            [self LocalPhoto];
            
        }
            break;
        default:
            break;
    }
}

/**
 *  从相册选择
 */
-(void)LocalPic{
    //    [self hiddenAllJumpView];
    if (_images.count <9) {
        
        
        NSArray *availableMedia = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypePhotoLibrary];//Camera所支持的Media格式都有哪些,共有两个分别是@"public.image",@"public.movie"
        
        
        ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
        
        elcPicker.maximumImagesCount = 9-_images.count; //Set the maximum number of images to select to 100
        elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
        elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
        elcPicker.onOrder = YES; //For multiple image selection, display and return order of selected images
        elcPicker.mediaTypes =[NSArray arrayWithObject:availableMedia[0]];//Supports image and movie types
        elcPicker.imagePickerDelegate = self;
        
        [self presentViewController:elcPicker animated:YES completion:nil];
    }else {
        [self Alert:@"您最多只能上传9张图片"];
    }
    
}
/**
 *  拍照
 */
-(void)takepic{
    //    [self hiddenAllJumpView];
    if (_images.count <9) {
        
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        //判断是否有相机
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera]){
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            //设置拍照后的图片可被编辑
            picker.allowsEditing = YES;
            //资源类型为照相机
            picker.sourceType = sourceType;
            [self presentViewController:picker animated:YES completion:nil];
        }else {
            [BGControl creatAlertWithString:@"该设备无摄像头" controller:self autoHiddenTime:0];
        }
    }else {
        [self Alert:@"您最多只能上传9张图片"];
    }
}


#pragma mark - 保存图片
- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        return YES;
    } else {
        return toInterfaceOrientation != UIInterfaceOrientationPortraitUpsideDown;
    }
}

#pragma mark ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    for (UIView *v in [self.bigScrollView subviews]) {
        [v removeFromSuperview];
    }
    //    self.imageStr = [_images componentsJoinedByString:@","];
    NSMutableArray *arr = [NSMutableArray array];
    for (NSInteger i = 0; i< info.count;i++) {
        NSDictionary *dict = info[i];
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto){
            if ([dict objectForKey:UIImagePickerControllerOriginalImage]){
                UIImage* image=[dict objectForKey:UIImagePickerControllerOriginalImage];
                if (_images.count <9) {
                    //                    CGFloat newWiDTH = 300;
                    //                    CGFloat newHeight = 300;
                    //                    if (image.size.width<350) {
                    //                        newWiDTH = image.size.width;
                    //                    }
                    //                    if (image.size.height <500) {
                    //                        newHeight = image.size.height;
                    //                    }
                    
                    //                    UIImage *newImg =[self fitSmallImage:image needwidth:newWiDTH needheight:newHeight];
                    [_images addObject:image];
                    [arr addObject:image];
                }else {
                    [self Alert:@"您最多只能上传9张图片"];
                }
                
            } else {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        
    }
    //    [_imageview removeFromSuperview];
    //    [_imgButton removeFromSuperview];
//    [uploadImagesArr removeAllObjects];
    NSMutableArray *arrOne = [NSMutableArray arrayWithArray:_images];
    for (int i = 0; i<arrOne.count; i++) {
        
        [self uploadPicturewithInsdex:i withArr:arrOne];
        
    }
    
    
}

- (void)creatImgScr {
    
    UIView *BJView = [[UIView alloc] init];
    BJView.tag = 500;
//    BJView.backgroundColor = [UIColor redColor];
    CGRect workingFrame = CGRectMake(self.view.center.x-30, self.view.center.y-30, 60, 60);
    workingFrame.origin.x = 0;
    workingFrame.origin.y = 10;
    CGFloat maxWidth = 0;
    if (uploadImagesArr.count >0) {
        
        
        for (int i = 0; i<uploadImagesArr.count; i++) {
//            UIImage *image = _images[i];
            _imageview = [[UIImageView alloc] init];
            
           
           
            
            NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
            if ([[uploadImagesArr[i] valueForKey:@"type"] isEqualToString:@"old"]) {
                NSString *url = [NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"FileCenter/StoreAttachment/ExportXsmall",@"pict001=",[uploadImagesArr[i] valueForKey:@"systemFileName"],@"imageSize=",30];
                 [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%d",picUrl,@"FileCenter/StoreAttachment/ExportMedium",@"pict001=",[uploadImagesArr[i] valueForKey:@"systemFileName"],@"imageSize=",60]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
            }else {
                
                NSString *url = [NSString stringWithFormat:@"%@%@?%@%@&%@%@&%@%d",picUrl,@"FileCenter/TempFile/ExportImage",@"systemFileName=",[uploadImagesArr[i] valueForKey:@"systemFileName"],@"fileName=",[uploadImagesArr[i] valueForKey:@"fileName"],@"imageSize=",30];
                [_imageview sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@?%@%@&%@%@&%@%d",picUrl,@"FileCenter/TempFile/ExportImage",@"systemFileName=",[uploadImagesArr[i] valueForKey:@"systemFileName"],@"fileName=",[uploadImagesArr[i] valueForKey:@"fileName"],@"imageSize=",60]] placeholderImage:[UIImage imageNamed:@"icon_moren(1).png"]];
            }
           
            _imageview.tag = 200+i;
//            _imageview.backgroundColor = kTextGrayColor;
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
        [self.bigScrollView setContentSize:CGSizeMake(uploadImagesArr.count*60+(uploadImagesArr.count-1)*5 +65, workingFrame.size.height)];
        BJView.frame = CGRectMake(0, 0, uploadImagesArr.count*60+(uploadImagesArr.count-1)*5, 80);
    }
    self.HeadImg.frame = CGRectMake(CGRectGetMaxX(BJView.frame)+5, 10, 60, 60);
    [self.bigScrollView addSubview:self.HeadImg];
//    self.bigScrollView.backgroundColor = kTabBarColor;
    [self.bigScrollView addSubview:BJView];
}




- (void)deletImg:(UIButton *)button {
    _viewTag = button.tag - 100;
    _array =  [NSMutableArray arrayWithArray:_images];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    kantuViewController *picVC = [storyboard instantiateViewControllerWithIdentifier:@"kantuViewController"];
    picVC.IMGArray = uploadImagesArr;
    picVC.delegate =self;
    picVC.IMGNum = [NSString stringWithFormat:@"%d",_viewTag];
    [self.navigationController pushViewController:picVC animated:YES];
}









/**
 *  从相册选择图片
 *
 *  @param picker 相册选择器 v                                                      egbvghvvc     gb
 *  @param info   选择的图片信息
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [_images addObject:image];
//    [uploadImagesArr removeAllObjects];
    NSMutableArray *arr = [NSMutableArray arrayWithArray:_images];
    for (int i = 0; i<arr.count; i++) {
        [self uploadPicturewithInsdex:i withArr:arr];
       
    }
    
//    [self saveImage:image withName:@"headPic.png"];
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"headPic.png"];
    NSLog(@"%@",NSHomeDirectory());
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
//    ischange=@"2";
//    [self.picImg setImage:savedImage];
//    self.headImg.userInteractionEnabled = YES;
//    self.headImg.contentMode = UIViewContentModeScaleAspectFill;
//    self.headImg.autoresizingMask = UIViewAutoresizingNone;
//    self.headImg.clipsToBounds = YES;
}

/**
 *  从document取得图片
 *
 *  @param urlStr 图片地址
 *
 *  @return 返回拼接好的图片路径
 */
- (UIImage *)getImage:(NSString *)urlStr
{
    return [UIImage imageWithContentsOfFile:urlStr];
}

/**
 *将图片路径提交后台
 */
-(void)uploadPicturewithInsdex:(NSInteger )index withArr:(NSMutableArray *)arry{
    [self show];
    uploadImagesArr = [NSMutableArray new] ;
    for (int i = 0 ; i< oldImgArr.count; i++) {
        NSDictionary *dict = oldImgArr[i];
        [uploadImagesArr addObject:dict];
    }
    NSMutableArray *arr = [NSMutableArray arrayWithArray:arry];
    [_images removeAllObjects];
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"chuan.png"];
    // 获取沙盒目录
    NSData *imageData = UIImageJPEGRepresentation(arr[index], 0.5);
    NSString *str=fullPath;
    [imageData writeToFile:fullPath atomically:NO];
   [[AFClient shareInstance] postFile:str withArr:postOneArr progressBlock:^(NSProgress *progress) {
       
   } success:^(id responseBody) {
       
       if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
           NSMutableDictionary *dict = [responseBody valueForKey:@"data"] ;
           [dict setValue:@"now" forKey:@"type"];
           
           [uploadImagesArr addObject:dict];
           oldImgArr = [NSMutableArray new];
           oldImgArr = uploadImagesArr;
           for (UIView *v in [self.bigScrollView subviews]) {
               [v removeFromSuperview];
           }
           [self creatImgScr];
           
       }else {
           NSString *str = [responseBody valueForKey:@"errors"][0];
//           [_images removeObjectAtIndex:index];
           [self Alert:str];

       }
       [self dismiss];
   } failure:^(NSError *error) {
       [self Alert:@"上传附件失败"];
       [self creatImgScr];
//       [arr removeObjectAtIndex:index];
       [self dismiss];
   }];
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)textViewDidChange:(UITextView *)textView {
    //获得textView的初始尺寸
//    CGFloat width = CGRectGetWidth(self.addressFile.frame);
//    CGFloat height = CGRectGetHeight(self.addressFile.frame);
//    CGSize newSize = [self.addressFile sizeThatFits:CGSizeMake(width,MAXFLOAT)];
//    CGRect newFrame = self.addressFile.frame;
//    newFrame.size = CGSizeMake(fmax(width, newSize.width), fmax(height, newSize.height));
//    self.addressFile.frame= newFrame;
//    
//    CGRect addressFrame = self.AddressView.frame;
//    addressFrame.size.height = newFrame.size.height;
//    [self.AddressView setFrame:addressFrame];
//    self.AddressView.backgroundColor = kTabBarColor;
//    CGRect xiaFrame = self.xiaView.frame;
//    xiaFrame.origin.y = CGRectGetMaxY(self.AddressView.frame);
//    [self.xiaView setFrame:xiaFrame];
//    
//     self.topview.frame = CGRectMake(0, 0, kScreenSize.width, CGRectGetMaxY(self.xiaView.frame));
//    [self.bigTableVIew setTableHeaderView:self.topview];
//    [self contentSizeToFit];
}
    


-(BOOL)textFieldShouldReturn:(UITextField*)textField{
    [masterDictone setObject:self.nameFile.text forKey:@"k1mf113"];
     [masterDictone setObject:self.phoneFile.text forKey:@"k1mf112"];
     [masterDictone setObject:self.addressFile.text forKey:@"k1mf104"];
    [self.phoneFile resignFirstResponder];
    
    [self.nameFile resignFirstResponder];
    return YES;
}
-(void)textViewDidEndEditing:(UITextView *)textView {
  [_inputView resignFirstResponder];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text

{
    
    if ([@"\n" isEqualToString:text] == YES)
        
    {
        
        [_inputView resignFirstResponder];
        
        
        
        
        
        return NO;
        
    }
    
    
    
    return YES;
    
}

-(void)postTageArr:(NSArray *)arr {
    chongArr = [NSMutableArray arrayWithArray:arr];
    isShan = @"2";
}
- (void)Alert:(NSString *)AlertStr{
    [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
    
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
