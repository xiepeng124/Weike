//
//  WKScoreHeaderView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKScoreHeaderView.h"

@implementation WKScoreHeaderView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.stuName.textColor = [WKColor colorWithHexString:@"333333"];
     self.stuClass.textColor = [WKColor colorWithHexString:@"333333"];
    [self.checkButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.checkButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.checkButton.layer.cornerRadius = 3;
    
}


@end
