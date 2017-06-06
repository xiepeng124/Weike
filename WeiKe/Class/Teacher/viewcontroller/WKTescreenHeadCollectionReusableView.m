//
//  WKTescreenHeadCollectionReusableView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTescreenHeadCollectionReusableView.h"

@implementation WKTescreenHeadCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.TeaScreenLabel.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.TeaScreenLabel setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal]; ;
    //self.TeaScreenLabel.layer.cornerRadius = 3;
    // Initialization code
}

@end
