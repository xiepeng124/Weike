//
//  WKUpload.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUpload.h"

@implementation WKUpload


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    self.editCover.layer.cornerRadius = 3;
    [self.editCover setTitleColor:[WKColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    self.videoCover.layer.cornerRadius = 3;
    self.videoCover.layer.masksToBounds = YES;
    self.addLabel.textColor = [WKColor colorWithHexString:@"999999"];
    self.addVideo.userInteractionEnabled = YES;
    self.addButton.enabled = YES;
    self.addButton.userInteractionEnabled = YES;
    self.userInteractionEnabled = YES;
    
    
    // Drawing code
}
- (IBAction)addAction:(id)sender {
    NSLog(@"5444");
   
}
- (IBAction)add2Action:(id)sender {
    NSLog(@"1233");
}

@end
