//
//  WKRolesModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/9.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKRolesModel : NSObject
@property (nonatomic, strong) NSString * createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger priority;
@property (nonatomic, strong) NSString * remark;
@property (nonatomic, strong) NSString * roleName;
@property (nonatomic, strong) NSString * updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, assign) NSInteger isSelect;
@end
