//
//  WKJobScoreTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobScoreTableViewCell.h"

@implementation WKJobScoreTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.Socre.frame = CGRectMake(SCREEN_WIDTH/3, 0, 53, 37);
    self.Socre.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.stuName.textColor = [WKColor colorWithHexString:DARK_COLOR];
    [self.watchButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.watchButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.watchButton.layer.cornerRadius = 3;
    [self.shareButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.shareButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.shareButton.layer.cornerRadius = 3;

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
