//
//  WKMeHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMeHandler.h"
#import "WKTeacherData.h"
@implementation WKMeHandler
+(void)executeGetmyTeacherListWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    //NSDictionary *dic = @{@"userType":@1};
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"token":TOKEN};
    [ WKHttpTool postWithURLString:MY_TEACHER parameters:dic success:^(id responseObject) {
        NSArray *arr = [WKTeacherData mj_objectArrayWithKeyValuesArray:responseObject[@"teacherList"]];
        success(arr);
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
       /// NSLog(@"respner = %@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetWatchVideorecordWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:WATCH_RECORD parameters:dic success:^(id responseObject) {
       // NSLog(@"respner = %@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMyDataWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MY_DATA parameters:dic success:^(id responseObject) {
       // NSLog(@"respner = %@",responseObject);
        if ([USERTYPE integerValue]==2) {
            WKStudentData *student = [WKStudentData mj_objectWithKeyValues:responseObject[@"info"]];
            student.className = [responseObject objectForKey:@"className"];;
            student.gradeName =   [responseObject objectForKey:@"gradeName"];
            success(student);
        }
        else{
        WKTeacherData *teacher = [WKTeacherData mj_objectWithKeyValues:responseObject[@"info"]];
        teacher.className = [responseObject objectForKey:@"className"];
        teacher.courseName = [responseObject objectForKey:@"courseName"];
        teacher.gradeName = [responseObject objectForKey:@"gradeName"];
        teacher.positionName = [responseObject objectForKey:@"positionName"];
        success(teacher);
        }
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMyDataKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MY_DATA_KEEP parameters:dic success:^(id responseObject) {
     
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMyPasswordWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MY_PASSWORD parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMyTeachTaskWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:JOB_TEACH_WATCH parameters:dic success:^(id responseObject) {
        NSLog(@"0^^--^^%@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}


@end
