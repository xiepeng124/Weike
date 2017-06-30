//
//  WKBelongRoleTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBelongRoleTableViewCell.h"

@implementation WKBelongRoleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    self.layer.masksToBounds = YES;
    [self.selectedButton setImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectedButton setImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];;
    self.roleName.textColor = [WKColor colorWithHexString:@"333333"];
    self.priortyLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.remarkLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.remarkLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.lineView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    // Initialization code
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH -40, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
