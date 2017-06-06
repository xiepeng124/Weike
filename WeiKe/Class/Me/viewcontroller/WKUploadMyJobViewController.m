//
//  WKUploadMyJobViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUploadMyJobViewController.h"
#import "ACMediaFrame.h"

@interface WKUploadMyJobViewController ()<UITextFieldDelegate,UITextViewDelegate,ACImageDelegate>
@property (weak, nonatomic) IBOutlet UILabel *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskNameText;
@property (weak, nonatomic) IBOutlet UILabel *schoolYear;
@property (weak, nonatomic) IBOutlet UITextField *schoolYearText;
@property (weak, nonatomic) IBOutlet UILabel *promutor;
@property (weak, nonatomic) IBOutlet UITextField *promutorText;
@property (weak, nonatomic) IBOutlet UILabel *taskFile;
@property (weak, nonatomic) IBOutlet UIButton *uploadTaskButtton;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UITextView *remarkText;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (strong,nonatomic)ACSelectMediaView *mediaView;
@property (weak, nonatomic) IBOutlet UITableView *mytableview;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backgroundView;
@property(strong,nonatomic)MBProgressHUD *hud2;

@end

@implementation WKUploadMyJobViewController
-(void)initStyle{
    self.taskName.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.schoolYear.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.promutor.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.taskFile.textColor = [WKColor colorWithHexString:DARK_COLOR];
     self.remark.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.taskNameText.textColor = [WKColor colorWithHexString:@"333333"];
    self.schoolYear.textColor = [WKColor colorWithHexString:@"333333"];
   self.promutorText.textColor= [WKColor colorWithHexString:@"333333"];
     self.remarkText.textColor= [WKColor colorWithHexString:@"333333"];
    self.taskNameText.userInteractionEnabled = NO;
    self.schoolYearText.userInteractionEnabled = NO;
    self.promutorText.userInteractionEnabled = NO;
    self.remarkText.userInteractionEnabled = NO;
    self.taskNameText.text = self.model.taskName;
    self.schoolYearText.text = [NSString stringWithFormat:@"%lu",self.model.schoolYear];
    self.promutorText.text = self.model.createrName;
    self.remarkText.text = self.model.remark;
    [self.uploadTaskButtton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.uploadTaskButtton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.uploadTaskButtton.layer.cornerRadius = 3;
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.keepButton.layer.cornerRadius = 3;
//    self.keepButton.userInteractionEnabled = NO;
    self.line1.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line2.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line3.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.line4.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.taskNameText];
     [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.schoolYearText];
     [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.promutorText];
     [[NSNotificationCenter defaultCenter ]addObserver:self selector:@selector(textchangge) name:UITextViewTextDidChangeNotification object:self.remarkText];
    self.schoolYearText.delegate = self;
    self.remarkText.delegate = self;
    [self.keepButton addTarget:self action:@selector(keepTaskAction) forControlEvents:UIControlEventTouchUpInside];
  

   // [self.uploadTaskButtton addTarget:self action:@selector(uploadTaskAction) forControlEvents:UIControlStateNormal];
}
-(void)initMediaVIew{
    self. mediaView = [[ACSelectMediaView alloc] initWithFrame:CGRectMake(0, 0, self.mytableview.frame.size.width, self.mytableview.frame.size.height)];
    // self.mediaView.translatesAutoresizingMaskIntoConstraints = NO;
    
    _mediaView.type = ACMediaTypePhotoAndCamera;
    _mediaView.allowMultipleSelection = NO;
    _mediaView.viewController = self;
   // _mediaView.isMerge = self.selectedMerge.selectedSegmentIndex;
    self.mediaView.uploadUrl = JOB_UPLOAD;
    self.mediaView.dic = @{@"loginUserId":LOGINUSERID};
    self.mytableview.tableHeaderView = self.mediaView;
//    [self.mediaView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.left.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//    }];
    self.mediaView.delegate  =self;
    self.mediaView.collectionView.contentSize =CGSizeMake(self.mytableview.frame.size.width, self.mytableview.frame.size.height*3);


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    [self initMediaVIew];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.hud2 = [[MBProgressHUD alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/4, 350, SCREEN_WIDTH/2, 80)];
    
    //self.hud2.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    //self.hud2.label.text = @"正在上传";
    self.hud2.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud2.mode =MBProgressHUDModeDeterminateHorizontalBar;
    [self.view addSubview:self.hud2];
    self.mediaView.hud = self.hud2;
    // Do any additional setup after loading the view from its nib.
}
-(void)textchangge{
    if (!self.taskNameText.text.length||!self.schoolYearText.text.length||!self.promutorText.text.length||!self.remarkText.text.length) {
        [self.keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
        self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
     
        self.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
     
        self.keepButton.userInteractionEnabled = YES;
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validateNumber:string];
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
    if([textView.text isEqualToString:@"请输入作业备注"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入作业备注";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //NSLog(@"uiview = %@",touch.view);
       if (touch.view.frame.size.height>300||touch.view.frame.size.height<55) {
        return YES;
    }
    return NO;
}
-(void)selectedImages:(NSInteger)count{
    if (count>2) {
        self.backgroundView.constant = 310;
        self.tableviewH.constant = 150;
        self.mediaView.frame = CGRectMake(0, 0, self.mytableview.frame.size.width, 150);
       
       }
    else{
        self.backgroundView.constant = 235;
        self.tableviewH.constant = 72.5;
       self.mediaView.frame = CGRectMake(0, 0, self.mytableview.frame.size.width, 72.5);
    }
     self.mediaView.collectionView.frame = self.mediaView.frame;
    self.mytableview.tableHeaderView = self.mediaView;

}
-(void)keepTaskAction{
    NSString *taskManyUrl;
    for (int i =0; i<self.mediaView.upModelarr.count; i++) {
        WKMyUploadTaskmodel *model = self.mediaView.upModelarr[i];
        if (i==0) {
            taskManyUrl = [NSString stringWithFormat:@"%@|%@|%@",model.taskAppendUrl,model.targetName,model.sourceName];
        }
        else{
            taskManyUrl = [NSString stringWithFormat:@"%@;%@|%@|%@",taskManyUrl,model.taskAppendUrl,model.targetName,model.sourceName];
        }
    }
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"taskId":[NSNumber numberWithInteger:self.model.taskId],@"schoolYear":self.schoolYearText.text,@"taskManyUrl":taskManyUrl};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyJobHandWithParameter:dic success:^(id object) {
            if ([[object objectForKey:@"flag"]intValue]) {
                [weakSelf.navigationController popViewControllerAnimated:YES];
            }
        } failed:^(id object) {
            
        }];
    });
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.taskNameText];
      [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.schoolYearText];
      [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.promutorText];
      [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextViewTextDidChangeNotification object:self.remarkText];
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
