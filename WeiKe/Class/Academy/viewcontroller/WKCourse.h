//
//  WKCourse.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCourse : NSObject
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic, assign) NSInteger courseSection;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@end
