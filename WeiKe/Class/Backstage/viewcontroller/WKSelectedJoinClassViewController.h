//
//  WKSelectedJoinClassViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKBackstage.h"
@protocol SelectClassViewDelegate <NSObject>

- (void)snedCLassNSstring:(NSMutableArray *)string Grade:(NSMutableArray*)grade;
@end

@interface WKSelectedJoinClassViewController : WKBaseViewController
@property (weak,nonatomic) id<SelectClassViewDelegate>delegate;
@property (assign,nonatomic) BOOL isShare;
@property (strong ,nonatomic) WKJobStu *stuModel;
@property (assign,nonatomic) NSInteger taskId;
@end
