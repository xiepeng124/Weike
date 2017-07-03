//
//  WKVideoClassfiCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoClassfiCollectionViewCell.h"

@implementation WKVideoClassfiCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.myselected setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.myselected setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.myselected.userInteractionEnabled = NO;
    
    self.mylabel.textColor = [WKColor colorWithHexString:@"333333"];
    // Initialization code
}

@end
