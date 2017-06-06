//
//  WKRoleBindUser.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKRoleBindUser : NSObject
@property (nonatomic, strong) NSString * email;
@property (nonatomic, strong) NSString * idCode;
@property (nonatomic, strong) NSString * moblePhone;
@property (nonatomic, strong) NSString * name;
@property (nonatomic, assign) NSInteger roleId;
@property (nonatomic, assign) NSInteger rsId;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, assign) NSInteger userId;
@property (nonatomic, strong) NSString * userName;
@property (nonatomic, assign) NSInteger userType;
@property (nonatomic ,assign)NSInteger id;
@property (nonatomic, assign)NSInteger teacherId ;
@property (nonatomic, strong) NSString * teacherName;

@property (nonatomic, assign)NSInteger updaterId ;


@end
