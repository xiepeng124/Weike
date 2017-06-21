//
//  WKMessageHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKMessageModel.h"
#import "WKCommentListModel.h"
@interface WKMessageHandler : WKHttpbase
+(void)executeGetMessageStatusWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageListWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageDeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageSawWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageCommentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageTaskShareWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageCommentdeleteWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetMessageCommentReplyWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
