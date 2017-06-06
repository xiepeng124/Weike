//
//  WKBackstageCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBackstageCollectionViewCell.h"

@implementation WKBackstageCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.MenuLabel.font = [UIFont fontWithName:FONT_REGULAR size:14];
    self.MenuLabel.textColor = [WKColor colorWithHexString:@"666666"];
    // Initialization code
}

@end
