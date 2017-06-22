//
//  WKSelectSchoolTypeView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/22.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKSelectSchoolTypeView : UIView
@property (weak, nonatomic) IBOutlet UIView *middleView;
@property (weak, nonatomic) IBOutlet UILabel *middleLabel;
@property (weak, nonatomic) IBOutlet UILabel *englishLabel;
@property (weak, nonatomic) IBOutlet UIView *orView;
@property (weak, nonatomic) IBOutlet UIView *highView;
@property (weak, nonatomic) IBOutlet UILabel *highLabel;

@property (weak, nonatomic) IBOutlet UILabel *highEngLabel;
@property (assign,nonatomic) BOOL ismiddle;
@end
