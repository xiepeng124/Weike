//
//  WKMessageModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKMessageModel : NSObject
@property (strong,nonatomic)NSString *delFlag;
@property (strong,nonatomic)NSString *delTime;
@property (assign,nonatomic)NSInteger id;
@property (strong,nonatomic)NSString *msgContent;
@property (assign,nonatomic)NSInteger msgReceiverId;
@property (strong,nonatomic)NSString *msgTitle;
@property (strong,nonatomic)NSString *msgType;
@property (strong,nonatomic)NSString *readFlag;
@property (assign,nonatomic)NSInteger receiverId;
@property (assign,nonatomic)NSInteger schoolId;
@property (strong,nonatomic)NSString *sendTime;
@property (assign,nonatomic)NSInteger senderId;
@property (assign,nonatomic)NSInteger commentLength;
@property (assign,nonatomic)NSInteger msgId ;
@property (assign,nonatomic)NSInteger stid ;
@property (strong,nonatomic)NSString* stuName ;
@end
