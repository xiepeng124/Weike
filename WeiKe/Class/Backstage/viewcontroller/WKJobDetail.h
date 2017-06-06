//
//  WKJobDetail.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKJobDetail : NSObject
@property (nonatomic, assign) NSInteger notHandInNum;
@property (nonatomic, strong) NSArray * notHandInStuNames;
@property (nonatomic, assign) NSInteger stusNum;
@property (nonatomic,strong) NSString *beginTime;
@property (nonatomic,strong) NSString *endTime;
@end
