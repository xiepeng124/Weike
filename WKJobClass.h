//
//  WKJobClass.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FoldSectionHeaderViewDelegate <NSObject>

- (void)foldHeaderforbutton:(UIButton*)sender;
- (void)foldHeaderselectedbutton:(UIButton*)sender;

@end

@interface WKJobClass : UIView
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UIButton *updownButton;
@property (weak ,nonatomic) id<FoldSectionHeaderViewDelegate>delegate;

@end
