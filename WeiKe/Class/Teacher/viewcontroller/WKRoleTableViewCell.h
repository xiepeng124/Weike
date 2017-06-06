//
//  WKRoleTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/6.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol RolesDelegate <NSObject>
-(void)ChangeRoles:(UIButton*)button;
-(void)ChangeRolesImformation:(UIButton*)button;
-(void)changeBatchDelete:(UIButton*)button;
-(void)BindUser:(UIButton*)button;
@end

@interface WKRoleTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *roleName;
@property (weak, nonatomic) IBOutlet UILabel *level;
@property (weak, nonatomic) IBOutlet UILabel *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *bindButton;
@property (weak, nonatomic) IBOutlet UIButton *authorizeButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) id<RolesDelegate>delegate;
+ (CGFloat)heightForLabel:(NSString *)text;
@end
