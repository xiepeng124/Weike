//
//  WKRolesEditViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRolesEditViewController.h"


@interface WKRolesEditViewController ()<UITextViewDelegate,UITextFieldDelegate>

@property (strong,nonatomic)MBProgressHUD *hud;
@end

@implementation WKRolesEditViewController
-(void)initStyle{
    self.PositionLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.PositionLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.PositionLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.PositionLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 95, 40)];
    self.PositionLabel.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 40) ];
    label1.textColor = [WKColor colorWithHexString:@"666666"];
    label1.font = [UIFont fontWithName:FONT_REGULAR size:17];
    label1.textAlignment = NSTextAlignmentRight;
    label1.text = @"角色名称";
    [self.PositionLabel.leftView addSubview:label1];
    self.authorTextLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.authorTextLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.authorTextLabel.textColor = [WKColor colorWithHexString:@"333333"];
    self.authorTextLabel.leftView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 95, 40)];
    self.authorTextLabel.leftViewMode = UITextFieldViewModeAlways;
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 0, 70, 40)];
    label2.textColor = [WKColor colorWithHexString:@"666666"];
    label2.font = [UIFont fontWithName:FONT_REGULAR size:17];
    label2.textAlignment = NSTextAlignmentRight;
    label2.text = @"优先级";
    self.authorTextLabel.delegate = self;
    [self.authorTextLabel.leftView addSubview:label2];
    self.remarkTextView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.remarkTextView.font = [UIFont fontWithName:FONT_REGULAR size:17];
   
      self.remark.textColor = [WKColor colorWithHexString:@"666666"];
    self.remark.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.remark.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.keepButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.keepButton.layer.cornerRadius = 3;
    //self.remarkTextView.selectedRange = NSMakeRange(0,0);
    //self.remarkTextView.contentInset = UIEdgeInsetsMake(8.f, 0.f, -8.f, 0.f);
//    self.remarkTextView.layoutManager.allowsNonContiguousLayout = NO;
//    [self.remarkTextView scrollRangeToVisible:NSMakeRange(0,1)];
    if (self.number==2) {
        [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        [self.keepButton setBackgroundColor:[WKColor colorWithHexString:GREEN_COLOR]];
        self.keepButton.userInteractionEnabled = YES;
        self.remarkTextView.textColor = [WKColor colorWithHexString:@"333333"];
    }
    else{
    [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
     [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    self.keepButton.userInteractionEnabled = NO;
    self.remarkTextView.textColor = [WKColor colorWithHexString:@"999999"];

    }
    self.backgroundView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.backgroundView.layer.cornerRadius = 3;
    self.lineView1.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.lineView2.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.PositionLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.authorTextLabel];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextViewTextDidChangeNotification object:self.remarkTextView];
     self.automaticallyAdjustsScrollViewInsets=NO;
    self.remarkTextView.delegate = self;
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
   }
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    // Do any additional setup after loading the view.
}
-(void)textchangge:(NSNotification*)notifi{
    if (!self.PositionLabel.text.length||!self.authorTextLabel.text.length||!self.remarkTextView.text.length) {
        [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = YES ;
        
    }

   }
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入备注(不超过两百字)"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];

    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入备注(不超过两百字)";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.length==1&&text.length==0) {
        return YES;
    }
    if (self.remarkTextView.text.length<200) {
        return YES;
    }
    return NO;

}

- (IBAction)keepback:(id)sender {
    //[self.delegate comeback:self.remarkTextView.text];
    [self.hud showAnimated:YES];
    
       __weak typeof(self) weakself = self;
    if (self.number ==1) {
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"roleName":self.PositionLabel.text,@"priority":self.authorTextLabel.text,@"remark":self.remarkTextView.text};

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageAddWithParameter:dic success:^(id object) {
                NSLog(@"objec /////%@",object);
                NSNumber *flag = [object objectForKey:@"flag"];
                if ([flag isEqual:@1]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        weakself.hud.label.text = @"添加成功";
                        weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                        //[weakself.hud hideAnimated:YES afterDelay:1];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                            [self.navigationController popViewControllerAnimated:YES];
                        });
                    });

                }
                
                else{
                    weakself.hud.label.text = @"添加重复角色";
                    weakself.hud.label.textColor = [UIColor redColor];
                }
            } failed:^(id object) {
                NSLog(@"err= %@",object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"添加失败";
                    weakself.hud.label.textColor = [UIColor redColor];
                });
                
            }];
        });

    }
    if (self.number == 2) {
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"id":[NSNumber numberWithInteger:self.roleModel.id],@"roleName":self.PositionLabel.text,@"priority":self.authorTextLabel.text,@"remark":self.remarkTextView.text};

        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageEditWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"修改成功";
                    weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                    //[weakself.hud hideAnimated:YES afterDelay:1];
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self.navigationController popViewControllerAnimated:YES];
                    });
                });
                
            } failed:^(id object) {
                NSLog(@"err= %@",object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"修改失败";
                    weakself.hud.label.textColor = [UIColor redColor];
                });
                
            }];
        });

    }
        [self.hud hideAnimated:YES afterDelay:1];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (textField == self.authorTextLabel) {
        if (range.length==1&&string.length==0) {
            return YES;
        }
        if (self.authorTextLabel.text.length<4) {
            return [self validateNumber:string];

        }
        return NO;
    }
    return YES;

    }

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
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
-(void)viewWillAppear:(BOOL)animated {
    if (self.number==2) {
        self.PositionLabel.text = self.roleModel.roleName;
        self.authorTextLabel.text = [NSString stringWithFormat:@"%lu",self.roleModel.priority];
        self.remarkTextView.text = self.roleModel.remark;
    }
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.PositionLabel];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.authorTextLabel];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:self.remarkTextView];
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
