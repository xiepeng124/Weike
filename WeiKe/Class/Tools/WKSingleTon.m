//
//  WKSingleTon.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSingleTon.h"

@implementation WKSingleTon
+(WKSingleTon*)shareWKSingleTon{
    static WKSingleTon *singleton=nil;
    static dispatch_once_t once_token;
    dispatch_once(&once_token, ^{
        singleton=[[WKSingleTon alloc]init];
    });
    return singleton;
}
@end
