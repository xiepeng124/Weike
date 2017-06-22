//
//  WKHomeAdHandler.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHttpbase.h"
#import "WKHomeAD.h"
#import "WKHomeNew.h"
@interface WKHomeAdHandler : WKHttpbase
+(void)executeGetHomeAdWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed parameter:(NSDictionary*)dic;
+(void)executeGetHomeNewVideoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed parameter:(NSDictionary*)dic;
+(void)executeGetHomeHotVideoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed parameter:(NSDictionary*)dic;
@end
