//
//  WKJobEditViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobEditViewController.h"
#import "WKUploadImage.h"
#import "WKSelectedJoinClassViewController.h"
@interface WKJobEditViewController ()<UITextFieldDelegate,UITextViewDelegate,upImageDelegate,SelectClassViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *jobName;
@property (weak, nonatomic) IBOutlet UILabel *jobFile;
@property (weak, nonatomic) IBOutlet UILabel *jobDuring;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UITextField *jobNameText;
@property (weak, nonatomic) IBOutlet UIButton *jobFileButton;
@property (weak, nonatomic) IBOutlet UITextField *duringText;
@property (weak, nonatomic) IBOutlet UITextView *remarkText;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (strong,nonatomic) WKUploadImage *uploadImage;
@property (weak, nonatomic) IBOutlet UILabel *joinClass;
@property (weak, nonatomic) IBOutlet UITextField *classText;
@property (weak, nonatomic) IBOutlet UIButton *selctedButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *JoinH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *selectedH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *ClassH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property(strong,nonatomic) NSString *gradeAndclass;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *upBuutonW;
@property (strong,nonatomic) MBProgressHUD *hud;
@end
@implementation WKJobEditViewController
-(void)initStyle{
    self.jobName.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.jobFile.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.jobDuring.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.remark.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.joinClass.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.jobNameText.textColor = [WKColor colorWithHexString:@"333333"];
    self.duringText.textColor = [WKColor colorWithHexString:@"333333"];
    if (_isAdd) {
         self.remarkText.textColor = [WKColor colorWithHexString:@"999999"];
    }
    else{
    self.remarkText.textColor = [WKColor colorWithHexString:@"333333"];
    }
    self.classText.textColor = [WKColor colorWithHexString:@"333333"];
    self.classText.enabled = NO;
    self.line1.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
     self.line2.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
     self.line3.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    [self.selctedButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.selctedButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selctedButton.layer.cornerRadius =3 ;
    [self.jobFileButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.jobFileButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.jobFileButton.layer.cornerRadius =3 ;
    [self.jobFileButton addTarget:self action:@selector(uploadJobAction) forControlEvents:UIControlEventTouchUpInside];
    self.duringText.delegate =self;
    self.remarkText.delegate =self;
    if (self.isAdd) {
        self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
        [self.keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = NO;
    }
    else{
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.keepButton.userInteractionEnabled = YES;
    }
    if (!_isAdd) {
        self.jobNameText.text = self.jobModel.taskName;
        self.duringText.text = [NSString stringWithFormat:@"%lu",self.jobModel.deliveryDeadline];
        self.remarkText.text = self.jobModel.remark;
        [self.jobFileButton setTitle:@"点击替换" forState:UIControlStateNormal];

      
    }
  
    
    [self.keepButton addTarget:self action:@selector(keepJobAction) forControlEvents:UIControlEventTouchUpInside];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.jobNameText];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.duringText];
      [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextViewTextDidChangeNotification object:self.remarkText];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"正在保存";
    [self.view addSubview:self.hud];

  
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    self.uploadImage = [WKUploadImage shareManager];
    self.uploadImage.diction = @{@"loginUserId":LOGINUSERID};
    self.uploadImage.url = JOB_UPLOAD;
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    if (!self.isAdd) {
        self.JoinH.constant = 0;
        self.lineH.constant = 0;
        self.ClassH.constant = 0;
        self.selectedH.constant = 0;
        self.mainView.constant-=36;
    }
}
-(void)uploadJobAction{
    [self.uploadImage selectUserpicSourceWithViewController:self];
    self.uploadImage.delegate = self;
}
-(void)selctedImage:(NSDictionary*)Imgestring{
    self.jobModel.taskAppendUrl = [Imgestring objectForKey:@"taskAppendUrl"];
    self.jobModel.targetName = [Imgestring objectForKey:@"targetName"];
    [self.jobFileButton setTitle:self.jobModel.sourceName forState:UIControlStateNormal];
    NSString *string;
    if (self.jobModel.sourceName.length>20) {
        string = [self.jobModel.sourceName substringToIndex:20];
    }
    else{
        string = self.jobModel.sourceName;
    }
    self.upBuutonW.constant = [self widthForLabel:string]+10;
   
}
-(void)sendImagesource:(NSString *)sourceName{
    self.jobModel.sourceName = sourceName;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (range.length==1&&string.length==0) {
        return YES;
    }

    if (self.duringText.text.length<4) {
         return [self validateNumber:string];
    }
    return NO;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    if (range.length==1&&text.length==0) {
        return YES;
    }

    if (self.remark.text.length<200) {
        return YES;
    }
    return NO;
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
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入备注(不超过200字)"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入备注(不超过200字)";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}
-(void)textchangge{
    NSLog(@"self.remark.text =%@",self.remark.text);
    if (!self.jobNameText.text.length||!self.duringText.text.length||!self.remarkText.text.length||[self.remarkText.text isEqualToString:@"请输入备注(不超过200字)"]) {
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
- (IBAction)selectedClassAction:(id)sender {
    WKSelectedJoinClassViewController *selected = [[WKSelectedJoinClassViewController alloc]init];
    [self.navigationController pushViewController:selected animated:YES];
    selected.isShare = NO ;
    selected.delegate = self;
}
-(void)keepJobAction{
  
    if (!self.classText.text.length&&self.isAdd) {
        self.hud.label. text = @"请选择参与班级";
          [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    if ([self.jobFileButton.currentTitle isEqualToString:@"点击上传"]) {
        self.hud.label. text = @"请选择上传作业";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;

    }
    else{
        self.hud.label. text = @"正在保存";
        [self.hud showAnimated:YES];
    if (!self.isAdd ) {
        NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"id":[NSNumber numberWithInteger:self.jobModel.id],@"taskName":self.jobNameText.text,@"deliveryDeadline":self.duringText.text,@"remark":self.remarkText.text,@"taskAppendUrl":self.jobModel.taskAppendUrl,@"targetName":self.jobModel.targetName,@"sourceName":self.jobModel.sourceName};
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageIJobEditKeepWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([[object objectForKey:@"flag"]intValue]) {
                        weakSelf.hud.label.text = [object objectForKey:@"msg"];
                        [weakSelf.hud hideAnimated:YES afterDelay:1];
                        sleep(1);
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                    else{
                           weakSelf.hud.label.text = [object objectForKey:@"msg"];
                        [weakSelf.hud hideAnimated:YES afterDelay:1];

                    }
                });
            } failed:^(id object) {
                
            }];
        });

    }
    else{
        NSDictionary *dic =@{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"graClsIds":self.gradeAndclass,@"taskName":self.jobNameText.text,@"deliveryDeadline":self.duringText.text,@"remark":self.remarkText.text,@"taskAppendUrl":self.jobModel.taskAppendUrl,@"targetName":self.jobModel.targetName,@"sourceName":self.jobModel.sourceName};
        __weak typeof(self) weakSelf = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageJobAddWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    
                    if ([[object objectForKey:@"flag"]intValue]) {
                        [weakSelf.navigationController popViewControllerAnimated:YES];
                    }
                });
            } failed:^(id object) {
                
            }];
        });


    }
    }
    
}
-(void)snedCLassNSstring:(NSMutableArray *)string Grade:(NSMutableArray *)grade{
    NSString *classString ;
    for (int i =0; i<string.count; i++) {
        if (i==0) {
            classString = string[0];
        }
        else{
            classString = [NSString stringWithFormat:@"%@,%@",classString,string[i]];
        }
    }
    self.classText.text = classString;
    for (int j=0; j<grade.count; j++) {
        WKJObClassModel *model = grade[j];
        if (j==0) {
            self.gradeAndclass = model.gradeId_classId;
        }
        else{
            self.gradeAndclass = [NSString stringWithFormat:@"%@,%@",self.gradeAndclass,model.gradeId_classId];
        }
    }
    NSLog(@"00%@...",self.gradeAndclass);
}
- (CGFloat)widthForLabel:(NSString *)text{
    
    CGRect rect = [text boundingRectWithSize:CGSizeMake(0, 25) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:15]} context:nil];
    //NSLog(@"width = %f,heght = %f",rect.size.width,rect.size.height);
    return rect.size.width;
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
