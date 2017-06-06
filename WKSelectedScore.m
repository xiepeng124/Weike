//
//  WKSelectedScore.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSelectedScore.h"

@implementation WKSelectedScore


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.scoreTitle.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.cancelButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
     [self.sureButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.sureButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.sureButton.layer.cornerRadius = 3;
    
}


@end
