//
//  WKStudentStyleViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKStudentStyleViewController.h"
#import "WKTabBarViewController.h"
@interface WKStudentStyleViewController ()<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *IDcard;
@property (weak, nonatomic) IBOutlet UITextField *Password;
@property(strong,nonatomic)MBProgressHUD *mbHUD;
@property(strong,nonatomic)MBProgressHUD *mbHUD2;
@property(strong,nonatomic)WKTabBarViewController *mainTabBar;
@end

@implementation WKStudentStyleViewController
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
    //self.mbHUD.minShowTime=5;
    
}
#pragma mark - viewdid
- (void)viewDidLoad {
    [super viewDidLoad];
    self.IDcard.delegate=self;
    self.Password.delegate=self;
    [self ClickOnTheBlankspace];
    [self initStyle];
    //[self ClickLogin:<#(id)#>];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (self.IDcard.text.length==0) {
        self.mbHUD.mode = MBProgressHUDModeText;
        self.mbHUD.label.text=nil;
        self.mbHUD.detailsLabel.text=@"请输入身份证号码";
        
    }
    else if (self.Password.text.length==0){
        self.mbHUD.mode = MBProgressHUDModeText;
        self.mbHUD.label.text=nil;
        self.mbHUD.detailsLabel.text=@"请输入密码";
        
    }
    else{
        
        self.mbHUD.mode = MBProgressHUDModeIndeterminate;
        self.mbHUD.label.text=@"正在登录";
        self.mbHUD.detailsLabel.text=nil;
        if ([self.IDcard.text isEqual:@"xiepeng"]&&[self.Password.text isEqual:@"123456"]) {
            //[self.mbHUD showAnimated:YES];
            [self.mbHUD hideAnimated:YES afterDelay:1];
            __weak typeof(self) weakself=self;
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
            
        }else{
            [self.mbHUD hideAnimated:YES afterDelay:1];
            __weak typeof(self) weakself=self;
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
    }
    [self.mbHUD hideAnimated:YES afterDelay:1];
    
    
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
