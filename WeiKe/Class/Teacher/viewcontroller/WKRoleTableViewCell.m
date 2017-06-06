//
//  WKRoleTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/6.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRoleTableViewCell.h"

@implementation WKRoleTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.layer.cornerRadius = 3;
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [self.selectButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    self.roleName.textColor= [WKColor colorWithHexString:@"333333"];
    self.roleName.font = [UIFont fontWithName:FONT_REGULAR size:16];
    self.level.textColor = [WKColor colorWithHexString:@"666666"];
    self.level.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.levelLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.levelLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.contentLabel.textColor =[WKColor colorWithHexString:@"666666"];
    //self.contentLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.deleteButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
     [self.deleteButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.deleteButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.deleteButton.layer.cornerRadius = 3;
    self.editButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
   [self.editButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.editButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.editButton.layer.cornerRadius = 3;
    self.bindButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    [self.bindButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.bindButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.bindButton.layer.cornerRadius = 3;
    self.authorizeButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
   [self.authorizeButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.authorizeButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.authorizeButton.layer.cornerRadius = 3;
    self.lineView.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    [self.selectButton addTarget:self action:@selector(changgeSelected) forControlEvents:UIControlEventTouchUpInside];
    
//    [self.editButton addTarget:self action:@selector(<#selector#>) forControlEvents:<#(UIControlEvents)#>]
    // Initialization code
}
-(void)changgeSelected{
    self.selectButton.selected = !self.selectButton.selected;
    [self.delegate changeBatchDelete:self.selectButton];
}
- (IBAction)deleteUser:(UIButton *)sender {
    [self.delegate ChangeRoles:sender];
}
- (IBAction)changeUserImformation:(UIButton *)sender {
    [self.delegate ChangeRolesImformation:sender];
}
- (IBAction)BindRoles:(UIButton *)sender {
    [self.delegate BindUser:sender];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
+ (CGFloat)heightForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(SCREEN_WIDTH - 50, 0) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    
    return rect.size.height;
}
@end
