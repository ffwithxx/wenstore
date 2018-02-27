//
//  DetailVC.m
//  WenStore
//
//  Created by 冯丽 on 17/9/21.
//  Copyright © 2017年 chenghong. All rights reserved.
//

#import "DetailVC.h"
#import "DetailVCCell.h"
#import "BGControl.h"
#import "AddressListVC.h"
#import "RemarkVC.h"
#import "OrderTwoVC.h"
#import "PayViewController.h"
#import "AFClient.h"
#import "orderModel.h"
#import "EditModel.h"
#import "CallOrderThreeVC.h"
#import "CallOrderFourVC.h"

#import "SZCalendarPicker.h"

#import "BGControl.h"
#import "ELCImagePickerHeader.h"
#import "kantuViewController.h"
#define kCellName @"DetailVCCell"
@interface DetailVC ()<RemarkDelegate,UITableViewDelegate,UITableViewDataSource,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextFieldDelegate,UITextViewDelegate,ELCImagePickerControllerDelegate,postArrDelegate,UIScrollViewDelegate> {
    DetailVCCell *_cell;
    NSMutableDictionary *dataDict;
    NSMutableArray *selfArr;
    NSInteger lpdt042;
    NSInteger lpdt043;
     NSInteger lpdt036;
    NSMutableArray *postArr;
    NSMutableArray *postOneArr;
    NSDecimalNumber *postPrice;
    NSDate *tuihuiDate;
    NSString *remarkStr;
    BOOL isConfirm;
    
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
    NSMutableArray *uploadImagesArr;
    NSMutableArray *oneArr;
    NSMutableArray *oldImgArr;
    NSMutableArray *updateArr;
}

@end

@implementation DetailVC

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
        
    }
    
}



- (void)viewDidLoad {
    [super viewDidLoad];
    [self firstTwo];
    dataDict = [NSMutableDictionary new];
    self.dataArray = [NSMutableArray new];
    updateArr = [NSMutableArray new];
    postArr = [NSMutableArray new];
    postOneArr = [NSMutableArray array];
    lpdt043 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt043"] ] integerValue];
    lpdt036 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt036"] ] integerValue];
    lpdt042 = [[NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] valueForKey:@"3011lpdt042"] ] integerValue];
    self.headView.frame = CGRectMake(0, 0, kScreenSize.width, 210);
    [self.bigTableView setTableHeaderView:self.headView];
    self.footerView.frame = CGRectMake(0, 0, kScreenSize.width, 50);
    [self.bigTableView setTableFooterView:self.footerView];
    self.bigTableView.showsVerticalScrollIndicator = NO;
    self.bigTableView.separatorStyle = UITableViewCellSelectionStyleNone;
     isShan = @"1";
    uploadImagesArr = [NSMutableArray array];
    oldImgArr = [NSMutableArray array];
    NSArray *ImgArr = [self.datDict valueForKey:@"uploadImages"];
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
    [self first];
}
-(void)firstTwo {
    
    _images = [NSMutableArray array];
    _array = [NSMutableArray new];
    _imageview = [UIImageView new];
    posImgArr = [NSMutableArray new];
    getArr = [NSMutableArray new];
    NSString *jsonString = [[NSUserDefaults standardUserDefaults]valueForKey:@"ResourceData"];
    NSDictionary *resourceDict = [BGControl dictionaryWithJsonString:jsonString];
    NSArray *visiableFieldsArr = [[resourceDict valueForKey:@"data"] valueForKey:@"visiableFields"];
    BOOL isPrice = false;
    for (int i = 0; i < visiableFieldsArr.count; i++) {
        NSString *visiableFieldsStr = visiableFieldsArr[i];
        if ([visiableFieldsStr isEqualToString:@"K1MF302"]) {
            isPrice = true;
        }
        
    }
    
    if (!isPrice) {
        self.yunLab.hidden = YES;
    }else{
        self.yunLab.hidden = NO;
    }
}

-(void)first {
    
     NSDictionary *masterDict = [self.datDict valueForKey:@"master"];
     NSString *zongpriceStr = [BGControl notRounding:[masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043];
    
    remarkStr = [masterDict valueForKey:@"k1mf010"];
    
  
    NSString *countStr = [NSString stringWithFormat:@"%@",  [BGControl notRounding:[masterDict valueForKey:@"k1mf303"] afterPoint:lpdt036]];
    self.sumCountLab.text = [NSString stringWithFormat:@"%@%@%@",@"退回",countStr,@"件商品"];
    NSArray *time = [[BGControl dateToDateStringTwo:[masterDict valueForKey:@"k1mf003"]] componentsSeparatedByString:@" "];
     self.tuihuoDateFile.text =time[0];
    tuihuiDate = [masterDict valueForKey:@"k1mf003"];
    self.beiLab.text = [masterDict valueForKey:@"k1mf010"];
     oneArr = [[NSMutableArray alloc] init];
    if ([self.typeStr isEqualToString:@"2"]) {
        NSArray *dataArr = [self.datDict valueForKey:@"groupDetail"];
        for (int i = 0; i<dataArr.count; i++) {
            
            NSArray *dictDetail = [dataArr[i] valueForKey:@"detail"];
            for (int j = 0; j<dictDetail.count; j++) {
                EditModel *model  = [EditModel new];
                NSDictionary *dictOne = dictDetail[j];
                [oneArr addObject:dictOne];
            }
        }
    }else{
   oneArr = [self.datDict valueForKey:@"detail"];
    }
    
    NSDecimalNumber *priceNum = [NSDecimalNumber decimalNumberWithString:@"0"];
    for (int i = 0; i<oneArr.count; i++) {
        EditModel *model = [EditModel new];
        NSDictionary *dict = oneArr[i];
        
        [model setValuesForKeysWithDictionary:dict];
        NSDecimalNumber *one = [[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt201 afterPoint:lpdt042]] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:[BGControl notRounding:model.k1dt101 afterPoint:lpdt036]]];
        NSDecimalNumber *two = [NSDecimalNumber decimalNumberWithString:[BGControl notRounding:one afterPoint:lpdt043]];
        priceNum =[priceNum decimalNumberByAdding:two];
        if (![[NSString stringWithFormat:@"%@",model.k1dt101] isEqualToString:@"0"]) {
            [self.dataArray addObject:model];
            [updateArr addObject:dict];
        }
        
        
        
    }
   
        self.yunLab.text =[NSString stringWithFormat:@"%@%@",@"总计: ￥",  [BGControl notRounding: [masterDict valueForKey:@"k1mf302"] afterPoint:lpdt043]];
    NSMutableAttributedString *priceStr = [[NSMutableAttributedString alloc] initWithString:self.yunLab.text];
    NSInteger pricelenght = priceStr.length;
    [priceStr addAttribute:NSForegroundColorAttributeName value:kBlackTextColor range:NSMakeRange(0, 5)];
    [priceStr addAttribute:NSForegroundColorAttributeName value:kredColor range:NSMakeRange(4,pricelenght-5)];
    self.yunLab.attributedText = priceStr;
    postPrice = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%@",priceNum]];
  [self.bigTableView reloadData];
    
}
- (IBAction)buttonClick:(UIButton *)sender {
     UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    //201返回
    if (sender.tag == 201) {
        [self.navigationController popViewControllerAnimated:YES];
    }else if (sender.tag == 205) {
        isConfirm = false;
        [self update];
    }
    else if (sender.tag == 202) {
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
            self.tuihuoDateFile.text = [NSString stringWithFormat:@"%@-%@-%@", yearStr,monthStr,dayStr];
            
            tuihuiDate = [BGControl stringToDate:self.tuihuoDateFile.text];
            
        };

    }else if (sender.tag == 203){
        //配送备注
        RemarkVC *remark = [storyboard instantiateViewControllerWithIdentifier:@"RemarkVC"];
        remark.delegate = self;
        [self.navigationController pushViewController:remark animated:YES];
    }else if (sender.tag == 206) {
        isConfirm = true;
        [self update];
    }else if (sender.tag == 204){
        //转账凭证
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选取", nil];
        [sheet showInView:self.view];

    }
    NSLog( @"%@",self.datDict);
    //202退货日期
    
    //203备注
    //204图片
    //205保存
    //206确定
    
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



-(void)RemarkStr:(NSString *)str {
    self.beiLab.text = str;
    remarkStr = str;
}
-(void)update{
    NSMutableDictionary *masterDict = [self.datDict valueForKey:@"master"];
    NSMutableDictionary *postMast = [[NSMutableDictionary alloc] init];
     [postMast setValue:[masterDict valueForKey:@"k1mf000"] forKey:@"k1mf000"];
     [postMast setValue:[masterDict valueForKey:@"k1mf001"] forKey:@"k1mf001"];
     [postMast setValue:self.tuihuoDateFile.text forKey:@"k1mf003"];
     [postMast setValue:[masterDict valueForKey:@"k1mf005"] forKey:@"k1mf005"];
     [postMast setValue:[masterDict valueForKey:@"k1mf006"] forKey:@"k1mf006"];
     [postMast setValue:[masterDict valueForKey:@"k1mf008"] forKey:@"k1mf008"];
     [postMast setValue:remarkStr forKey:@"k1mf010"];
     [postMast setValue:[masterDict valueForKey:@"k1mf011"] forKey:@"k1mf011"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf100"] forKey:@"k1mf100"];
    [postMast setValue:[masterDict valueForKey:@"k1mf109"] forKey:@"k1mf109"];
    [postMast setValue:postPrice forKey:@"k1mf302"];
    [postMast setValue:[masterDict valueForKey:@"k1mf303"] forKey:@"k1mf303"];
    [postMast setValue:[masterDict valueForKey:@"k1mf500"] forKey:@"k1mf500"];
    [postMast setValue:[masterDict valueForKey:@"k1mf600"] forKey:@"k1mf600"];
    [postMast setValue:[masterDict valueForKey:@"k1mf800"] forKey:@"k1mf800"];
    
    [postMast setValue:[masterDict valueForKey:@"k1mf998"] forKey:@"k1mf998"];
    [postMast setValue:[masterDict valueForKey:@"k1mf999"] forKey:@"k1mf999"];
    
     NSMutableDictionary  *updateDict = [[NSMutableDictionary alloc] init];

    [updateDict setObject:postMast forKey:@"master"];
    if (uploadImagesArr.count >0) {
        [updateDict setObject:uploadImagesArr forKey:@"uploadImages"];
    }
    
    [updateDict setObject:updateArr forKey:@"detail"];
    NSNumber *isconfirmNum = [NSNumber numberWithBool:isConfirm];
     [updateDict setObject:isconfirmNum forKey:@"isConfirm"];
    [self show];
    NSString *urlStr;
    if ([self.typeStr isEqualToString:@"four"]) {
          if (isConfirm == true) {
        urlStr = @"App/Wbp3011/UpdateAndConfirm";
          }else{
             urlStr = @"App/Wbp3011/Update";
          }
    }else if ([self.typeStr isEqualToString:@"fourNew"]){
        if (isConfirm == true) {
              urlStr = @"App/Wbp3011/CreateAndConfirm";
        }else {
        urlStr = @"App/Wbp3011/Create";
        }
  
    }
    
    else {
     urlStr = @"App/Wbp3011/UpdateAndConfirm";
    }
    [[AFClient shareInstance] Update:updateDict withArr:postOneArr withUrl:urlStr  progressBlock:^(NSProgress *progress) {
        
    } success:^(id responseBody) {
        [self dismiss];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        if ([[responseBody valueForKey:@"status"] integerValue] == 200) {
            NSDictionary *userResponseDict = [[responseBody valueForKey:@"data"] valueForKey:@"userResponse"];
            if ([BGControl isNULLOfString:[userResponseDict valueForKey:@"code"]] ) {
                [self Alert:[[responseBody valueForKey:@"data"] valueForKey:@"message"]];
                 CallOrderFourVC *callOrderfour = [storyboard instantiateViewControllerWithIdentifier:@"CallOrderFourVC"];
                callOrderfour.reasonsArr = self.reasonsArr;
                if ([self.typeStr isEqualToString:@"four"] ||[self.typeStr isEqualToString:@"fourNew"]) {
                    
                 [self.navigationController pushViewController:callOrderfour animated:YES];
                }else {
                 [self.navigationController pushViewController:callOrderfour animated:YES];
                }
               

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
                        [self update];
                        ;
                    }];
                    [alertController addAction:confirmAction];
                    
                }else if ([[userResponseDict valueForKey:@"code"] intValue]== 2) {
                    NSArray *options = [userResponseDict valueForKey:@"options" ];
                    for (int i = 0; i < options.count; i++) {
                        UIAlertAction *home1Action = [UIAlertAction actionWithTitle:[options[i] valueForKey:@"text"] style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) { //TODO:
                            [postOneArr removeAllObjects];
                            [postOneArr addObject:[NSString stringWithFormat:@"%@%@%@",[userResponseDict valueForKey:@"responseFlag"],@"_",[options[i] valueForKey:@"value"]]];
                            [self update];
                            
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    _cell = [tableView dequeueReusableCellWithIdentifier:kCellName];
    if (!_cell) {
        _cell = [[DetailVCCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:kCellName];
    }
    //    XyModel *model = self.dataArray[indexPath.row];
    CGRect cellFrame = _cell.contentView.frame;
    cellFrame.size.width = kScreenSize.width;
    [_cell.contentView setFrame:cellFrame];
    EditModel *model = self.dataArray[indexPath.section];
    
    [_cell showModel:model];
    return _cell;
    
    
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
//    return self.topview;
//}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    NewModel *model = self.dataArray[indexPath.section];
    return 80;
    
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
-(void)postTageArr:(NSArray *)arr {
    chongArr = [NSMutableArray arrayWithArray:arr];
    isShan = @"2";
}

- (void)Alert:(NSString *)AlertStr{
     [LYMessageToast toastWithText:AlertStr backgroundColor:[UIColor blackColor] font:[UIFont systemFontOfSize:15] fontColor:[UIColor whiteColor] duration:2.f inView:self.view];
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
