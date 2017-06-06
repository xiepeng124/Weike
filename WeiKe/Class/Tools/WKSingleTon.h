//
//  WKSingleTon.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKSingleTon : NSObject
@property(nonatomic,assign)BOOL isTeacher;
+(WKSingleTon*)shareWKSingleTon;
@end
