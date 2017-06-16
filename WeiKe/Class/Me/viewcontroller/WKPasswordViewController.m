//
//  WKPasswordViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKPasswordViewController.h"
#import "WKMeHandler.h"
@interface WKPasswordViewController ()
@property (weak, nonatomic) IBOutlet UILabel *oldPassword;
@property (weak, nonatomic) IBOutlet UILabel *againPassword;
@property (weak, nonatomic) IBOutlet UILabel *newpass;
@property (weak, nonatomic) IBOutlet UITextField *oldPassText;
@property (weak, nonatomic) IBOutlet UITextField *newpassText;
@property (weak, nonatomic) IBOutlet UITextField *againpassText;
@property (weak, nonatomic) IBOutlet UIView *oneLine;
@property (weak, nonatomic) IBOutlet UIView *twoLine;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (weak, nonatomic) IBOutlet UIView *backview;
@property (strong ,nonatomic) MBProgressHUD *hud;
@end

@implementation WKPasswordViewController
-(void)initStyle{
    self.oldPassword.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.newpass.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.againPassword.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.oneLine.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.twoLine.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.oldPassText.textColor = [WKColor colorWithHexString:@"333333"];
    self.newpassText.textColor = [WKColor colorWithHexString:@"333333"];
    self.againpassText.textColor = [WKColor colorWithHexString:@"333333"];
    [self.keepButton addTarget:self action:@selector(keepPasswordAction) forControlEvents:UIControlEventTouchUpInside ];
    self.keepButton.layer .cornerRadius = 3;
    [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.keepButton.userInteractionEnabled = NO;
    self.hud = [[MBProgressHUD alloc]init];
       [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.oldPassText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.newpassText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.againpassText];
    self.backview.layer.cornerRadius = 3;
    self.backview.layer.masksToBounds = YES;


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewDidAppear:(BOOL)animated{
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
   
    [self.view addSubview:self.hud];

}
-(void)textchangge:(NSNotification*)noti{
    if (!self.oldPassText.text.length||!self.newpassText.text.length||!self.againpassText.text.length) {
        [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = NO;

    }
    else{
        [self.keepButton setBackgroundColor:[WKColor colorWithHexString:GREEN_COLOR]];
        [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = YES;
    }
}
-(void)keepPasswordAction{
     self.hud.label.text = @"正在保存";
    [self.hud showAnimated:YES];
    if ([self.newpassText.text isEqualToString:self.againpassText.text]) {
        NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"oldPassword":self.oldPassText.text,@"newPassword":self.newpassText.text,@"newPassword2":self.againpassText.text};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKMeHandler executeGetMyPasswordWithParameter:dic success:^(id object) {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                if ([[object objectForKey:@"flag"]integerValue]) {
                                    weakself.hud.label.text = @"保存成功";
                                    [weakself.hud hideAnimated:YES afterDelay:1];
                                    [weakself.navigationController popViewControllerAnimated:YES];
                                }
                                else{
                                    weakself.hud.label.text = @"密码错误";
                                    [weakself.hud hideAnimated:YES afterDelay:1];

                                }
                            });
            } failed:^(id object) {
                weakself.hud.label.text = @"保存失败";
                [weakself.hud hideAnimated:YES afterDelay:1];

            }];

        });
    }
    else{
        self.hud.label.text = @"请保存新密码输入一致";
        [self.hud hideAnimated:YES afterDelay:1];
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.oldPassText];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.newpassText];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.againpassText];
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
