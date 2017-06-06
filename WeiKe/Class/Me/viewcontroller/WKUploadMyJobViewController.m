//
//  WKUploadMyJobViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUploadMyJobViewController.h"
#import "ACMediaFrame.h"
@interface WKUploadMyJobViewController ()<UITextFieldDelegate,UITextViewDelegate>
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
    [self.uploadTaskButtton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.uploadTaskButtton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.uploadTaskButtton.layer.cornerRadius = 3;
    [self.keepButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.keepButton.layer.cornerRadius = 3;
    self.keepButton.userInteractionEnabled = NO;
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
    self.mediaView.collectionView.contentSize =CGSizeMake(self.mytableview.frame.size.width, self.mytableview.frame.size.height*3);


}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    [self initMediaVIew];
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
