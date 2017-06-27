//
//  WKJobSelectClassTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobSelectClassTableViewCell.h"

@implementation WKJobSelectClassTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self.selectedButton setImage:[UIImage imageNamed:@"teacher_select_off"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"teacher_select_on"] forState:UIControlStateSelected];
    self.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.backView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
