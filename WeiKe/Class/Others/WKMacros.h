//
//  WKMacros.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#ifndef WKMacros_h
#define WKMacros_h

#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
#define FONT_BOLD   @"PingFangSC-Semibold"
#define FONT_REGULAR @"PingFangSC-Regular"
#define LIGHT_COLOR @"f2f2f2"
#define WHITE_COLOR @"ffffff"
#define GREEN_COLOR @"72c456"
#define BACK_COLOR @"e5e5e5"
#define DARK_COLOR @"666666"
#define SCOOLID [[NSUserDefaults standardUserDefaults]objectForKey:@"schoolId"]
#define LOGINUSERID [[NSUserDefaults standardUserDefaults]objectForKey:@"loginUserId"]
#define SCHSECTYPE [[NSUserDefaults standardUserDefaults]objectForKey:@"schSecType"]
#define TOKEN [[NSUserDefaults standardUserDefaults]objectForKey:@"token"]
#define USERTYPE [[NSUserDefaults standardUserDefaults]objectForKey:@"userType"]




#endif /* WKMacros_h */
