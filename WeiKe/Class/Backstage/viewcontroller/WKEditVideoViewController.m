//
//  WKEditVideoViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/23.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKEditVideoViewController.h"
#import "WKTeachclassificationCollectionViewController.h"
#import "WKUploadImage.h"
#import "WKBackstage.h"
@interface WKEditVideoViewController ()<UITextFieldDelegate,TeachClassDelegate,upImageDelegate,UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *resultLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *passControl;
@property (weak, nonatomic) IBOutlet UILabel *sugLabel;
@property (weak, nonatomic) IBOutlet UITextView *sugTextView;
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
@property (weak, nonatomic) IBOutlet UILabel *CoverLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoCoverImage;
@property (weak, nonatomic) IBOutlet UIButton *editCover;
@property (weak, nonatomic) IBOutlet UILabel *commentLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isComment;
@property (strong,nonatomic) WKTeachclassificationCollectionViewController *colletionviewcontroller;
@property(strong,nonatomic)MBProgressHUD *hud;
@property (strong,nonatomic)WKUploadImage *upload;
@property (strong,nonatomic)WKGrade *gradeModel;
@property (weak, nonatomic) IBOutlet UIScrollView *myscollview;
@property (strong,nonatomic)NSString *ImageUrl;
@property (weak, nonatomic) IBOutlet UIView *ApprovalView;
@property (strong,nonatomic)UITextField *videolink;
@property (weak, nonatomic) IBOutlet UIView *backView;
@property (weak, nonatomic) IBOutlet UILabel *remarkLabel;
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *approvalHeight;

@end

@implementation WKEditVideoViewController
-(void)initStyle{
      self.resultLabel.textColor = [WKColor colorWithHexString:@"666666"];
      self.sugLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.videoMenu.textColor = [WKColor colorWithHexString:@"666666"];
    self.gradeLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.courseLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.titlelabel.textColor = [WKColor colorWithHexString:@"666666"];
    //self.urlLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.CoverLabel.textColor = [WKColor colorWithHexString:@"666666"];
     self.commentLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.remarkLabel.textColor = [WKColor colorWithHexString:@"666666"];
    
    self.classify.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.passControl.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.isComment.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectgrade.textColor =[WKColor colorWithHexString:@"333333"];
    self.selectcourse.textColor =[WKColor colorWithHexString:@"333333"];
    self.titleTextfield.textColor =[WKColor colorWithHexString:@"333333"];
    self.remarkTextView.textColor =[WKColor colorWithHexString:@"999999"];
    self.sugTextView.textColor =[WKColor colorWithHexString:@"999999"];
    self.selectgrade.userInteractionEnabled = YES;
    self.selectcourse.userInteractionEnabled = YES;
    self.selectgrade.delegate = self;
    self.selectcourse.delegate = self ;
    self.remarkTextView.delegate = self;
    self.lineview1.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview2.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview3.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview4.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview5.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview6.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
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
    self.sugTextView.editable = NO;
    self.selectgrade.text = self.videoModel.gradeName;
    self.selectcourse.text = self.videoModel.courseName;
    self.titleTextfield.text = self.videoModel.title;
    self.videolink = [[UITextField alloc]init];
    self.videolink.placeholder = @"请输入链接";
    self.videolink.textColor = [WKColor colorWithHexString:@"333333"];
    self.videolink.font = [UIFont fontWithName:FONT_REGULAR size:16];
    [self.backView addSubview:self.videolink];
    [self.videolink mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(142.4);
        make.left.mas_equalTo(90);
        make.right.mas_equalTo(0);
        make.size.height.mas_equalTo(35);
    }];
    if (self.isOutLink) {
        self.isComment.hidden = YES;
        self.commentLabel.text = @"视频链接";
        self.videolink.hidden = NO;
    }
    else{
        self.isComment.hidden = NO;
        self.commentLabel.text = @"允许评论";
        self.videolink.hidden = YES;
   

    }
    self.classify.selectedSegmentIndex = self.videoModel.videoType-1;
    switch ( self.classify.selectedSegmentIndex) {
        case 0:
            self.selectcourse.hidden = NO;
            self.courseLabel.hidden = NO;
            break;
        case 1:
            self.selectcourse.hidden = YES;
            self.courseLabel.hidden = YES;
            break;
        case 2:
            self.selectcourse.hidden = YES;
            self.courseLabel.hidden = YES;
            break;

        default:
            break;
    }
    [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];

    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.selectgrade];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.selectcourse];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.titleTextfield];
    
}

-(void)textchangge:(NSNotification*)notifi{
    
 
    if (!self.selectgrade.text.length||!self.selectcourse.text.length||!self.titleTextfield.text.length) {
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

-(void)initdata{
    NSDictionary *dic =@{@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:self.videoModel.id]};
   // [self.videolist removeAllObjects];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoEditWithParameter:dic success:^(id object) {
           NSLog(@"object  = %lu",[object allKeys].count);
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([object allKeys].count) {
                        weakself.sugTextView.text = [object objectForKey:@"approvalOpinion"];
                         weakself.approvalHeight.constant = 90;
                        NSLog(@"approvalStatus =%d",[[object objectForKey:@"approvalStatus"]intValue]);

                        if ([[object objectForKey:@"approvalStatus"]intValue]==2) {
                                                      weakself.passControl.selectedSegmentIndex =1;
                        }
                        else{
                            weakself.passControl.selectedSegmentIndex =0;
                        }
                       
                    }
                    else{
                       [weakself.ApprovalView setHidden: YES];
                        weakself.approvalHeight.constant = 0;
                    }
              
                //[weakself.videoTableview reloadData];
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.upload = [WKUploadImage shareManager];
    self.upload.url = VIEDO_COVER;
    self.upload.diction = @{@"loginUserId":LOGINUSERID};
    [self initStyle];
      self.myscollview.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
     self.ImageUrl = @"";
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self initdata];

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
- (IBAction)selectedMenuAction:(UISegmentedControl *)sender {
    switch (self.classify.selectedSegmentIndex) {
        case 0:
            
            self.courseLabel.hidden = NO;
            self.selectcourse.hidden = NO;
            self.lineview3.hidden = NO;
            //            [self.selectedcourse
            break;
        case 1:
            
            self.courseLabel.hidden = YES;
            self.selectcourse.hidden = YES;
            self.lineview3.hidden = YES;
            break;
        case 2:
            
            self.courseLabel.hidden = YES;
            self.selectcourse.hidden = YES;
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
        self.ImageUrl = @"";
    }
    else{
        [self.videoCoverImage sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"videoImage"] ] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        self.ImageUrl = [Imgestring objectForKey:@"videoImage"];
    }
    
}
- (IBAction)KeepeditVideoAction:(id)sender {
    NSDictionary *dic ;
    NSNumber *couseId ;
    if (self.colletionviewcontroller.gradeNumber == -1) {
        couseId =[NSNumber numberWithInteger: self.videoModel.courseId];
    }
    else{
        couseId = [NSNumber numberWithInteger:self.gradeModel.id];
    }

    if (_isOutLink==0) {
        
      dic=  @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:self.videoModel.id],@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectgrade.text,@"courseId": couseId,@"videoImage":self.ImageUrl,@"title":self.titleTextfield.text ,@"commentFlag":[NSNumber numberWithInteger:self.isComment.selectedSegmentIndex],@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
    }
    else{
        dic=  @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:self.videoModel.id],@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectgrade.text,@"courseId": couseId,@"videoImage":self.ImageUrl,@"title":self.titleTextfield.text ,@"videoLink":self.videolink.text,@"isOutLink":[NSNumber numberWithBool:self.isOutLink],@"remark":self.remarkTextView.text};
    }
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoEditKeepWithParameter:dic success:^(id object) {
            //NSLog(@"object  = %lu",[object allKeys].count);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text =@"保存成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text =@"保存失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                }
                
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });


}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入备注"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入备注";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}

-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    if (!self.colletionviewcontroller.view.hidden) {
        //NSLog(@"344");
        return NO;
    }
    return YES;
}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
