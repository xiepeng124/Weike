//
//  WKPlayerSectionView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPlayerSectionView.h"

@implementation WKPlayerSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.titileLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.countLabel.textColor = [WKColor colorWithHexString:@"999999"];
}


@end
