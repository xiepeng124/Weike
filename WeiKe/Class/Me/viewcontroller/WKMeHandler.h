//
//  WKMeHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKMyJobModel.h"
#import "WKTeacherData.h"
#import "WKStudentData.h"
@interface WKMeHandler : WKHttpbase
+(void)executeGetmyTeacherListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobSearchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobHandWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyJobWatchWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetWatchVideorecordWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyDataWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:
(FailedBlock)failed;
+(void)executeGetMyDataKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyPasswordWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMyTeachTaskWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
