//
//  WKAcadeResultsViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKClassViewController.h"

@interface WKAcadeResultsViewController : WKClassViewController
@property(strong,nonatomic)NSNumber *typeId;
@property(strong,nonatomic)NSNumber *schoolId;
@property(strong,nonatomic)NSNumber *gradeId;
@property(strong,nonatomic)NSNumber *courseId;
@property(strong,nonatomic)NSNumber *sectionId;
@property(strong,nonatomic)NSString *gradeName;
@property(strong,nonatomic)NSString *courseName;

@end
