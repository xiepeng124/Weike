//
//  WKVideoStatisticsTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoStatisticsTableViewCell.h"

@implementation WKVideoStatisticsTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.videoName.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.videoPercent.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.backView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
