//
//  WKReplyTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKReplyTableViewCell.h"

@implementation WKReplyTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.replyLabel.textColor = [WKColor colorWithHexString:@"333333"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 60, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:12]} context:nil];
    
    return rect.size.height;
}


@end
