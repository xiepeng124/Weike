//
//  WKGrade.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKGrade : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, strong) NSString * gradeCode;
@property (nonatomic, strong) NSString * gradeName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, assign) NSInteger schoolYear;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic ,assign) NSInteger sectionId;
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic, assign) NSInteger courseSection;
@property (nonatomic,assign) NSInteger gradeId;
@end
