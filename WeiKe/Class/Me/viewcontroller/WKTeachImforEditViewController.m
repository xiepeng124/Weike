//
//  WKTeachImforEditViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeachImforEditViewController.h"
#import "WKTeacherImformation.h"
#import "WKCheackModel.h"
#import "WKMeHandler.h"
#import "WKUploadImage.h"
@interface WKTeachImforEditViewController ()<UITextFieldDelegate,upImageDelegate>
@property(nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong) WKTeacherImformation *teachImf;
@property (nonatomic,strong) WKUploadImage *uploadImage;
@property (nonatomic,strong) NSString *imageS;
@property (nonatomic,strong) WKTeacherData *dataModel;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation WKTeachImforEditViewController
-(void)initTableView{
    self.teachImf = [[WKTeacherImformation alloc]init];
    self.teachImf = [[[NSBundle mainBundle]loadNibNamed:@"TeacherImformationHeaderView" owner:nil options:nil]lastObject];
    self.teachImf.frame = CGRectMake(0, 0, SCREEN_WIDTH, 595);
    self.teachImf.cardIdText.delegate =self;
    self.teachImf.phoneNumText.delegate = self;
    self.teachImf.emailText.delegate =self;
    self.teachImf.cardIdText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
     self.teachImf.phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    self.teachImf.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.teachImf.backgroundColor = [WKColor colorWithHexString:@"4481c2"];
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.tableHeaderView = self.teachImf;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.mytableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.nametext];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.cardIdText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.emailText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.phoneNumText];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchImageAction)];
    self.teachImf.headImageView.userInteractionEnabled = YES;
    [self.teachImf.headImageView addGestureRecognizer:ges];
    [self.teachImf.keepButton addTarget:self action:@selector(keepMydataAction) forControlEvents:UIControlEventTouchUpInside ];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"正在保存";
    [self.view addSubview:self.hud];


}
-(void)initData{
    NSDictionary *dic  =@{@"token":TOKEN};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKMeHandler executeGetMyDataWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                WKTeacherData *model = object;
                weakSelf.teachImf.nametext.text = model.teacherName;
                weakSelf.teachImf.cardIdText.text = model.idCode;
                weakSelf.teachImf.phoneNumText.text = model.moblePhone;
                weakSelf.teachImf.emailText.text = model.email;
                [weakSelf.teachImf.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
                if (model.gender ==1) {
                    weakSelf.teachImf.sexSegment.selectedSegmentIndex = 0;
                }
                else{
                    weakSelf.teachImf.sexSegment.selectedSegmentIndex = 1;

                }
                weakSelf.teachImf.teachGradeText.text = model.gradeName;
                weakSelf.teachImf.teachClassText.text = model.className;
                weakSelf.teachImf.jobText.text  =model.positionName;
                weakSelf.teachImf.subjectText.text  = model.courseName;
                weakSelf.dataModel = model;
            });
        } failed:^(id object) {
            
        }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initData];
    self.uploadImage = [WKUploadImage shareManager];
    self.uploadImage.url =MY_HEAD;
   
    NSDictionary *dic = @{@"userType":USERTYPE};
    self.uploadImage.diction = dic;
    self.imageS = @"";

    // Do any additional setup after loading the view.
}
-(void)textchangge:(NSNotification*)notifi{
    if (!self.teachImf.nametext.text.length||!self.teachImf.cardIdText.text.length||!self.teachImf.emailText.text.length||!self.teachImf.phoneNumText.text.length) {
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = YES ;
        
    }
    
}

//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
//    if (textField.text.length>11) {
//        return NO;
//    }
//    return YES;
//}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSLog(@"string = %@",string);
    if (textField== self.teachImf.cardIdText) {
        
            //return NO;

          return [self validateNumber:string];
        
    }
    if (textField == self.teachImf.phoneNumText) {
        
        return [self validateNumber:string];
    }
    
    return YES;
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
-(void)switchImageAction{
    [self.uploadImage selectUserpicSourceWithViewController:self];
    self.uploadImage.delegate = self;
}
-(void)selctedImage:(NSDictionary*)Imgestring{
    [self.teachImf.headImageView sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"imgFileUrl"] ] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.imageS = [Imgestring objectForKey:@"imgFileUrl"];

}

-(void)sendImagesource:(NSString *)sourceName{
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.teachImf.nametext];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.teachImf.cardIdText];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.teachImf.phoneNumText];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.teachImf.emailText];
}
-(void)keepMydataAction{
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"token":TOKEN,@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:self.dataModel.id],@"imgFileUrl":self.imageS,@"gender":[NSNumber numberWithInteger:self.teachImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.teachImf.cardIdText.text,@"mobilePhone":self.teachImf.phoneNumText.text,@"email":self.teachImf.emailText.text,@"teacherName":self.teachImf.nametext.text};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyDataKeepWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                     weakself.hud.label.text = @"保存成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else{
                    weakself.hud.label.text = @"保存失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];

                }
            });
        } failed:^(id object) {
            weakself.hud.label.text = @"保存失败";
            [weakself.hud hideAnimated:YES afterDelay:1];
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