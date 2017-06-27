//
//  WKUserListModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUserListModel : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, strong) NSString * email;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * idCode;
@property (nonatomic, strong) NSString * moblePhone;
@property (nonatomic, strong) NSString * passWord;
@property (nonatomic, assign) NSInteger teacherId;
@property (nonatomic, strong) NSString * teacherName;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic,assign) NSInteger studentId;
@property (nonatomic, strong) NSString * studentName;
@end
