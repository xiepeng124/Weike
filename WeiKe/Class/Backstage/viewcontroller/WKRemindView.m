//
//  WKRemindView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRemindView.h"

@implementation WKRemindView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 72, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:12]} context:nil];
    
    return rect.size.height;
}

@end
