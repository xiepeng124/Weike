//
//  WKHttpTool.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKHttpTool : NSObject

+ (void)getWithURLString:(NSString *)URLString
              parameters:(id)parameters
                 success:(void (^)(id responseObject))Success
                 failure:(void (^)(NSError *error))Failure;
+ (void)postWithURLString:(NSString *)URLString
               parameters:(id)parameters
                  success:(void (^)(id responseObject))Success
                  failure:(void (^)(NSError *error))Failure;
+(void)uploadWithURLString:(NSString *)URLString parameters:(NSDictionary*)dic  images:(UIImage*)Imag success:(void (^)(id responseObject))Success failure:(void (^)(NSError *error))Failure  upload:(void(^)(NSProgress *progress))UploadProgress;
+(void)uploadVideoWithURLString:(NSString *)URLString parameters:(NSDictionary*)dic  images:(UIImage*)Imag date:(id)Date success:(void (^)(id responseObject))Success failure:(void (^)(NSError *error))Failure upload:(void(^)(NSProgress *progress))UploadProgress;

-(void)AFNetworkStatus;

@end
