//
//  WKTeacherHeaderCollectionReusableView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKTeScreenFootCollectionReusableView.h"
@protocol TeacherHeaderDelegate <NSObject>
-(void)ChangeBottom:(UIButton*)selected;
-(void)ChanggeMyteacher:(UIButton*)selected;
@end
@interface WKTeacherHeaderCollectionReusableView : UICollectionReusableView
@property (weak, nonatomic) IBOutlet UILabel *garde;
@property (weak, nonatomic) IBOutlet UILabel *course;
@property (weak, nonatomic) IBOutlet UIButton *selectedbutton;
@property (weak, nonatomic) IBOutlet UILabel *myteacher;
@property (weak, nonatomic) IBOutlet UIButton *bottomButton;
@property (weak ,nonatomic) id<TeacherHeaderDelegate>delegate;

@end
