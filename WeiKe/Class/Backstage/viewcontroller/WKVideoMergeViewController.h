//
//  WKVideoMergeViewController.h
//  WeiKe
//
//  Created by 谢鹏 on 2017/5/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKBackstage.h"
@interface WKVideoMergeViewController : WKBaseViewController
@property (strong,nonatomic) WKVideoModel *videoModel;
@property (strong,nonatomic)NSMutableArray *videoarr;
@property (assign,nonatomic)BOOL isCommet;
@property (assign,nonatomic)BOOL isOutLink;
@end
