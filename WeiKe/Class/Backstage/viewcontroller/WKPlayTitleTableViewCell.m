//
//  WKPlayTitleTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPlayTitleTableViewCell.h"

@implementation WKPlayTitleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.videoName.textColor = [WKColor colorWithHexString:@"4481c2"];
    self.videoLength.textColor = [WKColor colorWithHexString:@"333333"];
    self.titleLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.subjectLable.textColor = [WKColor colorWithHexString:DARK_COLOR];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:17]} context:nil];
    
    return rect.size.height;
}

@end
