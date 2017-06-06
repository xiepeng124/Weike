//
//  WKJobTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKJobTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *promulgator;
@property (weak, nonatomic) IBOutlet UILabel *schoolYear;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UIButton *scoreButton;
@property (weak, nonatomic) IBOutlet UIView *line;
+ (CGFloat)heightForLabel:(NSString *)text;

@end
