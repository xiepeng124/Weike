//
//  WKMessageTwoTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMessageTwoTableViewCell.h"

@implementation WKMessageTwoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.messageTitle.textColor = [WKColor colorWithHexString:@"333333"];
    self.messageTime.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.messageContent.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.line.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    [self.watchButton setTitleColor: [WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];

    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;
}

@end
