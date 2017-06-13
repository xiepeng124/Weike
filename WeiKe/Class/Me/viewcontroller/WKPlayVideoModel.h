//
//  WKPlayVideoModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKPlayVideoModel : NSObject
@property (nonatomic,assign)NSInteger commentFlag;
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic, strong) NSString * gradeName;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, strong) NSString * teacherName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, strong) NSString * uploadTime;
@property (nonatomic, strong) NSString * videoFilePath;
@property (nonatomic, strong) NSString * videoImgUrl;
@property (nonatomic, strong) NSString * videoTimeLength;
@property (nonatomic, strong) NSString * total;
@property (nonatomic, assign) NSInteger receiverId;
@end
