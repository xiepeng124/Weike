//
//  WKStatisticsSectionView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKStatisticsSectionView.h"

@implementation WKStatisticsSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.teachName.textColor = [WKColor colorWithHexString:@"333333"];
    [self.videoNumber setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.videoNumber.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
     self.playNumber.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.videoStatistics.textColor = [WKColor colorWithHexString:DARK_COLOR];
    [self.updownButton setImage:[UIImage imageNamed:@"my_arrows_but"] forState:UIControlStateNormal];
      [self.updownButton setImage:[UIImage imageNamed:@"my_arrows_top"] forState:UIControlStateSelected];
    self.updownButton.contentHorizontalAlignment =  UIControlContentHorizontalAlignmentRight;
    self.line.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.layer.cornerRadius =3 ;
    self.layer.masksToBounds = YES;
}


@end
