//
//  WKMessageOneTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKMessageOneTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *commentImage;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UIButton *watchAllButton;
@property (weak, nonatomic) IBOutlet UIButton *allCommentButton;

@end
