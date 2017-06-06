//
//  WKRoleBindTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRoleBindTableViewCell.h"

@implementation WKRoleBindTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.roleName.textColor= [WKColor colorWithHexString:@"333333"];
    self.roleName.font = [UIFont fontWithName:FONT_REGULAR size:16];
    self.unBind.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.unBind setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.unBind setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.unBind.layer.cornerRadius = 3;
    self.phoneNumber.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.phoneNumber.textColor = [WKColor colorWithHexString:@"666666"];
    self.cellid.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.cellid.textColor = [WKColor colorWithHexString:@"666666"];
    self.emailid.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.emailid.textColor = [WKColor colorWithHexString:@"666666"];

    // Initialization code
}
- (IBAction)changeBindselected:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate changeBindOrUn:sender];
}

- (IBAction)deleteBind:(UIButton *)sender {
    [self.delegate unBindUser:sender];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
