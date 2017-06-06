//
//  WKRoleBindTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RolesBindDelegate <NSObject>
-(void)changeBindOrUn:(UIButton*) button;
-(void)unBindUser:(UIButton*) button;
@end

@interface WKRoleBindTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UIButton *unBind;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *cellid;
@property (weak, nonatomic) IBOutlet UILabel *emailid;
@property (weak,nonatomic) id<RolesBindDelegate>delegate;
@end
