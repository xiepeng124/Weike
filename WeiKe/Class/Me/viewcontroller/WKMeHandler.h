//
//  WKMeHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKMyJobModel.h"
@interface WKMeHandler : WKHttpbase
+(void)executeGetmyTeacherListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobSearchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobHandWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobWatchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
