//
//  WKViewingTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/15.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKViewingTableViewCell.h"

@implementation WKViewingTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.videoImage.clipsToBounds = YES;
    self.videoImage.layer.cornerRadius = 3;
    self.videoImage.layer.masksToBounds = YES;
    self.titleLab.textColor = [WKColor colorWithHexString:@"333333"];
    self.teacherName.textColor = [WKColor colorWithHexString:@"4481c2"];
    self.subject.textColor = [WKColor colorWithHexString:@"999999"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
