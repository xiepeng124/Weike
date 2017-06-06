//
//  WKGradeTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKGradeTableViewCell.h"

@implementation WKGradeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.Gradelable.font = [UIFont fontWithName:FONT_REGULAR size:17];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
        //self.backgroundColor = [UIColor redColor];
        //self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
        self.Gradelable.textColor = [WKColor colorWithHexString:@"4481c2"];
    }
    else{
        self.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
        self.Gradelable.textColor = [WKColor colorWithHexString:@"666666"];
    }

    // Configure the view for the selected state
}

@end
