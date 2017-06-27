//
//  WKTeacherStyleViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherStyleViewController.h"

@interface WKTeacherStyleViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *CellNumber;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property(strong,nonatomic)MBProgressHUD *mbHUD;
@property(strong,nonatomic)MBProgressHUD *mbHUD2;
@property(strong,nonatomic)WKTabBarViewController *mainTabBar;
@property(strong,nonatomic)WKHttpTool *Tehttptool;
@property (weak, nonatomic) IBOutlet UIView *groudView;
@property (weak, nonatomic) IBOutlet UILabel *userlabel;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@end

@implementation WKTeacherStyleViewController
#pragma mark - init
-(void)initStyle{
    
    self.mbHUD=[[MBProgressHUD alloc]init];
    [self.view addSubview:self.mbHUD];
    //self.mbHUD.mode=UIPushBehaviorModeContinuous;
    self.mbHUD.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.mbHUD.label.font=[UIFont systemFontOfSize:14];
    self.mbHUD.detailsLabel.font=[UIFont systemFontOfSize:10];
    self.mbHUD2=[[MBProgressHUD alloc]init];
    [self.view addSubview:self.mbHUD2];
    //self.mbHUD.mode=UIPushBehaviorModeContinuous;
    self.mbHUD2.center=CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.mbHUD2.label.font=[UIFont systemFontOfSize:14];
    self.mbHUD2.detailsLabel.font=[UIFont systemFontOfSize:10];
    self.mbHUD2.mode=MBProgressHUDModeCustomView;
    self.mainTabBar=[[WKTabBarViewController alloc]init];
    self.groudView.layer.cornerRadius = 6;
    self.LoginButton.layer.cornerRadius = 6;
    self.LoginButton.contentEdgeInsets = UIEdgeInsetsMake(-8, 0 , 0, 0);
    self.LoginButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
    self.CellNumber.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 47)];
    self.CellNumber.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgUser = [[UIImageView alloc] initWithFrame:CGRectMake(10, 13, 19, 20)];
    imgUser.image = [UIImage imageNamed:@"register_id"];
    [self.CellNumber.leftView addSubview:imgUser];
    self.password.leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 26, 47)];
    self.password.leftViewMode = UITextFieldViewModeAlways;
    UIImageView* imgpassword = [[UIImageView alloc] initWithFrame:CGRectMake(12, 13, 17, 20)];
    imgpassword.image = [UIImage imageNamed:@"register_password"];
    [self.password.leftView addSubview:imgpassword];
    self.CellNumber.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.password.font = [UIFont fontWithName:@"PingFangSC-Regular" size:16];
    self.LoginButton.titleLabel.font = [UIFont fontWithName:@"PingFangSC-Semibold" size:18];
    self.userlabel.font = [UIFont fontWithName:@"PingFangSC-Regular" size:22];
//    CAShapeLayer *maskLayer =[CAShapeLayer layer];
//    maskLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.CellNumber.bounds byRoundingCorners:UIRectCornerBottomLeft|UIRectCornerBottomRight cornerRadii:CGSizeMake(6, 6)].CGPath;
//    self.CellNumber.layer.mask = maskLayer;
//    self.CellNumber.layer.masksToBounds = YES;
//    for(NSString *familyName in [UIFont familyNames]) {
//        
//        NSLog(@"FontFamilyName = %@", familyName);//*输出字体族科名字
//        
//        for(NSString *fontName in [UIFont fontNamesForFamilyName:familyName]) {
//            
//            NSLog(@"%@", fontName);
//        }
//    }
    
}
#pragma mark - viewdid
- (void)viewDidLoad {
    [super viewDidLoad];
    [self ClickOnTheBlankspace];
    [self initStyle];
    self.CellNumber.delegate=self;
    self.password.delegate=self;
    // Do any additional setup after loading the view.
}
-(void)viewWillDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO];
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES];
    
}
#pragma mark - 隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    NSLog(@"123");
    return YES;
    
}//Click on the blank space
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
    [self.view endEditing:YES];
}
#pragma mark - Action
- (IBAction)ClickLogin:(id)sender {
    [self.mbHUD showAnimated:YES];
    if (self.CellNumber.text.length==0) {
        self.mbHUD.mode = MBProgressHUDModeText;
        self.mbHUD.label.text=nil;
        self.mbHUD.detailsLabel.text=@"请输入手机号码";
        
    }
    else if (self.password.text.length==0){
        self.mbHUD.mode = MBProgressHUDModeText;
        self.mbHUD.label.text=nil;
        self.mbHUD.detailsLabel.text=@"请输入密码";
        
    }
    else{
        
        self.mbHUD.mode = MBProgressHUDModeIndeterminate;
        self.mbHUD.label.text=@"正在登录";
        self.mbHUD.detailsLabel.text=nil;
//        //确定请求路径
//        NSURL *url = [NSURL URLWithString:@"http://192.168.1.151:8080/wksys/index/login/"];
//        //创建可变请求对象
//        NSMutableURLRequest *requestM = [NSMutableURLRequest requestWithURL:url];
//        //修改请求方法
//        requestM.HTTPMethod = @"POST";
//        //设置请求体
//        NSString *string=[NSString stringWithFormat:@"userName=%@&password=%@",self.CellNumber.text,self.password.text];
//        requestM.HTTPBody = [string dataUsingEncoding:NSUTF8StringEncoding];
//        //创建会话对象
//        NSURLSession *session = [NSURLSession sharedSession];
//        //创建请求 Task
//        NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:requestM completionHandler:
//                                          ^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
//                                              
//                                              //解析返回的数据
//                                              NSLog(@"%@", [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
//                                          }];
//        [dataTask resume];
        NSDictionary *dic=@{@"userName":self.CellNumber.text,@"password":self.password.text};
        NSLog(@"%@",[dic objectForKey:@"userName"]);
    __weak typeof(self) weakself=self;
     [WKHttpTool postWithURLString:SERVER_LOGIN parameters:dic success:^(id responseObject) {
         //NSLog(@"%@",dic);
        // NSLog(@"responseObject=%@",responseObject);
         
         BOOL Flag=[[responseObject objectForKey:@"flag"]intValue];
//         [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"loginMsg"] forKey:@"loginMsg"];
          [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"loginUserId"] forKey:@"loginUserId"];
          [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"schSecType"] forKey:@"schSecType"];
          [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"schoolId"] forKey:@"schoolId"];
          [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"token"] forKey:@"token"];
          [[NSUserDefaults standardUserDefaults]setObject:[responseObject objectForKey:@"userType"] forKey:@"userType"];
        NSLog(@"---%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"userType"]);
//         NSLog(@"%d....",Flag);
         if (Flag==1) {
             [self.mbHUD hideAnimated:YES afterDelay:1];
             
                         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 UIImageView *view=[[UIImageView alloc]init];
                                 view.image=[UIImage imageNamed:@"success"];
                                 weakself.mbHUD2.label.text=@"登录成功";
                                 weakself.mbHUD2.detailsLabel.text=nil;
                                 weakself.mbHUD2.customView=view;
                                 [weakself.mbHUD2 showAnimated:YES];
                                 [weakself.mbHUD2 hideAnimated:YES afterDelay:2];
             
                             });
                             dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                                 UIStoryboard *mainSB = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                                 WKTabBarViewController *selfdetailVC = [mainSB instantiateViewControllerWithIdentifier:@"wktabbar"];
                               [weakself  presentViewController:selfdetailVC  animated:YES completion:nil];
                             });
             
                         });
                     
            
         }
         else{
            [self.mbHUD hideAnimated:YES afterDelay:1];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                             dispatch_async(dispatch_get_main_queue(), ^{
                                 UIImageView *view=[[UIImageView alloc]init];
                                 view.image=[UIImage imageNamed:@"defeat"];
                                 weakself.mbHUD2.label.text=@"登录失败";
                                 weakself.mbHUD2.detailsLabel.text=@"请重新输入";
                                 weakself.mbHUD2.customView=view;
                                 [weakself.mbHUD2 showAnimated:YES];
                                 [weakself.mbHUD2 hideAnimated:YES afterDelay:2];
                             });
                         });
                     }

         
         
     NSLog(@"%@",responseObject);
     } failure:^(NSError *error) {
         NSLog(@"%@",error);
         [self.mbHUD hideAnimated:YES afterDelay:1];
         dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
             dispatch_async(dispatch_get_main_queue(), ^{
                 UIImageView *view=[[UIImageView alloc]init];
                 view.image=[UIImage imageNamed:@"defeat"];
                 weakself.mbHUD2.label.text=@"访问失败";
                 weakself.mbHUD2.detailsLabel.text=nil;
                 weakself.mbHUD2.customView=view;
                 [weakself.mbHUD2 showAnimated:YES];
                 [weakself.mbHUD2 hideAnimated:YES afterDelay:2];
             });
         });

         
     }];
    }
    [self.mbHUD hideAnimated:YES afterDelay:1];
    
    
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
