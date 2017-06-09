//
//  WKPlayTitleTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKPlayTitleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *videoName;
@property (weak, nonatomic) IBOutlet UILabel *videoLength;
@property (weak, nonatomic) IBOutlet UILabel *subjectLable;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
+ (CGFloat)heightForLabel:(NSString *)text;
@end
