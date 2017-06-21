//
//  WKCommentListModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKCommentListModel : NSObject
@property (strong ,nonatomic) NSString *allowComment;
@property (strong ,nonatomic) NSString *commentType;
@property (strong ,nonatomic) NSString *contentText;
@property (strong ,nonatomic) NSString *delFlag;
@property (assign ,nonatomic) NSInteger id;
@property (strong ,nonatomic) NSString *isAnonymous;
@property (strong ,nonatomic) NSString *isFirst;
@property (assign ,nonatomic) NSInteger pId;
@property (assign ,nonatomic) NSInteger receiverId;
@property (strong ,nonatomic) NSString *receiverName;
@property (assign ,nonatomic) NSInteger schoolId;
@property (strong ,nonatomic) NSString *sendTime;
@property (assign ,nonatomic) NSInteger senderId;
@property (strong ,nonatomic) NSString *senderImg;
@property (strong ,nonatomic) NSString *senderName;
@property (assign ,nonatomic) NSInteger themeId;
@property (strong ,nonatomic) NSString *videoImg;
@property (strong, nonatomic) NSString *videoTitle;
@property (strong, nonatomic) NSString *pIdConText;
@end
