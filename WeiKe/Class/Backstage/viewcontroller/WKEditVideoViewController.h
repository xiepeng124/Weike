//
//  WKEditVideoViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/23.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKVideoModel.h"
@interface WKEditVideoViewController : WKBaseViewController
@property (strong,nonatomic) WKVideoModel *videoModel;
@property (assign,nonatomic)BOOL isOutLink;
@end
