//
//  WKCommentSectionView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCommentSectionView : UIView
@property (weak, nonatomic) IBOutlet UILabel *stuComment;
@property (weak, nonatomic) IBOutlet UILabel *commentCount;
@property (weak, nonatomic) IBOutlet UITextField *myComment;
@property (weak, nonatomic) IBOutlet UIButton *commentbutton;

@end
