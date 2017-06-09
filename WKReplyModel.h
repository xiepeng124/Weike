//
//  WKReplyModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/9.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKReplyModel : NSObject
@property (nonatomic, strong) NSString * allowComment;

@property (nonatomic, strong) NSString * commentType;
@property (nonatomic, strong) NSString * contentText;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, strong) NSString * isAnonymous;
@property (nonatomic, strong) NSString * isFirst;
@property (nonatomic, assign) NSInteger pId;
@property (nonatomic, assign) NSInteger receiverId;
@property (nonatomic, strong) NSString * receiverImgFileUrl;
@property (nonatomic, strong) NSString * receiverName;
@property (nonatomic, strong) NSString * receiverPosition;
@property (nonatomic, assign) NSInteger receiverType;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, strong) NSString * sendTime;
@property (nonatomic, assign) NSInteger senderId;
@property (nonatomic, strong) NSString * senderImgFileUrl;
@property (nonatomic, strong) NSString * senderName;
@property (nonatomic, strong) NSString * senderPosition;
@property (nonatomic, assign) NSInteger senderType;
@property (nonatomic, strong) NSString * themeId;


@end
