//
//  WKAcedemyHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAcedemyHandler.h"

@implementation WKAcedemyHandler
+(void)executeGetAcademyGradeWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
       [ WKHttpTool postWithURLString:WEI_Grade parameters:dic success:^(id responseObject) {
           //NSLog(@"objiecr= %@",responseObject);
           NSArray *arr = [WKGrade mj_objectArrayWithKeyValuesArray:responseObject[@"gradeInfoList"]];
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetAcademySectionWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_Grade parameters:dic success:^(id responseObject) {
        NSLog(@"=%@",responseObject);
        NSMutableArray *arr = [WKGrade mj_objectArrayWithKeyValuesArray:responseObject[@"sectionList"]];
        //[arr removeLastObject];
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetAcademyCourseWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_COURSE parameters:dic success:^(id responseObject) {
        //NSLog(@"=%@",responseObject);
        NSArray *arr = [WKCourse mj_objectArrayWithKeyValuesArray:responseObject[@"courseList"]];
        //NSLog(@"arr = %@",arr);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetAcademyCourse2WithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_COURSE parameters:dic success:^(id responseObject) {
        //NSLog(@"=%@",responseObject);
        NSArray *arr = [WKGrade mj_objectArrayWithKeyValuesArray:responseObject[@"courseList"]];
//        for (int i =0; <#condition#>; <#increment#>) {
//            <#statements#>
//        }
              //NSLog(@"arr = %@",arr);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

+(void)executeGetAcademyVideoWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [ WKHttpTool postWithURLString:WEI_VEDIO parameters:dic success:^(id responseObject) {
        //NSLog(@"=%@",responseObject);
        NSArray *arr = [WKHomeNew mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        //NSLog(@"arr = %@",arr);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}



@end
