//
//  WKArchivesStuTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/30.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKArchivesStuTableViewCell.h"

@implementation WKArchivesStuTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.stuName.textColor = [WKColor colorWithHexString:@"333333"];
    self.sexLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.classLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.gradeLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    [self.editButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.editButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.editButton.layer.cornerRadius = 3;
    [self.detailButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.detailButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.detailButton.layer.cornerRadius = 3;
    [self.deleteButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.deleteButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.deleteButton.layer.cornerRadius = 3;
    self.lineView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.layer.masksToBounds = YES;
    self.layer.cornerRadius =3;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
