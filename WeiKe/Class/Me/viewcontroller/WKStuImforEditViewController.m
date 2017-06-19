//
//  WKStuImforEditViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKStuImforEditViewController.h"

#import "WKStudentImforHeaderView.h"
#import "WKMeHandler.h"
#import "WKUploadImage.h"
@interface WKStuImforEditViewController ()<UITextFieldDelegate,upImageDelegate>
@property(nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong) WKStudentImforHeaderView *stuImf;
@property (nonatomic,strong) WKUploadImage *uploadImage;
@property (nonatomic,strong) NSString *imageS;
@property (nonatomic,strong) WKStudentData *dataModel;
@property (nonatomic,strong) MBProgressHUD *hud;
@end

@implementation WKStuImforEditViewController

-(void)initTableView{
    self.stuImf = [[WKStudentImforHeaderView alloc]init];
    self.stuImf= [[[NSBundle mainBundle]loadNibNamed:@"StudentImformationView" owner:nil options:nil]lastObject];
    self.stuImf.frame = CGRectMake(0, 0, SCREEN_WIDTH, 577);
    self.stuImf.cardIdText.delegate =self;
    self.stuImf.phoneNumText.delegate = self;
    self.stuImf.emailText.delegate =self;
    self.stuImf.cardIdText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.stuImf.phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    self.stuImf.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.stuImf.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.tableHeaderView = self.stuImf;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.mytableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.nametext];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.cardIdText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.emailText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.stuImf.phoneNumText];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchImageAction)];
    self.stuImf.headImageView.userInteractionEnabled = YES;
    [self.stuImf.headImageView addGestureRecognizer:ges];
    [self.stuImf.keepButton addTarget:self action:@selector(keepMydataAction) forControlEvents:UIControlEventTouchUpInside ];
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
                WKStudentData *model = object;
                weakSelf.stuImf.nametext.text = model.studentName;
                weakSelf.stuImf.cardIdText.text = model.idCode;
                weakSelf.stuImf.phoneNumText.text = model.moblePhone;
                weakSelf.stuImf.emailText.text = model.email;
                [weakSelf.stuImf.headImageView sd_setImageWithURL:[NSURL URLWithString:model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"xie"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
                if (model.gender ==1) {
                    weakSelf.stuImf.sexSegment.selectedSegmentIndex = 0;
                }
                else{
                    weakSelf.stuImf.sexSegment.selectedSegmentIndex = 1;
                    
                }
                weakSelf.stuImf.StuGradeText.text = model.gradeName;
                weakSelf.stuImf.stuClassText.text = model.className;
                weakSelf.stuImf.stuNumberText.text  =model.studyNo;
                weakSelf.stuImf.schoolRollText.text  = model.schoolNo;
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
    if (!self.stuImf.nametext.text.length||!self.stuImf.cardIdText.text.length||!self.stuImf.emailText.text.length||!self.stuImf.phoneNumText.text.length) {
        [self.stuImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.stuImf.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.stuImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.stuImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.stuImf.keepButton.userInteractionEnabled = YES ;
        
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
    if (textField== self.stuImf.cardIdText) {
        
        //return NO;
        
        return [self validateNumber:string];
        
    }
    if (textField == self.stuImf.phoneNumText) {
        
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
    [self.stuImf.headImageView sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"imgFileUrl"] ] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.imageS = [Imgestring objectForKey:@"imgFileUrl"];
    
}

-(void)sendImagesource:(NSString *)sourceName{
    
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.stuImf.nametext];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.stuImf.cardIdText];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.stuImf.phoneNumText];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.stuImf.emailText];
}
-(void)keepMydataAction{
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"token":TOKEN,@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:self.dataModel.id],@"imgFileUrl":self.imageS,@"gender":[NSNumber numberWithInteger:self.stuImf.sexSegment.selectedSegmentIndex+1],@"idCode":self.stuImf.cardIdText.text,@"mobilePhone":self.stuImf.phoneNumText.text,@"email":self.stuImf.emailText.text,@"studentName":self.stuImf.nametext.text};
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
