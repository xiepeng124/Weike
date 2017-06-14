//
//  WKSearchHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/14.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKHomeNew.h"
@interface WKSearchHandler : WKHttpbase
+(void)executeGetSearchVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed;
@end
