//
//  WKReplyTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKReplyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *replyLabel;

+ (CGFloat)heightForLabel:(NSString *)text;
@end
