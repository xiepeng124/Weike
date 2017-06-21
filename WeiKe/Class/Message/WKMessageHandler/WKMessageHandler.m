//
//  WKMessageHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMessageHandler.h"

@implementation WKMessageHandler
+(void)executeGetMessageStatusWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_NO parameters:dic success:^(id responseObject) {
    
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageListWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_LIST parameters:dic success:^(id responseObject) {
        NSLog(@" reso=%@ ...",responseObject);
        NSArray *arr = [WKMessageModel mj_objectArrayWithKeyValuesArray:responseObject[@"msgList"]];
        NSString  *string = [responseObject objectForKey:@"commentLength"];
        for (WKMessageModel *model in arr) {
            model.commentLength = [string integerValue];
        }
        success(arr);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_DELETE parameters:dic success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageSawWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_SAW parameters:dic success:^(id responseObject) {
       
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageCommentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_COMMENT parameters:dic success:^(id responseObject) {
        //NSLog(@"^^ ...%@",responseObject);
        NSArray *arr = [WKCommentListModel mj_objectArrayWithKeyValuesArray:responseObject[@"commentList"]];
        success(arr);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetMessageTaskShareWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_TASK_SHARE parameters:dic success:^(id responseObject) {
        
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMessageCommentdeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_COMMENT_DELETE parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetMessageCommentReplyWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:MESSAGE_COMMENT_REPLY parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
