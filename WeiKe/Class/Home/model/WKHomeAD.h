//
//  WKHomeAD.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKHomeAD : NSObject
@property (nonatomic, strong) NSString * approvalStatus;
@property (nonatomic, strong) NSString * bannerUrl;
@property (nonatomic, strong) NSString * commentFlag;
@property (nonatomic, strong) NSString * concatFlag;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, strong) NSString * fileFormat;
@property (nonatomic, assign) NSInteger fileSize;
@property (nonatomic, assign) NSInteger idField;
@property (nonatomic, assign) NSInteger ownerId;
@property (nonatomic, assign) NSInteger playTimes;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, strong) NSString * sourceName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, assign) NSInteger uploadTime;
@property (nonatomic, strong) NSString * videoFileName;
@property (nonatomic, strong) NSString * videoFilePath;
@property (nonatomic, strong) NSString * videoImage;
@property (nonatomic, strong) NSString * videoImgUrl;
@property (nonatomic, strong) NSString * videoTimeLength;
@property (nonatomic, assign) NSInteger videoType;
@end
