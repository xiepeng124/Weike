//
//  WKPlayerHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPlayerHandler.h"

@implementation WKPlayerHandler
+(void)executeGetVideoAndPlayWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString: VIDEO_PLAY parameters:dic
      success:^(id responseObject) {
          
          NSArray *arr = [WKPlayVideoModel mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
          for (WKPlayVideoModel * model in arr) {
              model.total = [responseObject objectForKey:@"total"];
          }
          NSLog(@"/////%@..",responseObject);
          success(arr);
      } failure:^(NSError *error) {
          failed(error);
      }];
}
+(void)executeGetVideoCommentWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString: VIDEO_COMMENT parameters:dic
                          success:^(id responseObject) {
                                NSArray *arr = [WKVideoCommentModel mj_objectArrayWithKeyValuesArray:responseObject[@"commentList"]];
                                  for (WKVideoCommentModel * model in arr) {
                                      model.total = [responseObject objectForKey:@"total"];
                                  }
                                  success(arr);

                    
                      // NSLog(@"respn = %@",responseObject);
                           //success(responseObject);
                          } failure:^(NSError *error) {
                              failed(error);
                          }];
}
+(void)executeGetVideoCommentSendWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString: VIDEO_COMMENT_SEND parameters:dic
                          success:^(id responseObject) {
                              
                              
                                    success(responseObject);
                          } failure:^(NSError *error) {
                              failed(error);
                          }];
}
+(void)executeGetVideoReplySendWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:VIDEO_REPLY_SEND parameters:dic success:^(id responseObject) {
        success(responseObject);
    } failure:^(NSError *error) {
        
    }];
}
+(void)executeGetOutVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString: VIDEO_PLAY parameters:dic
                          success:^(id responseObject) {
                              
                              NSArray *arr = [WKPlayOutVideo mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
                              for (WKPlayOutVideo * model in arr) {
                                  model.bigTitle = [responseObject objectForKey:@"title"];
                              }
                             /// NSLog(@"/////%@..",responseObject);
                              success(arr);
                          } failure:^(NSError *error) {
                              failed(error);
                          }];
}

@end
