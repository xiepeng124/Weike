//
//  WKVIdeoStatisticsModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKVIdeoStatisticsModel : NSObject
@property (strong,nonatomic)NSString *totalPlaytimes;
@property (strong,nonatomic)NSString *teacherName;
@property (assign,nonatomic)NSInteger teacherId;
@property (assign ,nonatomic)NSInteger hasNum;
@property (assign ,nonatomic)NSInteger isHasPlay;
@property (strong,nonatomic) NSString *ids;
@property (assign,nonatomic)NSInteger userId;
@property (strong,nonatomic) NSArray *videoStatic;
@end
