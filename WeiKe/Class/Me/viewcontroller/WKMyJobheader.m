//
//  WKMyJobheader.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMyJobheader.h"

@implementation WKMyJobheader


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.notHand setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [self.notHand setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected];
    [self.unHand setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [self.unHand setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected];
    self.Line.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}


@end
