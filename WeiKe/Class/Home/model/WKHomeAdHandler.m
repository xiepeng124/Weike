//
//  WKHomeAdHandler.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHomeAdHandler.h"
@implementation WKHomeAdHandler
+(void)executeGetHomeAdWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    //NSNumber *schoolId =[[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"];
    NSDictionary *dic = @{@"section":@1,@"schoolId":SCOOLID};
    [WKHttpTool postWithURLString:HOME_AD parameters:dic success:^(id responseObject) {
        NSArray *advertisement=[WKHomeAD mj_objectArrayWithKeyValuesArray:responseObject[@"advertisementList"]];
        success(advertisement);
    } failure:^(NSError *error) {
        failed(error);
    }];
}
+(void)executeGetHomeNewVideoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary *dic = @{@"section":@1,@"token":
                              TOKEN};
    [WKHttpTool postWithURLString:NEW_VIDEO parameters:dic success:^(id responseObject) {
        NSArray *newvideo = [WKHomeNew mj_objectArrayWithKeyValuesArray:responseObject[@"videoNewList"]];
    NSLog(@"responseObject=%@",responseObject);
        success(newvideo);
    } failure:^(NSError *error) {
        failed(error);
    }];
    }
+(void)executeGetHomeHotVideoWithSuccess:(SuccessBlock)success failed:(FailedBlock)failed{
    NSDictionary *dic = @{@"section":@1,@"token":
                              TOKEN};
    [WKHttpTool postWithURLString:HOT_VIDEO parameters:dic success:^(id responseObject) {
        NSArray *hotvideo = [WKHomeNew mj_objectArrayWithKeyValuesArray:responseObject[@"videoHotList"]];
        success(hotvideo);
    } failure:^(NSError *error) {
        failed(error);
    }];
}

@end
