//
//  WKMeHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMeHandler.h"

@implementation WKMeHandler
+(void)executeGetmyTeacherListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    //NSDictionary *dic = @{@"userType":@1};
    [ WKHttpTool postWithURLString:ALL_TEACHER parameters:nil success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetMyJobSearchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_HAND_SEARCH parameters:dic success:^(id responseObject) {
       NSArray *arr = [WKMyJobModel mj_objectArrayWithKeyValuesArray: responseObject[@"taskList"]];
       // NSLog(@"&&&%@",responseObject);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetMyJobHandWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:JOB_HAND parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMyJobWatchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:JOB_WATCH parameters:dic success:^(id responseObject) {
        NSLog(@"respner = %@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
