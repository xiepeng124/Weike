//
//  WKVideoModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKVideoModel : NSObject
@property (nonatomic, strong) NSString * approvalStatus;
@property (nonatomic, strong) NSString * concatFlag;
@property (nonatomic, strong) NSString * courseName;
@property (nonatomic ,assign) NSInteger  courseId;
@property (nonatomic, assign) NSInteger createTime;
@property (nonatomic, assign) NSInteger createrId;
@property (nonatomic, strong) NSString * delFlag;
@property (nonatomic, strong) NSString * gradeName;
@property (nonatomic ,assign) NSInteger  gradeId;
@property (nonatomic, assign) NSInteger id;
@property (nonatomic, assign) NSInteger ownerId;
@property (nonatomic, strong) NSString *remark;
@property (nonatomic, assign) NSInteger schoolId;
@property (nonatomic, assign) NSInteger section;
@property (nonatomic, strong) NSString * teacherName;
@property (nonatomic, strong) NSString * title;
@property (nonatomic, assign) NSInteger updateTime;
@property (nonatomic, assign) NSInteger updaterId;
@property (nonatomic, assign) NSInteger uploadTime;
@property (nonatomic, strong) NSString * videoLink;
@property (nonatomic, strong) NSString * videoImage;
@property (nonatomic, assign) NSInteger  videoType;
@property (nonatomic, strong) NSString *bannerUrl;
@property (nonatomic, strong) NSString * videoImgUrl;
@end
