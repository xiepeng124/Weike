//
//  WKUploadOutLinkViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/22.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUploadOutLinkViewController.h"
#import "WKTeachclassificationCollectionViewController.h"
#import "WKUploadImage.h"
#import "WKBackstage.h"
#import "WKCheackModel.h"
@interface WKUploadOutLinkViewController ()<UITextFieldDelegate,UITextViewDelegate,TeachClassDelegate,upImageDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoMenu;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *classify;
@property (weak, nonatomic) IBOutlet UITextField *selectgrade;
@property (weak, nonatomic) IBOutlet UITextField *selectcourse;
@property (weak, nonatomic) IBOutlet UIView *lineview1;
@property (weak, nonatomic) IBOutlet UIView *lineview2;
@property (weak, nonatomic) IBOutlet UIView *lineview3;
@property (weak, nonatomic) IBOutlet UIView *lineview4;
@property (weak, nonatomic) IBOutlet UIView *lineview5;
@property (weak, nonatomic) IBOutlet UIView *lineview6;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *urlLabel;
@property (weak, nonatomic) IBOutlet UITextField *videoUrl;
@property (weak, nonatomic) IBOutlet UILabel *CoverLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImage;
@property (weak, nonatomic) IBOutlet UIButton *editCover;
@property (weak, nonatomic) IBOutlet UILabel *descriLabel;
@property (weak, nonatomic) IBOutlet UITextView *DescriTextView;
@property (weak, nonatomic) IBOutlet UIButton *SureButton;
@property (strong,nonatomic) WKTeachclassificationCollectionViewController *colletionviewcontroller;
@property(strong,nonatomic)MBProgressHUD *hud;
@property (strong,nonatomic)WKUploadImage *upload;
@property (strong,nonatomic) NSString *imageUrl;
@property (strong,nonatomic)WKGrade *gradeModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *coursefieldH;

@end

@implementation WKUploadOutLinkViewController
-(void)initStyle{
    self.videoMenu.textColor = [WKColor colorWithHexString:@"666666"];
    self.gradeLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.courseLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.titlelabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.urlLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.CoverLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.descriLabel.textColor = [WKColor colorWithHexString:@"666666"];

    self.classify.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectgrade.textColor =[WKColor colorWithHexString:@"333333"];
    self.selectcourse.textColor =[WKColor colorWithHexString:@"333333"];
    self.titleTextfield.textColor =[WKColor colorWithHexString:@"333333"];
     self.videoUrl.textColor =[WKColor colorWithHexString:@"333333"];
     self.DescriTextView.textColor =[WKColor colorWithHexString:@"999999"];
    self.DescriTextView.delegate =self;
    self.lineview1.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview2.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview3.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview4.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview5.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
      self.lineview6.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    //    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectgradeAction)];
    //    tap1.numberOfTouchesRequired =1;
    //    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcourseAction)];
    //    tap2.numberOfTouchesRequired =1;
    
    //    self.selectcourse.editing = NO;
    self.selectgrade.userInteractionEnabled = YES;
    self.selectcourse.userInteractionEnabled = YES;
    self.selectgrade.delegate = self;
    self.selectcourse.delegate = self ;
    self.colletionviewcontroller = [[WKTeachclassificationCollectionViewController alloc]init];
    [self addChildViewController:self.colletionviewcontroller];
    self.colletionviewcontroller.view.hidden =YES;
    [self.view addSubview:self.colletionviewcontroller.view];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
    [self.editCover setTitleColor:[WKColor colorWithHexString:@"333333"] forState:UIControlStateNormal ];
    self.editCover.layer.cornerRadius = 3;
    self.videoCoverImage.layer.cornerRadius = 3;
    self.videoCoverImage.layer.masksToBounds = YES;
    self.SureButton.layer.cornerRadius = 3;
    [self.SureButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    [self.SureButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.SureButton.userInteractionEnabled = NO;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.titleTextfield];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.videoUrl];
    self.videoUrl.keyboardType = UIKeyboardTypeURL;
    self.imageUrl =@"";
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    self.upload = [WKUploadImage shareManager];
    self.upload.url = VIEDO_COVER;
    self.upload.diction = @{@"loginUserId":LOGINUSERID};
    // Do any additional setup after loading the view.
}
-(void)textchangge{
    if (!self.titleTextfield.text.length||!self.videoUrl.text.length) {
            [self.SureButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
            [self.SureButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
            self.SureButton.userInteractionEnabled = NO;

    }
    else{
    [self.SureButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
    [self.SureButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.SureButton.userInteractionEnabled = YES ;
    }
   
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入视频描述"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入视频描述";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField ==self.selectgrade) {
        self.selectcourse.text = nil;
        [self.colletionviewcontroller selectgradeAction:self.classify.selectedSegmentIndex ];
        self.colletionviewcontroller.delegate= self;
        
    }
    else if (textField == self.selectcourse)
    {
        if (self.selectgrade.text.length ==0) {
            [self.hud showAnimated:YES];
            self.hud.label.text =@"请优先选择年级";
            [self.hud hideAnimated:YES afterDelay:1];
        }
        else{
        [self.colletionviewcontroller selectcourseAction:-1];
        self.colletionviewcontroller.delegate= self;
        }
    }
    return NO;
}
-(void)showGradeOrCourse:(NSString*) celltext withModel:(WKGrade *)model{
    if (model.courseName==nil) {
        self.selectgrade.text  =celltext;
    }
    else{
        self.gradeModel = model;
        self.selectcourse.text = celltext;
    }
}
- (IBAction)SureOutLInkAction:(id)sender {
    if (!self.selectgrade.text.length) {
        self.hud.label.text = @"请选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated: YES afterDelay:1];
        return;
    }
    if (!self.selectcourse.text.length&&self.classify.selectedSegmentIndex==0) {
        self.hud.label.text = @"请选择学科";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated: YES afterDelay:1];
        return;
    }
//    if (![WKCheackModel checkURL:self.videoUrl.text]) {
//
//            self.hud.label.text = @"请输入正确的网址";
//            [self.hud showAnimated:YES];
//            [self.hud hideAnimated: YES afterDelay:1];
//            return;
//
//    }

    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectgrade.text,@"courseId": [NSNumber numberWithInteger:self.gradeModel.id],@"videoImage":self.imageUrl,@"title":self.titleTextfield.text ,@"remark":self.DescriTextView.text,@"videoLink":self.videoUrl.text};
    __weak typeof(self ) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoOutLinkWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"] intValue]) {
                    [weakself.hud showAnimated:YES];
                    weakself.hud. label.text = @"上传成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [weakself.hud showAnimated:YES];
                    weakself.hud. label.text = @"上传失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                }
                
            });
            
        } failed:^(id object) {
            
        }];
});
    
}
- (IBAction)selectedMenuAction:(UISegmentedControl *)sender {
    self.selectgrade.text = nil;
    self.selectcourse.text = nil;
    switch (self.classify.selectedSegmentIndex) {
        case 0:
            self.courseH.constant = 35;
            self.coursefieldH.constant = 35;
                    self.lineview3.hidden = NO;
    
            break;
        case 1:
            
            self.courseH.constant = 0;
            self.coursefieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
        case 2:
            
            self.courseH.constant = 0;
            self.coursefieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
            
            
        default:
            break;
    }
    
}
- (IBAction)eidtCoverAction:(id)sender {
    NSLog(@"33333");
    [self.upload selectUserpicSourceWithViewController:self];
    self.upload.delegate = self;

}
-(void)selctedImage:(NSDictionary*)Imgestring{
    if (Imgestring ==nil) {
        self.imageUrl = nil;
    }
    else{
        [self.videoCoverImage sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"videoImage"] ] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        self.imageUrl = [Imgestring objectForKey:@"videoImage"];
    }

}
-(void)sendImagesource:(NSString *)sourceName{
    
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
       if (!self.colletionviewcontroller.view.hidden) {
        NSLog(@"344");
        return NO;
    }
    return YES;
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
