//
//  WKBackstage.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/9.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBackstage.h"
#import "WKRolesModel.h"

@implementation WKBackstage
+(void)executeGetBackstageAllorSearchWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:ROLE_SEARCH parameters:dic success:^(id responseObject) {
//        NSLog(@"object = %@",responseObject);
        NSArray *arr = [WKRolesModel mj_objectArrayWithKeyValuesArray:responseObject[@"roleList"]];
       // NSLog(@"%@",arr);
        success(arr);
    } failure:^(NSError *error) {
        //NSLog(@"eror= %@",error);
        failed(error);
    }];
}
+(void)executeGetBackstageAddWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:ROLE_ADD parameters:dic success:^(id responseObject) {
       // NSLog(@"resp = %@",responseObject);
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageEditWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:ROLE_EDIT parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageDeleteWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:ROLE_DELETE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageDeleteMoreWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [WKHttpTool postWithURLString:ROLE_DELETE_MORE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageRoleBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:ROLE_BIND_YES parameters:dic success:^(id responseObject) {
        NSArray *arr = [WKRoleBindUser mj_objectArrayWithKeyValuesArray:responseObject[@"boundUserList"]];
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageRoleDeleteBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:ROLE_BIND_UN parameters:dic success:^(id responseObject) {
//        NSArray *arr = [WKRoleBindUser mj_objectArrayWithKeyValuesArray:responseObject[@"boundUserList"]];
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageRoleNoBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:ROLE_BIND_NO parameters:dic success:^(id responseObject) {
      //  NSLog(@"resp = %@",responseObject);
        NSArray *arr = [WKRoleBindUser mj_objectArrayWithKeyValuesArray:responseObject[@"unbUserList"]];
       // NSLog(@"arr = %@",arr);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageRoleAddBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:ROLE_BIND  parameters:dic success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageRoleUnMoreBindWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:ROLE_BIND_UNMORE  parameters:dic success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageVideoWithParameter:(NSDictionary*)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    
    [WKHttpTool postWithURLString:Video_Search  parameters:dic success:^(id responseObject) {
        //NSLog(@"respont =%@",responseObject);
        NSArray *arr = [WKVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"videoInfoList"]];
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageDeleteVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [WKHttpTool postWithURLString:Video_DELETE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageSetVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [WKHttpTool postWithURLString:VIEDO_SET parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageVideoADWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed
{
    [WKHttpTool postWithURLString:VIEDO_AD parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetBackstageVideoCancelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_CANCEL parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];

}
+(void)executeGetBackstageVideoADCancelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_AD_CANCEL parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoADCreatelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_AD_CREATE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoMergelWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_MERGE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoMergeCreateWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_MERGE_CREATE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoOutLinkWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_OUTLINK parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoEditWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIEDO_EDIT parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoEditKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:VIEDO_EDIT_KEEP parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageVideoUploadKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:VIEDO_UPLOAD_KEEP parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageNotApprovalVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:NOTAPPROVAL_VIEDO parameters:dic success:^(id responseObject) {
       // NSLog(@"respn  = %@",responseObject);
        NSArray *arr = [WKVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageApprovaledVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:APPROVALED_VIEDO parameters:dic success:^(id responseObject) {
        //NSLog(@"respn  = %@",responseObject);
        NSArray *arr = [WKVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageApprovalingVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:APPROVALING_VIEDO parameters:dic success:^(id responseObject) {
        //NSLog(@"respn  = %@",responseObject);
//        NSArray *arr = [WKVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageIndicatorVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:INDICATOR_SEARCH parameters:dic success:^(id responseObject) {
        
        WKIndicatorModel *indicator = [WKIndicatorModel mj_objectWithKeyValues:responseObject[@"info"]];
        NSString *nuber = [responseObject objectForKey:@"isHas"];
            indicator.isHas =nuber;

        success(indicator);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageIndicatorVideoKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:INDICATOR_KEEP parameters:dic success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

+(void)executeGetBackstageIJobSearchKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SEARCH parameters:dic success:^(id responseObject) {
   //NSLog(@"...%@",responseObject);
        NSArray *arr = [WKJobModel mj_objectArrayWithKeyValuesArray:responseObject[@"taskList"]];
     
            success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageIJobEditKeepWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
 
    [WKHttpTool postWithURLString:JOB_EDIT parameters:dic success:^(id responseObject) {
        
               success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}

+(void)executeGetBackstageIJobDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_DELETE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageSelectedJobClassWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SELECTED_CLASS parameters:dic success:^(id responseObject) {
        NSArray *arr = [WKJobGradeModel mj_objectArrayWithKeyValuesArray: responseObject[@"gradeMap"]];
        for (WKJobGradeModel *model in arr ) {
            model.schoolName = [responseObject objectForKey:@"schoolName"];
        }
            //NSLog(@"&&&%@",responseObject);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageJobAddWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_ADD parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageJobScoreEditWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SCORE_EDIT parameters:dic success:^(id responseObject) {
        WKJobDetail *model = [WKJobDetail mj_objectWithKeyValues:responseObject];
//        NSLog(@"resp = %@",responseObject);
        success(model);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageJobSendStudentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SEND_STU parameters:dic success:^(id responseObject) {
        NSArray *arr = [WKJobStu mj_objectArrayWithKeyValuesArray:responseObject[@"stuTaskList"]];
          //NSLog(@"resp = %@",responseObject);
        success(arr);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageJobScoreWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SCORE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}
+(void)executeGetBackstageJobShareWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed {
    [WKHttpTool postWithURLString:JOB_SHARE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
    
}


@end
