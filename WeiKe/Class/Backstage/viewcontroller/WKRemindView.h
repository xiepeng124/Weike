//
//  WKRemindView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKRemindView : UIView
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeLabel;
@property (weak, nonatomic) IBOutlet UILabel *fourLabel;
@property (weak, nonatomic) IBOutlet UILabel *fiveLabel;
+ (CGFloat)heightForLabel:(NSString *)text;
@end
