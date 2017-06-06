//
//  WKIndicatorModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKIndicatorModel : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, assign) NSInteger videoCount;
@property (nonatomic, strong) NSString * isHas;
@end
