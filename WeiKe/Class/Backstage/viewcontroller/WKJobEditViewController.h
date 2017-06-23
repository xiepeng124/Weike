//
//  WKJobEditViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKClassViewController.h"
#import "WKBackstage.h"
@interface WKJobEditViewController : WKBaseViewController
@property (strong , nonatomic) WKJobModel *jobModel;
@property (assign , nonatomic)BOOL isAdd;
@end
