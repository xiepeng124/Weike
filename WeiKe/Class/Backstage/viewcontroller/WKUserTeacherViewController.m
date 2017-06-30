//
//  WKUserTeacherViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUserTeacherViewController.h"
#import "WKCheackModel.h"
@interface WKUserTeacherViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *acountLabel;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UITextField *acountText;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (strong,nonatomic) MBProgressHUD *hud;

@end

@implementation WKUserTeacherViewController
#pragma mark - init (初始化)
-(void)initStyle{
    self.acountLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.emailLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.acountText.textColor = [WKColor colorWithHexString:@"333333"];
    self.emailText.textColor = [WKColor colorWithHexString:@"333333"];
    self.lineView.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    [self. keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.keepButton.layer.cornerRadius = 3;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mytextchange:) name:UITextFieldTextDidChangeNotification object:self.acountText];
//    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(mytextchange:) name:UITextFieldTextDidChangeNotification object:self.emailText];
    self.acountText.delegate = self;
    self.acountText.keyboardType = UIKeyboardTypePhonePad;
    self.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.acountText.text = _model.moblePhone;
    self.emailText.text =_model.email;
    [self.keepButton addTarget:self action:@selector(keepUserAction) forControlEvents:UIControlEventTouchUpInside];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode =  MBProgressHUDModeIndeterminate;
    [self.hud sizeToFit];
    [self.view addSubview:self.hud];

    //self.emailText.delegate = self;
}
-(void)initData{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark - 通知
-(void)mytextchange:(NSNotification*)noti{
    if (!self.acountText.text.length) {
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

    if (textField==self.acountText) {
        if (self.acountText.text.length<11) {
            return [self validateNumber:string];
        }
        return NO;
    }
    return NO;
}
- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
#pragma mark - Action
-(void)keepUserAction{
    if (![WKCheackModel checkTelNumber:self.acountText.text]) {
        self.hud.label.text = @"请输入正确的手机号";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    if (![WKCheackModel IsEmailAdress:self.emailText.text]&&self.emailText.text.length) {
        self.hud.label.text = @"请输入正确的邮箱";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    NSDictionary *dic = @{@"teacherId":[NSNumber numberWithInteger:_model.teacherId],@"id":[NSNumber numberWithInteger:_model.id],@"userName":self.acountText.text,@"email":self.emailText.text,@"loginUserId":LOGINUSERID};
    self.hud.label.text = @"正在保存";

    [self.hud showAnimated:YES];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserTeacherWithParameter:dic success:^(id object) {
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
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.acountText];
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
