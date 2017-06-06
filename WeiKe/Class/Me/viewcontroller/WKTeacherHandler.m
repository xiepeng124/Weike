//
//  WKTeacherHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherHandler.h"

@implementation WKTeacherHandler
+(void)executeGetTeacherListWithParameters:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
   //NSDictionary *dic = @{@"page":,@"token":,@"schoolId":,@"userType":@1};
   [ WKHttpTool postWithURLString:ALL_TEACHER parameters:dic success:^(id responseObject) {
        NSArray *arr = [WKTeacherList mj_objectArrayWithKeyValuesArray:responseObject[@"teaList"]];
       success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];

}
+(void)executeGetAcademyGradeWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_Grade parameters:dic success:^(id responseObject) {
        NSLog(@"objiecr= %@",responseObject);
        NSArray *arr = [WKGrade mj_objectArrayWithKeyValuesArray:responseObject[@"gradeInfoList"]];
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetAcademyCourseWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_COURSE parameters:dic success:^(id responseObject) {
        NSLog(@"=%@",responseObject);
        NSArray *arr = [WKCourse mj_objectArrayWithKeyValuesArray:responseObject[@"courseList"]];
        //NSLog(@"arr = %@",arr);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

@end
