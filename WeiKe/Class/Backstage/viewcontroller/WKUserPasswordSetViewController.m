//
//  WKUserPasswordSetViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUserPasswordSetViewController.h"

@interface WKUserPasswordSetViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *passwordLabel;
@property (weak, nonatomic) IBOutlet UILabel *againPassLabel;
@property (weak, nonatomic) IBOutlet UITextField *passwordText;
@property (weak, nonatomic) IBOutlet UITextField *againPassText;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UIView *myView;
@property (strong,nonatomic) MBProgressHUD *hud;

@end

@implementation WKUserPasswordSetViewController
#pragma mark - init
-(void)initStyle{
    self.passwordLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.againPassLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.passwordText.textColor = [WKColor colorWithHexString:@"333333"];
    self.againPassText.textColor = [WKColor colorWithHexString:@"333333"];
    self.lineView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.myView.layer.cornerRadius = 3;
    self.myView.layer.masksToBounds = YES;
    [self. keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR ] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.keepButton.userInteractionEnabled = NO;
    self.keepButton.layer.cornerRadius = 3;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mytextchange:) name:UITextFieldTextDidChangeNotification object:self.passwordText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mytextchange:) name:UITextFieldTextDidChangeNotification object:self.againPassText];
    [self.keepButton addTarget:self action:@selector(keepUserAction) forControlEvents:UIControlEventTouchUpInside];

    self.passwordText.delegate = self;
    self.againPassText.delegate = self;
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode =  MBProgressHUDModeIndeterminate;
    [self.hud sizeToFit];
    [self.view addSubview:self.hud];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 通知
-(void)mytextchange:(NSNotification*)noti{
    if (!self.passwordText.text.length||!self.againPassText.text.length) {
        [self. keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR ] forState:UIControlStateNormal];
        self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
        self.keepButton.userInteractionEnabled = NO;
        
    }
    else{
        [self. keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
        self.keepButton.userInteractionEnabled = YES;
        
    }
}
#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if (range.length==1&&string.length==0) {
        return YES;
    }
    if (textField.text.length<18&&![string isEqualToString:@" "]) {
        return YES;
    }
    return NO;
}
#pragma mark - Action
-(void)keepUserAction{
    if (![self.passwordText.text isEqualToString:self.againPassText.text]) {
        self.hud.label.text = @"请保持密码输入一致";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
       NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:_model.id],@"loginUserId":LOGINUSERID,@"newPassword":self.passwordText.text};
    self.hud.label.text = @"正在保存";
    
    [self.hud showAnimated:YES];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserPasswordSetWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = [object objectForKey:@"msg"];
                [weakself.hud hideAnimated:YES afterDelay:1];
                if ([[object objectForKey:@"flag"]integerValue]) {
                    sleep(1);
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                
                
                
            });
        } failed:^(id object) {
            
        }];
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
