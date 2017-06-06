//
//  WKCourseTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCourseTableViewCell.h"

@implementation WKCourseTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.CourseLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
  
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    if (selected) {
        self.selectedBackgroundView = [[UIView alloc]initWithFrame:self.frame];
        self.selectedBackgroundView.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
        //self.backgroundColor = [UIColor redColor];
        //self.StyleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
        self.CourseLabel.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    }
    else{
        self.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
        self.CourseLabel.textColor = [WKColor colorWithHexString:@"666666"];
    }

    // Configure the view for the selected state
}
-(void)dealloc{
[[NSNotificationCenter defaultCenter] removeObserver:self name:@"ViewController" object:@"zhangsan"];
}
@end
