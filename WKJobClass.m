//
//  WKJobClass.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobClass.h"

@implementation WKJobClass


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.gradeLabel.textColor = [WKColor colorWithHexString:@"333333"];
    [self.selectButton setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectButton setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    [self.updownButton setImage:[UIImage imageNamed:@"my_arrows_but"] forState:UIControlStateNormal];
    [self.updownButton setImage:[UIImage imageNamed:@"my_arrows_top"] forState:UIControlStateSelected];
    // Drawing code
}
- (IBAction)updown:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate foldHeaderforbutton:sender];
}
- (IBAction)selectedGrade:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate foldHeaderselectedbutton:sender];
}


@end
