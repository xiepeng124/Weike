//
//  WKTeacherHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKTeacherList.h"
#import "WKGrade.h"
#import "WKCourse.h"
@interface WKTeacherHandler : WKHttpbase
+(void)executeGetTeacherListWithParameters:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetAcademyGradeWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetAcademyCourseWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
@end
