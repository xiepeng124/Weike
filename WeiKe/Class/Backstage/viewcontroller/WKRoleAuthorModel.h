//
//  WKRoleAuthorModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKRoleAuthorModel : NSObject
@property (strong ,nonatomic) NSString *createTime;
@property (assign,nonatomic) NSInteger createrId;
@property (assign,nonatomic) NSInteger delFlag;
@property (assign,nonatomic) NSInteger id;
@property (assign,nonatomic) NSInteger isCheck;
@property (strong ,nonatomic) NSString *menuClass;
@property (strong ,nonatomic) NSString *menuColor;
@property (strong ,nonatomic) NSString *menuLink;
@property (strong ,nonatomic) NSString *menuName;
@property (assign,nonatomic) NSInteger priority;
@property (strong ,nonatomic) NSString *remark;
@property (strong ,nonatomic) NSString *updateTime;
@end
