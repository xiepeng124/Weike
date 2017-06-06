//
//  WKTeScreenFootCollectionReusableView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeScreenFootCollectionReusableView.h"


@implementation WKTeScreenFootCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.cancelButton setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    self.SureButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.SureButton setTitleColor:[WKColor colorWithHexString:@"ffffff"] forState:UIControlStateNormal];
    self.SureButton.layer.cornerRadius = 3;
    // Initialization code
}
- (IBAction)SureAction:(id)sender {
    NSLog(@"vvv");
    [self.delegate GetSelected:NO];
}

@end
