//
//  WKJobStu.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKJobStu : NSObject
@property (nonatomic, assign) NSInteger starCount;
@property (nonatomic, strong) NSString * stuClass;
@property (nonatomic, strong) NSString * stuName;
@property (nonatomic, assign) NSInteger stuTaskId;
@property (nonatomic, strong) NSString * stuTaskUrl;
@property (nonatomic, assign) NSInteger taskScore;
@property (nonatomic, strong) NSArray * urlList;
@end
