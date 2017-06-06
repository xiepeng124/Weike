//
//  WKJobScore.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/1.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobScore.h"

@implementation WKJobScore


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.line1.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line2.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line3.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line4.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line5.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line6.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line7.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line8.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.basicLabel.textColor = [WKColor colorWithHexString:GREEN_COLOR];
     self.sendJobLabel.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.JobNamelabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.JoinLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.FileLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.beginLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.endLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.JoinStuLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.notSendLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.remark.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.jobName.textColor = [WKColor colorWithHexString:@"333333"];
    self.joinClass.textColor = [WKColor colorWithHexString:@"333333"];
    self.beginTime.textColor = [WKColor colorWithHexString:@"333333"];
    self.endTime.textColor = [WKColor colorWithHexString:@"333333"];
    self.remarkText.textColor = [WKColor colorWithHexString:@"333333"];
    self.joinStu.textColor = [WKColor colorWithHexString:@"333333"];
    self.notSendStu.textColor = [WKColor colorWithHexString:@"333333"];
    self.jobName.enabled = NO;
    self.joinClass.enabled = NO;
    self.beginTime.enabled = NO;
    self.endTime.enabled = NO;
    self.remarkText.editable = NO;
    self.joinStu.enabled = NO;
    self.notSendStu.enabled = NO;
    self.downloadButton.layer.cornerRadius = 3;
    self.downloadButton.layer.masksToBounds = YES;
    self.downloadButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.downloadButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    
    
}


@end
