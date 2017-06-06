//
//  WKMeTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMeTableViewCell.h"

@implementation WKMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.DataTitle.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.DataTitle.textColor = [WKColor colorWithHexString:@"666666"];
    self.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
