//
//  WKSearchResultHeaderView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/14.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearchResultHeaderView.h"

@implementation WKSearchResultHeaderView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [self.classifyButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    [self.classifyButton setTitleColor:[WKColor colorWithHexString:@"4481c2"] forState:UIControlStateSelected];
    [self.Updpwnclassify setBackgroundImage:[UIImage imageNamed:@"down_OFF"] forState:UIControlStateNormal ];
    [self.Updpwnclassify setBackgroundImage:[UIImage imageNamed:@"up_on"] forState:UIControlStateSelected ];
    [self.gradebutton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    [self.gradebutton setTitleColor:[WKColor colorWithHexString:@"4481c2"] forState:UIControlStateSelected];
    [self.Updowngrade setBackgroundImage:[UIImage imageNamed:@"down_OFF"] forState:UIControlStateNormal];
    [self.Updowngrade setBackgroundImage:[UIImage imageNamed:@"up_on"] forState:UIControlStateSelected ];
    self.verLine.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    // Drawing code
}


@end
