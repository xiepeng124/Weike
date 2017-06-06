//
//  WKHttpbase.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^SuccessBlock)(id object);
typedef void(^FailedBlock)(id object);
typedef void(^UploadBlock)(NSProgress *progress);
@interface WKHttpbase : NSObject

@end
