//
//  WKApprovalingViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKBackstage.h"
@interface WKApprovalingViewController : WKBaseViewController
@property (strong,nonatomic) WKVideoModel *videoModel;
@property (assign ,nonatomic)NSInteger isMore;
@property (strong ,nonatomic)NSMutableArray *videoarr;
@end
