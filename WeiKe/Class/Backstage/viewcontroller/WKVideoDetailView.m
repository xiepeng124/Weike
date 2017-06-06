//
//  WKVideoDetailView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/11.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoDetailView.h"

@implementation WKVideoDetailView

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.videoMenu.layer.cornerRadius =3;
    self.videoMenu.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    [self.videoMenu setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.videoMerge.layer.cornerRadius =3;
    self.videoMerge.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    [self.videoMerge setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
}


@end
