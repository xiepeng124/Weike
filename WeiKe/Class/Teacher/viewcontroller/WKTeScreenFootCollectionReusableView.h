//
//  WKTeScreenFootCollectionReusableView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol TeScreenFootDelegate <NSObject>
-(void)GetSelected:(BOOL)isYes;
@end
@interface WKTeScreenFootCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *SureButton;
@property (weak,nonatomic)  id<TeScreenFootDelegate>delegate;
@end
