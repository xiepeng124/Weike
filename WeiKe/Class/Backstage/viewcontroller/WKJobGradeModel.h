//
//  WKJobGradeModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WKJObClassModel.h"
@interface WKJobGradeModel : NSObject
@property (strong,nonatomic) NSArray *classMap;

@property (nonatomic, assign) NSInteger gradeId;
@property (nonatomic, strong) NSString * gradeName;

@property (nonatomic, strong) NSString * schoolName;
@end
