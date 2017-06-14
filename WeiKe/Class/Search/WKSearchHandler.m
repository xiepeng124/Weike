//
//  WKSearchHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/14.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearchHandler.h"

@implementation WKSearchHandler
+(void)executeGetSearchVideoWithParameter:(NSDictionary *)dic success:(SuccessBlock)success failed:(FailedBlock)failed{
    [WKHttpTool postWithURLString:SEARCH_VIDEO parameters:dic success:^(id responseObject) {
        NSLog(@"****%@",responseObject);
        NSArray *arr = [WKHomeNew mj_objectArrayWithKeyValuesArray:responseObject[@"videoList"]];
        success(arr);
    } failure:^(NSError *error) {
        
    }];
}
@end
