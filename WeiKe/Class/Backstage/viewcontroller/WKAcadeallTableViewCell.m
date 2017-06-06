//
//  WKAcadeallTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAcadeallTableViewCell.h"

@implementation WKAcadeallTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
     self.AllTitle.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedBackgroundView.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
        //self.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
        //self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
        self.AllTitle.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    }
    else{
        self.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        self.AllTitle.textColor = [WKColor colorWithHexString:@"666666"];
    }

    // Configure the view for the selected state
}

@end
