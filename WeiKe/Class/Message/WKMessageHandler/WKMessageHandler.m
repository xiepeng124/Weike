//
//  WKMessageHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMessageHandler.h"

@implementation WKMessageHandler
+(void)executeGetMessageStatusWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_NO parameters:dic success:^(id responseObject) {
        //NSLog(@"^^ ...%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageListWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_LIST parameters:dic success:^(id responseObject) {
        //NSLog(@"^^ ...%@",responseObject);
        NSArray *arr = [WKMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"msgList"]];
        success(arr);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_DELETE parameters:dic success:^(id responseObject) {
        //NSLog(@"^^ ...%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageSawWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_SAW parameters:dic success:^(id responseObject) {
        //NSLog(@"^^ ...%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}

@end
