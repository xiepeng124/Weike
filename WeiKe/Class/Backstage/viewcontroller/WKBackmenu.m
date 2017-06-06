//
//  WKBackmenu.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBackmenu.h"

@implementation WKBackmenu
-(instancetype)init{
    self = [super init];
    if (self) {
        self.menuImage = [NSArray arrayWithObjects:@"menu",@"role",@"Year",@"subject",@"position",@"record",@"video",@"statistics",@"user",@"award",@"check",@"job", nil];
      self.menuTitle = [NSArray arrayWithObjects:@"菜单管理",@"角色权限",@"学年管理",@"学科管理",@"职位管理",@"档案管理",@"视频管理",@"视频统计",@"用户管理",@"视频奖励指标设置",@"视频审核管理",@"作业管理", nil];
    }
    return self;
}
@end
