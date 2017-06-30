//
//  WKBackstage.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/9.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKRoleBindUser.h"
#import "WKVideoModel.h"
#import "WKIndicatorModel.h"
#import "WKJobModel.h"
#import "WKJobDetail.h"
#import "WKJobGradeModel.h"
#import "WKJobStu.h"
#import "WKVIdeoStatisticsModel.h"
#import "WKTeacherVideoList.h"
#import "WKRolesModel.h"
#import "WKRoleAuthorModel.h"
#import "WKUserListModel.h"
#import "WKTeacherData.h"
#import "WKStudentData.h"
@interface WKBackstage : WKHttpbase
+(void)executeGetBackstageAllorSearchWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageAddWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageEditWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageDeleteWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageDeleteMoreWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleDeleteBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleNoBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleAddBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleUnMoreBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleAuthorWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageRoleAuthorKeepWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageDeleteVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageSetVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoADWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoCancelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoADCancelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoADCreatelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoMergelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoMergeCreateWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoOutLinkWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoEditWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoEditKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoUploadKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageNotApprovalVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageApprovaledVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageApprovalingVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageIndicatorVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageIndicatorVideoKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageIJobSearchKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageIJobEditKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageIJobDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageSelectedJobClassWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageJobAddWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageJobScoreEditWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageJobSendStudentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageJobScoreWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageJobShareWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
//视频统计
+(void)executeGetBackstageVideoStatistWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageVideoStatistListWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;

//用户
+(void)executeGetBackstageUserListWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageUserForbidWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageUserStartWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageUserTeacherWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageUserStudentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageUserPasswordSetWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageUserRoleSetWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageUserRoleUpWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;

//档案
+(void)executeGetBackstageArchivesTeachWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageArchivesStuWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageArchivesTeachDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
+(void)executeGetBackstageArchivesStuDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetBackstageArchivesTeachDetailWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed ;
@end
