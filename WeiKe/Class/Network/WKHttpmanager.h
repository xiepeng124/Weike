//
//  WKHttpmanager.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <AFNetworking/AFNetworking.h>

@interface WKHttpmanager : AFHTTPSessionManager
+(instancetype)shareWKHttpmanager;

@end
