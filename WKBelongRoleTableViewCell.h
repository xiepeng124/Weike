//
//  WKBelongRoleTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKBelongRoleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UILabel *priortyLabel;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
+ (CGFloat)heightForLabel:(NSString *)text;
@end
