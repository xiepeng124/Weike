//
//  WKPlaycommentTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKPlaycommentTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headPhoto;
@property (weak, nonatomic) IBOutlet UILabel *stuName;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UIButton *replyButton;
@property (weak, nonatomic) IBOutlet UILabel *commmentLabel;
@property (weak, nonatomic) IBOutlet UITableView *replyTableView;

@end
