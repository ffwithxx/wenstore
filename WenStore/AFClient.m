 //
//  AFClient.m
//  noteMan
//
//  Created by 周博 on 16/12/12.
//  Copyright © 2016年 BogoZhou. All rights reserved.
//

#import "AFClient.h"
#import "BGControl.h"
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"
#import <AVFoundation/AVFoundation.h>
@interface AFClient ()
{
    NSString *_url;
    NSDictionary *_dict;
    NSString *idStr;
    NSURL  *_filePathURL;
    NSString * _fileName;
    NSProgress *_progressone;
    NSString *kIPurl;
   
  
}
@end

@implementation AFClient


+(instancetype)shareInstance{
    static AFClient *defineAFClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        defineAFClient = [[AFClient alloc] init];
    });
    return defineAFClient;
}

- (NSData *)resetSizeOfImageData:(UIImage *)source_image maxSize:(NSInteger)maxSize
{
    //先调整分辨率
    CGSize newSize = CGSizeMake(source_image.size.width, source_image.size.height);
    
    CGFloat tempHeight = newSize.height / 1024;
    CGFloat tempWidth = newSize.width / 1024;
    
    if (tempWidth > 1.0 && tempWidth > tempHeight) {
        newSize = CGSizeMake(source_image.size.width / tempWidth, source_image.size.height / tempWidth);
    }
    else if (tempHeight > 1.0 && tempWidth < tempHeight){
        newSize = CGSizeMake(source_image.size.width / tempHeight, source_image.size.height / tempHeight);
    }
    
    UIGraphicsBeginImageContext(newSize);
    [source_image drawInRect:CGRectMake(0,0,newSize.width,newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    //调整大小
    NSData *imageData = UIImageJPEGRepresentation(newImage,1.0);
    NSUInteger sizeOrigin = [imageData length];
    NSUInteger sizeOriginKB = sizeOrigin / 1024;
    if (sizeOriginKB > maxSize) {
        NSData *finallImageData = UIImageJPEGRepresentation(newImage,0.50);
        return finallImageData;
    }
    
    return imageData;
}

- (AFHTTPSessionManager *)creatManager{
    kIPurl = [[NSUserDefaults standardUserDefaults] valueForKey:@"loginIp"];
    AFHTTPSessionManager* mgr = [AFHTTPSessionManager manager];

//        mgr.requestSerializer = [AFHTTPRequestSerializer serializer];
    AFSecurityPolicy *securityPolicy = [AFSecurityPolicy defaultPolicy];
    //allowInvalidCertificates 是否允许无效证书（也就是自建的证书），默认为NO//如果是需要验证自建证书，需要设置为YES
//    mgr.requestSerializer.timeoutInterval = 60;
    securityPolicy.allowInvalidCertificates = YES;
    [mgr.requestSerializer setValue:KHeader forHTTPHeaderField:@"apptoken"];
    //validatesDomainName 是否需要验证域名，默认为YES；
    securityPolicy.validatesDomainName = NO;
    
    mgr.securityPolicy  = securityPolicy;
    mgr.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    mgr.responseSerializer=[AFHTTPResponseSerializer serializer];
    mgr.requestSerializer.timeoutInterval = 20.f;
    return mgr;
}

- (void)getUserInfoByUserId:(NSString *)Id progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@/v1/user/get",kIPurl];
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [[NSDictionary alloc] initWithObjectsAndKeys:Id,@"id", nil];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(responseObject);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)GetResource:(NSString *)apptoken withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/GetResource",kHttpHeader];
      _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    _dict = [[NSDictionary alloc] init];
   
   
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    if (userResponsed.count>0) {
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    }
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];

     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
            
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
             [[NSUserDefaults standardUserDefaults] setValue:jsonString forKey:@"ResourceData"];
            NSLog(@"%@",dict);
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                 [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
          
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)GetNew:(NSString *)jsob001 withArr:(NSArray *)userResponsed   progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/New",kIPurl];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    if ([BGControl isNULLOfString:jsob001]) {
         _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    }else{
         _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed",jsob001,@"copyK1mf100", nil];
    }
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                if (success) {
                    
                    success(responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];
}
- (void)GetNewWithArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
     _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
   [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    //    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",dict);
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)GetEdit:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/Edit",kHttpHeader];
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
  
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    if ([BGControl isNULLOfString:k1mf100]) {
        _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    }else {
     _dict = [NSDictionary dictionaryWithObjectsAndKeys:k1mf100,@"k1mf100",userResponsed,@"userResponsed", nil];
    }
   
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
             success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)Destroy:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    
 
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:k1mf100,@"k1mf100",userResponsed,@"userResponsed", nil];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cookie"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"cook"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            success(dict);
            NSLog(@"%@",dict);
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

-(void)postValidateCart:(NSMutableDictionary *)mastDict detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr withjsob001:(NSString *)jsob001  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/ValidateCart",kHttpHeader];
      _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
         NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:mastDict,@"master",detailArr,@"detail",uploadImagesArr,@"uploadImages",promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders",userResponsed,@"userResponsed", nil];
    if ([urlStr isEqualToString:@"App/Wbp3011/ValidateCart"]) {
         _dict = [NSDictionary dictionaryWithObjectsAndKeys:mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
    }
    if ([urlStr isEqualToString:@"App/Wbp3003/ValidateCart"] || [urlStr isEqualToString:@"App/Wbp3010/ValidateCart"]|| [urlStr isEqualToString:@"App/Wbp3007/ValidateCart"]|| [urlStr isEqualToString:@"App/Wbp3018/ValidateCart"]|| [urlStr isEqualToString:@"App/Wbp3019/ValidateCart"]|| [urlStr isEqualToString:@"App/Wbp3013/ValidateCart"]) {
        if (![BGControl isNULLOfString:[mastDict valueForKey:@"k1mf100"]]) {
            _dict = [NSDictionary dictionaryWithObjectsAndKeys:mastDict,@"master",[mastDict valueForKey:@"k1mf100"],@"k1mf100",detailArr,@"detail",uploadImagesArr,@"uploadImages",userResponsed,@"userResponsed", nil];
        }else {
            _dict = [NSDictionary dictionaryWithObjectsAndKeys:mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];

        }
        
    }
    if ([urlStr isEqualToString:@"App/Wbp3001/ValidateCart"]) {
        if (![BGControl isNULLOfString:[mastDict valueForKey:@"k1mf100"]]) {
            if ([BGControl isNULLOfString:jsob001]) {
                 _dict = [NSDictionary dictionaryWithObjectsAndKeys:promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders ",mastDict,@"master",[mastDict valueForKey:@"k1mf100"],@"k1mf100",detailArr,@"detail",uploadImagesArr,@"uploadImages",userResponsed,@"userResponsed", nil];
            }else{
                _dict = [NSDictionary dictionaryWithObjectsAndKeys:promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders ",mastDict,@"master",[mastDict valueForKey:@"k1mf100"],@"k1mf100",detailArr,@"detail",uploadImagesArr,@"uploadImages",userResponsed,@"userResponsed",jsob001,@"jsob001", nil];
            }
           
        }else {
            if ([BGControl isNULLOfString:jsob001]) {
                  _dict = [NSDictionary dictionaryWithObjectsAndKeys:promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders ",mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
            }else{
                  _dict = [NSDictionary dictionaryWithObjectsAndKeys:promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders ",mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed",jsob001,@"jsob001", nil];
            }
          
            
        }
    }
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
      [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];

    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                if (success) {
                    
                    success(responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
//                    NSLog(@"%@",dict);
                }

        NSLog(@"%@",responseObject);
    }
        } else {
//        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"%@",dict);
        NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
        
    } }] resume];


}

-(void)postValidateCart:(NSMutableDictionary *)mastDict withIdStr:(NSString *)k1mf001Str detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:k1mf001Str,@"k1mf100", mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
    if ([BGControl isNULLOfString:k1mf001Str]) {
        _dict = [NSDictionary dictionaryWithObjectsAndKeys: mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
    }
    
    if ([urlStr isEqualToString:@"App/Wbp3022/ValidateCart"]) {
        if ([BGControl isNULLOfString:k1mf001Str]) {
            _dict = [NSDictionary dictionaryWithObjectsAndKeys: [mastDict valueForKey:@"k1mf107"],@"supl001",mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
        }else {
         _dict = [NSDictionary dictionaryWithObjectsAndKeys: k1mf001Str,@"k1mf100",[mastDict valueForKey:@"k1mf107"],@"supl001",mastDict,@"master",detailArr,@"detail",userResponsed,@"userResponsed", nil];
        }

    }
    
       manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                
                if (success) {
                    
                    success(responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];
    

}

-(void)postValidateCartone:(NSMutableDictionary *)mastDict detail:(NSMutableArray *)detailArr uploadImages:(NSMutableArray *)uploadImagesArr promoOrders:(NSMutableArray *)promoOrdersArr freeOrders:(NSMutableArray *)freeOrdersArr withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
  
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:[mastDict valueForKey:@"k1mf100"],@"k1mf100",detailArr,@"detail",uploadImagesArr,@"uploadImages",promoOrdersArr,@"promoOrders",freeOrdersArr,@"freeOrders",userResponsed,@"userResponsed", nil];
    
    if ([urlStr isEqualToString:@"App/Wbp3011/ValidateCart"]) {
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:[mastDict valueForKey:@"k1mf100"],@"k1mf100",detailArr,@"detail",userResponsed,@"userResponsed",uploadImagesArr,@"uploadImages", nil];
    }
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
   NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:_dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                        NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];
    

}
- (void)Create:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/Create",kHttpHeader];
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
     NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    [dict setObject:userResponsed forKey:@"userResponsed"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(responseObject);
            }
            
        } }] resume];

}
- (void)Update:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/Update",kHttpHeader];
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
   [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    if (userResponsed.count >0 ) {
        [dict setObject:userResponsed forKey:@"userResponsed"];
    }
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(responseObject);
            }
            
        } }] resume];

}
- (void)OnePage:(NSMutableDictionary *)dict withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
//    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/OnePage",kHttpHeader];
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;
    [dict setObject:userResponsed forKey:@"userResponsed"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                    success(responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    
                  
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];
}
- (void)LoginByCustId:(NSString *)custId withUrl:(NSString *)urlStr withAccount:(NSString *)account withPassword:(NSString *)password withStoreId:(NSString *)storeId isShow:(BOOL)isShow withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
  
      NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSLog(@"%@",_url);
    if (isShow) {
          _dict = [NSDictionary dictionaryWithObjectsAndKeys:custId,@"custId",account,@"account",password,@"password",storeId,@"storeId",userResponsed,@"userResponsed", nil];
    }else {
        _dict = [NSDictionary dictionaryWithObjectsAndKeys:account,@"account",password,@"password",storeId,@"storeId",userResponsed,@"userResponsed", nil];
    }
  

    AFHTTPSessionManager *manager = [self creatManager];
  
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    [manager.requestSerializer  setValue:@"application/json"  forHTTPHeaderField:@"Content－Type"];
  [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
 //[manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager POST:urlStr parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        NSString *str=[[NSString alloc]initWithData:responseObject encoding:NSUTF8StringEncoding];
        if (success) {
            success(dict);
//             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }

            NSError *error;
            NSString *jsonString = [[NSString alloc] initWithData:responseObject encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
//            NSArray *cookies = [[NSHTTPCookieStorage sharedHTTPCookieStorage]cookies];
//            
//            NSString *signature = @"";
//            NSString *userId = @"";
//            NSString *JSESSIONID = @"";ni
//            for (NSHTTPCookie *cookie in cookies) {
//                if ([cookie.name isEqualToString:@"JSESSIONID"]) {
//                    JSESSIONID = cookie.value;
//                }
//                if ([cookie.name isEqualToString:@"signature"]) {
//                    signature = cookie.value;
//                }
//                if ([cookie.name isEqualToString:@"userId"]) {
//                    userId = cookie.value;
//                }
//            }
//            NSString *cookieStr = [NSString stringWithFormat:@"JSESSIONID=%@;signature=%@;userId=%@",JSESSIONID,signature,userId];
            
            
            NSLog(@"%@",dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];


}

- (void)loginOutwith:(NSArray *)userResponsed   progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@/App/WebPosAppLogin/Destroy",kIPurl];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
   [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];

    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];

        if (success) {
            
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)All:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/App/WebPosAppTodo/All",kIPurl];
    AFHTTPSessionManager *manager = [self creatManager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
      [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    _dict = [NSDictionary dictionaryWithObjectsAndKeys:userResponsed,@"userResponsed", nil];
    [manager POST:_url parameters:_dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
                        // 获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
-(void)SalesForecastWith:(NSDictionary *)dict withArr:(NSArray *)userResponsed progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
    _url = [NSString stringWithFormat:@"%@/App/Wbp3001/SalesForecast",kIPurl];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
      [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}

/* 3008*/
- (void)WBP3008Approve:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
      [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1mf100,@"k1mf100", nil];
   
    
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)WBP3008Preview:(NSString *)k1mf100 withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    
  _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
   
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1mf100,@"k1mf100", nil];
 
    NSNumber *appNum = [NSNumber numberWithInt:1];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid",@"1",@"newapp", nil];
    NSError *error;
   // [dict setObject:userResponsed forKey:@"userResponsed"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                   success(responseObject);
                    NSLog(@"%@",responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];


}
- (void)postFile:(NSString *)file withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure{
       NSString *picUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    _url =[NSString stringWithFormat:@"%@%@",picUrl,@"/FileCenter/TempFile/UploadImage"];
 
    UIImage *img = [UIImage imageWithContentsOfFile:file];
    AFHTTPSessionManager *manager = [self creatManager];
    manager.requestSerializer=[AFHTTPRequestSerializer serializer];
    
    manager.responseSerializer=[AFHTTPResponseSerializer serializer];
    manager.requestSerializer.timeoutInterval = 20.f;
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMddHHmmss";
    NSString *str = [formatter stringFromDate:[NSDate date]];
    NSString *fileName = [NSString stringWithFormat:@"%@.jpg", str];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
   [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        [formData appendPartWithFileData:[self resetSizeOfImageData:img maxSize:50] name:@"file" fileName:fileName mimeType:@"image/jpg"];
        NSLog(@"123");
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        if (success) {
            NSLog(@"%@",_url);
            NSLog(@"%@",dict[@"data"]);
            success(dict);
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];;

}


- (void)Divert:(NSString *)k1mf100  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1mf100,@"k1mf100",@"2",@"k1mf930", nil];
    
    
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)UpdateState:(NSMutableDictionary *)dict  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    NSString *fileCenterUrl = [[NSUserDefaults standardUserDefaults] valueForKey:@"fileCenterUrl"];
    _url = [NSString stringWithFormat:@"%@/%@",fileCenterUrl,urlStr];
    
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid", nil];
    NSError *error;

    [dict setObject:userResponsed forKey:@"userResponsed"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                    //                    NSLog(@"%@",dict);
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            //        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
            //        NSLog(@"%@",dict);
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];

}

- (void)NewSendReport:(NSString *)k1mf100  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
     [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1mf100,@"k1mf100",userResponsed,@"userResponsed", nil];
    
    
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            NSLog(@"fields = %@", [fields description]);
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
- (void)SendReport:(NSString *)k1mf100 withDic:(NSMutableDictionary *)dic  withArr:(NSArray *)userResponsed withUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    NSLog(@"%@",_url);
    AFHTTPSessionManager *manager = [self creatManager];
    
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/xml", @"text/xml",@"text/html",@"text/plain",@"application/json", nil];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSDictionary  *hear = [NSDictionary dictionaryWithObjectsAndKeys:token,@"apptoken",cookie,@"Cookie",appcustid,@"appcustid",@"1",@"newapp", nil];
    NSError *error;
    [dic setObject:userResponsed forKey:@"userResponsed"];
    [dic setObject:k1mf100 forKey:@"k1mf100"];
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:&error];
    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    AFURLSessionManager *manager1 = [[AFURLSessionManager alloc] initWithSessionConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSMutableURLRequest *req = [[AFJSONRequestSerializer serializer] requestWithMethod:@"POST" URLString:_url parameters:nil error:nil];
    req.timeoutInterval= [[[NSUserDefaults standardUserDefaults] valueForKey:@"timeoutInterval"] longValue];
    [req setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [req setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [req setHTTPBody:[jsonString dataUsingEncoding:NSUTF8StringEncoding]];
    [req setAllHTTPHeaderFields:hear];
    [[manager1 dataTaskWithRequest:req completionHandler:^(NSURLResponse * _Nonnull response, id _Nullable responseObject, NSError * _Nullable error) {
        
        if (!error) { NSLog(@"Reply JSON: %@", responseObject);
            
            if ([responseObject isKindOfClass:[NSDictionary class]]) {
                if (success) {
                    success(responseObject);
                    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:0 error:&error];
                    NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
                    //             获取所有数据报头信息
                    NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)response;
                    NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
                    NSLog(@"fields = %@", [fields description]);
                    // 获取cookie方法1
                    NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
                    if (![BGControl isNULLOfString:cookieString]) {
                        [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
                    }
                    
                }
                
                NSLog(@"%@",responseObject);
            }
        } else {
            NSLog(@"Error: %@, %@, %@", error, response, responseObject);
            if (failure) {
                failure(error);
            }
            
        } }] resume];

}

- (void)CheckHostStatuswithUrl:(NSString *)urlStr  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
   
    AFHTTPSessionManager *manager = [self creatManager];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:urlStr parameters:nil progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            NSLog(@"fields = %@", [fields description]);
            success(dict);
          
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

    
}
- (void)UpdatePasswordwithUrl:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
     _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
      [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:dataDict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
- (void)GetNewswithUrl:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:dataDict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
    
}
- (void)Masgetpay:(NSString *)urlStr withDict:(NSDictionary *)dataDict  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,urlStr];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    [manager POST:_url parameters:dataDict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            NSLog(@"fields = %@", [fields description]);
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
            
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}

- (void)OrderableRemind:(NSString *)k1dt001Str withArr:(NSArray *)userResponsed  progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,@"App/Wbp3001/OrderableRemind"];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1dt001Str,@"k1dt001",userResponsed,@"userResponsed", nil];
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];

}
//付款
- (void)GetPaymentResrouce:(NSString *)k1mf100 progressBlock:(ProgressBlock)progress success:(SuccessBlock)success failure:(FailureBlcok)failure {
    _url = [NSString stringWithFormat:@"%@/%@",kIPurl,@"App/Wbp3001/GetPaymentResource"];
    AFHTTPSessionManager *manager = [self creatManager];
    NSString *cookie = [[NSUserDefaults standardUserDefaults] valueForKey:@"cook"];
    NSString *token = [[NSUserDefaults standardUserDefaults]valueForKey:@"token"];
    NSString *appcustid = [[NSUserDefaults standardUserDefaults]valueForKey:@"appcustid"];
    [manager.requestSerializer setValue:token forHTTPHeaderField:@"apptoken"];
    [manager.requestSerializer setValue:cookie forHTTPHeaderField:@"Cookie"];
    [manager.requestSerializer setValue:appcustid forHTTPHeaderField:@"appcustid"];
    [manager.requestSerializer setValue:@"1" forHTTPHeaderField:@"newapp"];
    NSMutableDictionary *dict = [[NSMutableDictionary alloc] initWithObjectsAndKeys:k1mf100,@"k1mf100", nil];
    [manager POST:_url parameters:dict progress:^(NSProgress * _Nonnull uploadProgress) {
        if (progress) {
            progress(uploadProgress);
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
        
        if (success) {
            //             获取所有数据报头信息
            NSHTTPURLResponse *HTTPResponse = (NSHTTPURLResponse *)task.response;
            NSDictionary *fields = [HTTPResponse allHeaderFields];// 原生NSURLConnection写法
            // 获取cookie方法1
            NSString *cookieString = [[HTTPResponse allHeaderFields] valueForKey:@"Set-Cookie"];
            if (![BGControl isNULLOfString:cookieString]) {
                [[NSUserDefaults standardUserDefaults] setObject:cookieString forKey:@"cook"];
            }
            success(dict);
            NSError *error;
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:0 error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            NSLog(@"%@",jsonString);
            
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}
@end
