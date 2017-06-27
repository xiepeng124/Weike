//
//  WKUserManagerTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUserManagerTableViewCell.h"

@implementation WKUserManagerTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.titleName.textColor = [WKColor colorWithHexString:@"333333"];
    self.titleName.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.accountLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.accountLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.secondLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.secondLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.forbidbutton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.forbidbutton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.forbidbutton.layer.cornerRadius= 3;
    [self.editButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.editButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.editButton.layer.cornerRadius = 3;
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.LineView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
