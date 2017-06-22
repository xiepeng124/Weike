//
//  WKSelectSchoolTypeView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/22.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSelectSchoolTypeView.h"

@implementation WKSelectSchoolTypeView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    self.middleView.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.middleView.userInteractionEnabled = YES;
    self.middleView.layer.cornerRadius = 3;
    self.middleView.layer.masksToBounds = YES;
    self.middleLabel.font = [UIFont fontWithName:FONT_BOLD size:20];
    self.middleLabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.englishLabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.highView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.highView.userInteractionEnabled = YES;
    self.highView.layer.cornerRadius = 3;
    self.highView.layer.masksToBounds = YES;
    self.middleLabel.font = [UIFont fontWithName:FONT_BOLD size:20];
    self.highLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.highEngLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.orView.layer.cornerRadius = 29;
    self.orView.layer.masksToBounds = YES;
    self.ismiddle = YES;
    // Drawing code
}


@end
