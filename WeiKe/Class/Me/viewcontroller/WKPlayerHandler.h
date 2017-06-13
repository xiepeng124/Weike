//
//  WKPlayerHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKPlayVideoModel.h"
#import "WKVideoCommentModel.h"
#import "WKPlayOutVideo.h"
@interface WKPlayerHandler : WKHttpbase
+(void)executeGetVideoAndPlayWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetVideoCommentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetVideoCommentSendWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetVideoReplySendWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
+(void)executeGetOutVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
