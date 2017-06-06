//
//  WKRolesEditViewController.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"
#import "WKBackstage.h"
#import "WKRolesModel.h"
@protocol RolesEditDelegate <NSObject>
-(void)comeback:(NSString*)string;
@end
@interface WKRolesEditViewController : WKBaseViewController
@property (weak, nonatomic) IBOutlet UITextField *PositionLabel;
@property (weak, nonatomic) IBOutlet UITextField *authorTextLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UIView *lineView1;
@property (weak, nonatomic) IBOutlet UIView *lineView2;
@property (weak ,nonatomic) id<RolesEditDelegate>delegate;
@property (assign ,nonatomic) int number;
@property (strong,nonatomic) WKRolesModel *roleModel;
@end
