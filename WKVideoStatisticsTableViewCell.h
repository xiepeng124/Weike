//
//  WKVideoStatisticsTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKVideoStatisticsTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoPercent;
@property (weak, nonatomic) IBOutlet UIView *backView;

@end
