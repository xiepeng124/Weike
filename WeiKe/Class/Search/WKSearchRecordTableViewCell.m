//
//  WKSearchRecordTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearchRecordTableViewCell.h"

@implementation WKSearchRecordTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.recordLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
