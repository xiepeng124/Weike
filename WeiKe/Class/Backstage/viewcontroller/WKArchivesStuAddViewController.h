//
//  WKArchivesStuAddViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/7/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKBackstage.h"
@interface WKArchivesStuAddViewController : WKBaseViewController
@property (strong,nonatomic) WKStudentData *model;
@property (assign,nonatomic) NSInteger isAdd;
  //[NSNumber numberWithInteger:self.stuGraCls.id]
@end
