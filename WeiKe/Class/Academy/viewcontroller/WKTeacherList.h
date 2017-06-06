//
//  WKTeacherList.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKTeacherList : NSObject
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, assign) NSInteger gender;
@property (nonatomic, strong) NSString * gradeName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * idCode;
@property (nonatomic, strong) NSString * imgFileUrl;
@property (nonatomic, strong) NSString * moblePhone;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, strong) NSString * teacherName;
@end
