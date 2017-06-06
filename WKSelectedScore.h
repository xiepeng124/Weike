//
//  WKSelectedScore.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKSelectedScore : UIView
@property (weak, nonatomic) IBOutlet UILabel *scoreTitle;
@property (weak, nonatomic) IBOutlet UIPickerView *pikerView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *sureButton;

@end
