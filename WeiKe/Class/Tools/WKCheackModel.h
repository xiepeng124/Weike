//
//  WKCheackModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCheackModel : NSObject
+ (BOOL)checkTelNumber:(NSString *) telNumber;
+ (BOOL)checkPassword:(NSString *) password;
+ (BOOL)checkUserName : (NSString *) userName;
+ (BOOL)checkUserIdCard: (NSString *) idCard;
+ (BOOL)checkEmployeeNumber : (NSString *) number;
+ (BOOL)checkURL : (NSString *) url;
+ (BOOL) IsBankCard:(NSString *)cardNumber;
+ (BOOL) IsEmailAdress:(NSString *)Email;
@end
