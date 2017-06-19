//
//  WKHttpTool.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpTool.h"
#import "WKHttpmanager.h"
#import "WKTeacherData.h"
@interface WKHttpTool  () <UIAlertViewDelegate,NSURLSessionDataDelegate,NSURLSessionDelegate,NSURLSessionTaskDelegate>

@end
@implementation WKHttpTool
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    switch (buttonIndex) {
            case 0:
            NSLog(@"0000");
            break;
            case 1:
        {
            NSLog(@"1111");
            if ([[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]]) {
                NSLog(@"2222");
                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }
//            [[UIApplication sharedApplication]canOpenURL:[NSURL URLWithString:@"prefs:root=General"]];
//            
        }
            break;
        default:
            break;
    }
}
+(void)getWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))Success failure:(void (^)(NSError *))Failure{
    [[WKHttpmanager shareWKHttpmanager]GET:URLString parameters:parameters progress:^(NSProgress * _Nonnull downloadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
    
    }
+(void)postWithURLString:(NSString *)URLString parameters:(id)parameters success:(void (^)(id))Success failure:(void (^)(NSError *))Failure
{
    
    //[WKHttpmanager shareWKHttpmanager].requestSerializer = [AFJSONRequestSerializer serializer];
    //[WKHttpmanager shareWKHttpmanager].responseSerializer = [AFHTTPResponseSerializer serializer];
    [[WKHttpmanager shareWKHttpmanager]POST:URLString parameters:parameters progress:^(NSProgress * _Nonnull uploadProgress) {
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
//    [[WKHttpmanager shareWKHttpmanager]POST:URLString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
//        
//    } progress:^(NSProgress * _Nonnull uploadProgress) {
//        
//    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        Success(responseObject);
//        
//    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        Failure(error);
//    }];
}
+(void)uploadWithURLString:(NSString *)URLString parameters:(NSDictionary*)dic images:(UIImage*)Imag success:(void (^)(id))Success failure:(void (^)(NSError *))Failure upload:(void(^)(NSProgress *progress))UploadProgress{
    NSString *string1;
    for (int i=0; i<dic.allKeys.count; i++) {
        string1 = [NSString stringWithFormat:@"%@=%@",dic.allKeys[i],[dic objectForKey:dic.allKeys[i]]];

    }
    
    NSString *url = [NSString stringWithFormat:@"%@?%@",URLString,string1];
    [WKHttpmanager shareWKHttpmanager].requestSerializer.timeoutInterval = 60;
    [[WKHttpmanager shareWKHttpmanager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        NSData *fileData =UIImagePNGRepresentation(Imag);
        
        // 设置上传图片的名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        
        [formData appendPartWithFileData:fileData name:@"image" fileName:fileName mimeType:@"image/png"];
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        UploadProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
         Success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
         Failure(error);
    }];
}
+(void)uploadVideoWithURLString:(NSString *)URLString parameters:(NSDictionary*)dic images:(UIImage*)Imag date:(id)Date success:(void (^)(id))Success failure:(void (^)(NSError *))Failure  upload:(void(^)(NSProgress *progress))UploadProgress{
    NSString *string1;
    for (int i=0; i<dic.allKeys.count; i++) {
        string1 = [NSString stringWithFormat:@"%@=%@",dic.allKeys[i],[dic objectForKey:dic.allKeys[i]]];
        
    }
    
    NSString *url = [NSString stringWithFormat:@"%@?%@",URLString,string1];
    [WKHttpmanager shareWKHttpmanager].requestSerializer.timeoutInterval = 1000;
    [[WKHttpmanager shareWKHttpmanager] POST:url parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        //NSData *fileData =UIImagePNGRepresentation(Imag);
        
        // 设置上传图片的名字
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        formatter.dateFormat = @"yyyyMMddHHmmss";
        NSString *str = [formatter stringFromDate:[NSDate date]];
        //NSString *fileName = [NSString stringWithFormat:@"%@.png", str];
        NSString *fileNameVideo = [NSString stringWithFormat:@"%@.MOV",str];
//        [formData appendPartWithFileData:fileData name:@"image" fileName:fileName mimeType:@"image/png"];
        [formData appendPartWithFileData:Date name:@"Video" fileName:fileNameVideo mimeType:@"Video/MOV"];

    } progress:^(NSProgress * _Nonnull uploadProgress) {
        UploadProgress(uploadProgress);
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        Success(responseObject);
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        Failure(error);
    }];
}

-(void)AFNetworkStatus
{
    
    //1.创建网络监测者
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    /*枚举里面四个状态  分别对应 未知 无网络 数据 WiFi
     typedef NS_ENUM(NSInteger, AFNetworkReachabilityStatus) {
     AFNetworkReachabilityStatusUnknown          = -1,      未知
     AFNetworkReachabilityStatusNotReachable     = 0,       无网络
     AFNetworkReachabilityStatusReachableViaWWAN = 1,       蜂窝数据网络
     AFNetworkReachabilityStatusReachableViaWiFi = 2,       WiFi
     };
     */
    NSLog(@"12345");
 
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        //这里是监测到网络改变的block  可以写成switch方便
        //在里面可以随便写事件
                switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络状态");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                    {
                NSLog(@"无网络");
                [self networkReachabilityStatusUnknown];
                    }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWWAN:
                    {
                NSLog(@"蜂窝数据网");
                [self networkReachabilityStatusReachableViaWWAN];
                    }
                break;
                
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WiFi网络");
                
                break;
                
            default:
                break;
        }
//
   }] ;
    [manager startMonitoring];
    NSLog(@"56789");
    
}
-(void)networkReachabilityStatusUnknown{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"网络错误"
                                                       message:@"您可以在”设置“中为此应用程序打开蜂窝移动数据。"

                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"设置", nil];
    //显示alertView
    [alertView show];
//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"网络错误"
//                                                                   message:@"您可以在”设置“中为此应用程序打开蜂窝移动数据。"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"设置"
//                                              style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * _Nonnull action) {
////                                                canOpenURLString(@"prefs:root=MOBILE_DATA_SETTINGS_ID");
//                                                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]];
//                                            }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"好"
//                                              style:UIAlertActionStyleCancel handler:nil]];
//   
   
   
}
-(void)networkReachabilityStatusReachableViaWWAN{
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"当前网络为3G／4G，确定观看？"
                                                       message:@"建议开启WIFI后观看视频。"
                              
                                                      delegate:self
                                             cancelButtonTitle:@"取消"
                                             otherButtonTitles:@"设置", nil];
    //显示alertView
    [alertView show];

//    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"当前网络为3G／4G，确定观看？"
//                                                                   message:@"建议开启WIFI后观看视频。"
//                                                            preferredStyle:UIAlertControllerStyleAlert];
//    [alert addAction:[UIAlertAction actionWithTitle:@"设置"
//                                              style:UIAlertActionStyleDefault
//                                            handler:^(UIAlertAction * _Nonnull action) {
//                                                [[UIApplication sharedApplication]openURL:[NSURL URLWithString:@"prefs:root=MOBILE_DATA_SETTINGS_ID"]];
//                                            }]];
//    [alert addAction:[UIAlertAction actionWithTitle:@"好"
//                                              style:UIAlertActionStyleCancel handler:nil]];
//    
//
}

@end
