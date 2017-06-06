//
//  WKTeachScreenCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeachScreenCollectionViewCell.h"

@implementation WKTeachScreenCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    //self.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
    self.TeachLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
    self.TeachLabel.layer.cornerRadius = 3;
    self.TeachLabel.layer.masksToBounds = YES;
    //[self.TeachButton  setEnabled:NO];
    // Initialization code
}
@end
