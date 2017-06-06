//
//  WKMenuDetail.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/14.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMenuDetail.h"

@implementation WKMenuDetail
-(instancetype)init{
    self=[super init];
    if (self) {
        self.subjectlist = [NSArray arrayWithObjects:@"全部",@"课程类",@"教学类",@"德育类",nil];
        self.gradelist = [NSArray arrayWithObjects:@"全部",@"初一年级",@"初二年级",@"初三年级",@"高一年级",@"高二年级",@"高三年级", nil];
        self.courselist = [NSArray arrayWithObjects:@"全部",@"语文",@"数学",@"英语",@"物理",@"化学",@"生物",@"地理",@"历史",@"政治", nil];
        self.Imagelist = [NSArray arrayWithObjects:@"all",@"class_language",@"class_math",@"class_English",@"class_physics",@"class_chemistry",@"class_biology",@"class_geography",@"class_history",@"class_political", nil];
    }
    return self;
}
@end
