//
//  WKAuthorizeTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAuthorizeTableViewCell.h"

@implementation WKAuthorizeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
       [self.selectedButton setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.menuLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
