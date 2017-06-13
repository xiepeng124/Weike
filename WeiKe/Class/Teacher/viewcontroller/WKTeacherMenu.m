//
//  WKTeacherMenu.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherMenu.h"

@implementation WKTeacherMenu
-(instancetype)init{
    self = [super init];
    if (self) {
        NSArray *onedata=@[@"观看记录"];
        NSArray *twodata=@[@"个人资料",@"密码安全"];
        NSArray *threedata=@[@"后台管理"];
        self.Datalist = [NSArray arrayWithObjects:onedata,twodata,threedata,nil];
        NSArray *oneImage = @[@"my_video"];
        NSArray *twoImage = @[@"my_data",@"my_password"];
         NSArray *threeImage = @[@"my_back"];
        self.Imagelist = [NSArray arrayWithObjects:oneImage,twoImage, threeImage,nil];
    }
    return self;
}

@end
