//
//  WKCommentMeTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCommentMeTableViewCell.h"

@implementation WKCommentMeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.headImage.layer.cornerRadius =17;
    self.headImage.layer.masksToBounds = YES;
    self.commenttitle.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.commentCOntent.textColor = [WKColor colorWithHexString:@"333333"];
    self.commentTime.textColor = [WKColor colorWithHexString:@"999999"];
    self.commentbackView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.commented.textColor = [WKColor colorWithHexString:DARK_COLOR];
    // Initialization code
}
+ (CGFloat)heightForLabel:(NSString *)text withIndex:(NSInteger) index{
    if (index ==1) {
        CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -20, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
        
        return rect.size.height;

    }
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -64, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;

   }
+ (CGFloat)heightForTwoLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -118, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
