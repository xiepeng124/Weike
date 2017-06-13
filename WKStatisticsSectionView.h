//
//  WKStatisticsSectionView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKStatisticsSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *teachName;
@property (weak, nonatomic) IBOutlet UIButton *videoNumber;
@property (weak, nonatomic) IBOutlet UILabel *playNumber;
@property (weak, nonatomic) IBOutlet UILabel *videoStatistics;
@property (weak, nonatomic) IBOutlet UIButton *updownButton;
@property (weak, nonatomic) IBOutlet UIView *line;

@end
