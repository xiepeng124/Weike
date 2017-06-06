//
//  WKAcedemyHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKGrade.h"
#import "WKCourse.h"
#import "WKHomeNew.h"
@interface WKAcedemyHandler : WKHttpbase
+(void)executeGetAcademyGradeWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetAcademySectionWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetAcademyCourseWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetAcademyVideoWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetAcademyCourse2WithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
