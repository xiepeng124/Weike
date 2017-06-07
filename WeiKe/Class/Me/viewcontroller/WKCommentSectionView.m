//
//  WKCommentSectionView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCommentSectionView.h"

@implementation WKCommentSectionView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.stuComment.textColor = [WKColor colorWithHexString:@"333333"];
    self.commentCount.textColor = [WKColor colorWithHexString:@"999999"];
    self.myComment.textColor = [WKColor colorWithHexString:@"333333"];
    [self.commentbutton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.commentbutton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.commentbutton.layer.cornerRadius = 3;
    self.commentbutton.userInteractionEnabled  = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.myComment];
}
-(void)textchangge{
    if (!self.myComment.text.length) {
        [self.commentbutton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
        self.commentbutton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
         self.commentbutton.userInteractionEnabled  = NO;

    }
    else{
        [self.commentbutton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.commentbutton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
         self.commentbutton.userInteractionEnabled  = YES;

    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.myComment];
}

@end
