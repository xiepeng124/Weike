//
//  WKJobTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobTableViewCell.h"

@implementation WKJobTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.roleName.textColor= [WKColor colorWithHexString:@"333333"];
    self.roleName.font = [UIFont fontWithName:FONT_REGULAR size:16];
    self.contentLabel.textColor =[WKColor colorWithHexString:@"666666"];
    self.promulgator.textColor =[WKColor colorWithHexString:@"666666"];
    self.schoolYear.textColor =[WKColor colorWithHexString:@"666666"];
    //self.contentLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.deleteButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.deleteButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.deleteButton.layer.cornerRadius = 3;
    self.editButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.editButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.editButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.editButton.layer.cornerRadius = 3;
    self.scoreButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.scoreButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.scoreButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.scoreButton.layer.cornerRadius = 3;
    self.downloadButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.downloadButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.downloadButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.downloadButton.layer.cornerRadius = 3;
    self.line.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 40, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;
}

@end
