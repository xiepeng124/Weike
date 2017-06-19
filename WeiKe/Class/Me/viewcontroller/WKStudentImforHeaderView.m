//
//  WKStudentImforHeaderView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKStudentImforHeaderView.h"

@implementation WKStudentImforHeaderView


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    self.basicTitle.textColor = [WKColor colorWithHexString:GREEN_COLOR];
      self.imagelabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.nameLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.sexLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.cardIdLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.phoneLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.loginLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.emailLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.StuGrade.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.stuClass.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.stuNumber.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.schoolRoll.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.nametext.textColor = [WKColor colorWithHexString:@"333333"];
    self.cardIdText.textColor = [WKColor colorWithHexString:@"333333"];
    self.phoneNumText.textColor = [WKColor colorWithHexString:@"333333"];
    self.emailText.textColor = [WKColor colorWithHexString:@"333333"];
    self.StuGradeText.textColor = [WKColor colorWithHexString:@"333333"];
    self.stuClassText.textColor = [WKColor colorWithHexString:@"333333"];

    self.stuNumberText.textColor = [WKColor colorWithHexString:@"333333"];
    self.schoolRollText.textColor = [WKColor colorWithHexString:@"333333"];
    //self.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.oneView.layer.cornerRadius =3;
    self.oneView.layer.masksToBounds = YES;
   
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.keepButton.layer.cornerRadius = 3;
    self.line1.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line2.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line3.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line4.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line5.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line6.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line7.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line8.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line9.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.lastline.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.sexSegment.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
}


@end
