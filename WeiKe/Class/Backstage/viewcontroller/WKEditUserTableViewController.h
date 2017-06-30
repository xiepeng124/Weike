//
//  WKEditUserTableViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKUserListModel.h"
@interface WKEditUserTableViewController : UITableViewController
@property (strong,nonatomic) WKUserListModel *model;
@property (assign ,nonatomic) NSInteger  queryType;
@end
