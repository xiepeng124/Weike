//
//  WKVideoCommentModel.h
//  
//
//  Created by 华驰科技 on 2017/6/9.
//
//

#import <Foundation/Foundation.h>

@interface WKVideoCommentModel : NSObject
//commentList
@property (nonatomic, strong) NSString * allowComment;
@property (nonatomic, strong) NSArray * children;
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
@property (nonatomic ,strong) NSString * total;

@end
