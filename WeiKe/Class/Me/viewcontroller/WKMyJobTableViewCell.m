//
//  WKMyJobTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMyJobTableViewCell.h"

@implementation WKMyJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.jobName.textColor = [WKColor colorWithHexString:@"333333"];
    self.endTime.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.className.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.stuYear.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.promulgator.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.score.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.remark.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.line.backgroundColor =[WKColor colorWithHexString:BACK_COLOR];
     [self.sendbutton setTitleColor:[ WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal] ;
    self.sendbutton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.sendbutton.layer.cornerRadius = 3;
    [self.downloadButton setTitleColor:[ WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal] ;
    self.downloadButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.downloadButton.layer.cornerRadius = 3;
    self.oneImageView.image = [UIImage imageNamed:@"star_off"];
     self.twoImageView.image = [UIImage imageNamed:@"star_off"];
     self.threeImage.image = [UIImage imageNamed:@"star_off"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
