//
//  WKMyJobModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKMyJobModel : NSObject
@property (nonatomic,assign)NSInteger classId;
@property (nonatomic,strong)NSString * className;

@property (nonatomic,strong)NSString * createTime;
@property (nonatomic,assign)NSInteger createrId;
@property (nonatomic,strong)NSString * createrName;
@property (nonatomic,assign)NSInteger delFlag;
@property (nonatomic,assign)NSInteger deliveryDeadline;
@property (nonatomic,strong)NSString * endTime;
@property (nonatomic,assign)NSInteger gradeId;
@property (nonatomic,assign)NSInteger id;
@property (nonatomic,strong)NSString *remark;
@property (nonatomic,assign)NSInteger schoolId;
@property (nonatomic,assign)NSInteger schoolYear;
@property (nonatomic,strong)NSString * sourceName;
@property (nonatomic,assign)NSInteger starCount;

@property (nonatomic,strong)NSString * stuTaskUrl;
@property (nonatomic,assign)NSInteger studentId;
@property (nonatomic,strong)NSString * targetName;
@property (nonatomic,strong)NSString * taskAppendUrl;
@property (nonatomic,assign)NSInteger taskId ;
@property (nonatomic,strong)NSString * taskName;
@property (nonatomic,assign)NSInteger taskScore;
@property (nonatomic,strong)NSString * updateTime;

@end
