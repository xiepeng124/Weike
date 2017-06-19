//
//  WKMessageOneTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMessageOneTableViewCell.h"

@implementation WKMessageOneTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.commentLabel.textColor = [WKColor colorWithHexString:@"333333"];
    [self.watchAllButton setTitleColor: [WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
