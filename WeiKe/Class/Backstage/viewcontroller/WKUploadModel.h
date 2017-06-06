//
//  WKUploadModel.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKUploadModel : NSObject
@property (assign ,nonatomic)NSInteger fileName;
@property (assign ,nonatomic)NSInteger fileSize;

@property (strong ,nonatomic)NSString *fileType;
@property (assign ,nonatomic)NSInteger flag;
@property (strong ,nonatomic)NSString *imageUrl;
@property (strong ,nonatomic)NSString *msg;
@property (strong ,nonatomic)NSString *realPath;
@property (strong ,nonatomic)NSString *sourceName;
@property (assign ,nonatomic)NSInteger videoTime;
@end
