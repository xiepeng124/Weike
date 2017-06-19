//
//  WKMessageTwoTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKMessageTwoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *messageImage;
@property (weak, nonatomic) IBOutlet UILabel *messageTitle;
@property (weak, nonatomic) IBOutlet UILabel *messageTime;
@property (weak, nonatomic) IBOutlet UIButton *messageDelete;
@property (weak, nonatomic) IBOutlet UIView *line;
@property (weak, nonatomic) IBOutlet UILabel *messageContent;
+ (CGFloat)heightForLabel:(NSString *)text;
@end
