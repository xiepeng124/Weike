//
//  WKJobModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKJobModel : NSObject
@property (nonatomic, strong) NSString * className;
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, assign) NSInteger deliveryDeadline;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, assign) NSInteger schoolYear;
@property (nonatomic, strong) NSString * sourceName;
@property (nonatomic, strong) NSString * targetName;
@property (nonatomic, strong) NSString * taskAppendUrl;
@property (nonatomic, strong) NSString * taskName;
@property (nonatomic, strong) NSString * teacherName;
@property (nonatomic, assign) NSInteger haveStuDelivery;

@end
