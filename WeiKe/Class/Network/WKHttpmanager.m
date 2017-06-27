//
//  WKHttpmanager.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpmanager.h"

@implementation WKHttpmanager
+(instancetype)shareWKHttpmanager{
    static WKHttpmanager* httpmanager=nil;
    static dispatch_once_t once;
    dispatch_once(&once, ^{
        httpmanager=[[WKHttpmanager alloc]init];
        
    });
    return httpmanager;
}
-(instancetype)init{
    if (self=[super init]) {
        /**设置请求超时时间*/

              self.requestSerializer.timeoutInterval = 10;
        /**分别设置请求以及相应的序列化器*/
        self.requestSerializer = [AFHTTPRequestSerializer serializer];
        AFJSONResponseSerializer * response = [AFJSONResponseSerializer serializer];
        response.removesKeysWithNullValues = YES;
        self.responseSerializer = response;
        /**复杂的参数类型 需要使用json传值-设置请求内容的类型*/
        //[self.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        //[self.requestSerializer setValue:@"form/data" forHTTPHeaderField:@"Content-Type"];
        /**设置接受的类型*/
        [self.responseSerializer setAcceptableContentTypes:[NSSet setWithObjects:@"text/plain",@"application/json",@"text/json",@"text/javascript",@"text/html",  @"image/jpeg",@"image/png",nil]];
        
    }
    return self;
}
@end
