//
//  WKViewingTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/15.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKViewingTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *teacherName;
@property (weak, nonatomic) IBOutlet UILabel *subject;

@end
