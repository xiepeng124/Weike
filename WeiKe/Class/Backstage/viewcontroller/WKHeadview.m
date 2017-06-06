//
//  WKHeadview.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHeadview.h"

@implementation WKHeadview


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.roleLable.font = [UIFont fontWithName:FONT_BOLD size:17];
    self.addLable.font = [UIFont fontWithName:FONT_REGULAR size:9];
    self.deleteLable.font =[UIFont fontWithName:FONT_REGULAR size:9];
    self.roleLable.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.addLable.textColor = [WKColor colorWithHexString:@"666666"];
    self.deleteLable.textColor = [WKColor colorWithHexString:@"666666"];
    self.localButton.titleLabel .font = [UIFont fontWithName:FONT_BOLD size:17];
    [self.localButton setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [self.localButton setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected];
  // [self.localButton  setHidden:YES];
}


@end
