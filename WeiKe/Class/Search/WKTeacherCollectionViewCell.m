//
//  WKTeacherCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/17.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherCollectionViewCell.h"

@implementation WKTeacherCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.teachername.font = [UIFont fontWithName:FONT_REGULAR size:13];
    self.teachername.textColor = [WKColor colorWithHexString:@"4481c2"];
    self.layer.borderWidth = 0.5;
    self.layer.borderColor = [UIColor greenColor].CGColor;
    self.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.layer.cornerRadius = 3;
    self.grade.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.grade.textColor = [WKColor colorWithHexString:@"999999"];
    // Initialization code
}

@end
