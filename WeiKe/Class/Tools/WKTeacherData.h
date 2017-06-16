//
//  WKTeacherData.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKTeacherData : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * idCode;
@property (nonatomic, strong) NSString * imgFileUrl;
@property (nonatomic, strong) NSString * moblePhone;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, strong) NSString * teacherName;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, strong) NSString * className;
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic, strong) NSString * gradeName;
@property (nonatomic, strong) NSString * positionName;
@end
