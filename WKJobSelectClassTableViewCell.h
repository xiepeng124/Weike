//
//  WKJobSelectClassTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKJobSelectClassTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *classlabel;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (assign ,nonatomic) NSInteger cellSection;
@end
