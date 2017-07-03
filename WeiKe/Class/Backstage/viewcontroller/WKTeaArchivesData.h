//
//  WKTeaArchivesData.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/7/1.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKTeaArchivesData : NSObject
@property (strong,nonatomic) NSArray * classList;
@property (strong,nonatomic) NSArray * courseList;
@property (strong,nonatomic) NSArray * gradeList;
@property (strong,nonatomic) NSArray * positionList;
@property (assign,nonatomic) NSInteger userId;
@property (strong,nonatomic) NSString *delCouIds;
@property (strong,nonatomic) NSString *delPositIds;
@property (strong,nonatomic) NSString *delTeachingIds;
@end
