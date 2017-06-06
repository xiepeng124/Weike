//
//  WKVideoTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoTableViewCell.h"

@implementation WKVideoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectedButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    self.titleLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.videoImage.layer.cornerRadius = 3;
    self.videoImage.layer.masksToBounds = YES;
    self.promulgator.font = [UIFont fontWithName:FONT_REGULAR size:12];
    self.promulgator.textColor = [WKColor colorWithHexString:@"666666"];
    self.subject.font = [UIFont fontWithName:FONT_REGULAR size:12];
    self.subject.textColor = [WKColor colorWithHexString:@"666666"];
    self.stateLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    self.stateLabel.textColor = [WKColor colorWithHexString:@"72c456"];
    [self.adButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
     [self.promuButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    [self.adButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
     [self.promuButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.adButton.layer.cornerRadius = 3;
    self.promuButton.layer.cornerRadius = 3;
    
    // Initialization code
}
- (IBAction)selectAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    [self.delegate selctedVideo:sender];
}
+ (CGFloat)widthForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    //NSLog(@"width = %f,heght = %f",rect.size.width,rect.size.height);
    return rect.size.width;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
