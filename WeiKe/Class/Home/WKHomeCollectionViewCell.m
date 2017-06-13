//
//  WKHomeCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHomeCollectionViewCell.h"

@implementation WKHomeCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.borderWidth=0.5;
    self.layer.borderColor=[UIColor lightGrayColor].CGColor;
    self.layer.cornerRadius=3;
    self.Title.font = [UIFont fontWithName:FONT_REGULAR size:14];
    self.Title.textColor = [WKColor colorWithHexString:@"333333"];
    self.TeacherName.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.TeacherName.textColor = [WKColor colorWithHexString:@"4481c2"];
    
    self.gradeLabel.font = [UIFont fontWithName:FONT_REGULAR size:11];
    self.gradeLabel.textColor = [WKColor colorWithHexString:@"999999"];
    [self.outLinkButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.outLinkButton.layer.cornerRadius =3;
    self.outLinkButton.userInteractionEnabled = YES;
    //self.gradeLabel.adjustsFontSizeToFitWidth = YES;
//    self.layer.shadowOffset = CGSizeMake(1, 1);
//    self.layer.shadowColor = [UIColor redColor].CGColor;
//    self.layer.shadowOpacity = 0.5;
    //self.layer.shadowRadius =5;
    //
    // Initialization code
}

@end
