//
//  WKPlaycommentTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPlaycommentTableViewCell.h"

@implementation WKPlaycommentTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headPhoto.layer.cornerRadius =16;
    self.headPhoto.layer.masksToBounds = YES;
    self.stuName.textColor = [WKColor colorWithHexString:@"4481c2"];
    self.commentTime.textColor = [WKColor colorWithHexString:@"999999"];
    self.commmentLabel.textColor = [WKColor colorWithHexString:@"333333"];
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
