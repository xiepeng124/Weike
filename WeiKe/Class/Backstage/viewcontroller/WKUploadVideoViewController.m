//
//  WKUploadVideoViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUploadVideoViewController.h"
#import "WKRemindView.h"
#import "WKTeachclassificationCollectionViewController.h"
#import "WKUpload.h"
#import "ACMediaFrame.h"
#import "WKBackstage.h"
@interface WKUploadVideoViewController ()<UITextFieldDelegate,TeachClassDelegate,ACImageDelegate>
@property (weak, nonatomic) IBOutlet UIButton *updownButton;
@property (strong,nonatomic) WKRemindView *remindview;
@property (strong,nonatomic)UIView * blackView;
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
@property (weak, nonatomic) IBOutlet UILabel *isMerge;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedMerge;
@property (weak, nonatomic) IBOutlet UILabel *isCommentLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedcomment;
@property (weak, nonatomic) IBOutlet UILabel *uploadLabel;
@property (weak, nonatomic) IBOutlet UIButton *uploadButton;
@property (weak, nonatomic) IBOutlet UIView *mianView;
@property (weak, nonatomic) IBOutlet UIButton *SureButton;
@property (strong,nonatomic) WKTeachclassificationCollectionViewController *colletionviewcontroller;
@property (assign,nonatomic)NSInteger gradeId;
@property (assign,nonatomic)NSUInteger courseId;
@property (strong,nonatomic) WKUpload *uploadView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mainviewHeight;
@property (strong,nonatomic) ACSelectMediaView *mediaView;
@property (strong,nonatomic)UIButton *addVideoButton;
@property (weak, nonatomic) IBOutlet UITableView *mytableView;
@property(strong,nonatomic)MBProgressHUD *hud;
@property(strong,nonatomic)MBProgressHUD *hud2;
@property (strong,nonatomic)WKGrade *gradeModel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleHeight;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *lineH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *titleFieldh;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseFieldH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewH;


@end

@implementation WKUploadVideoViewController
-(void)initStyle{
 _remindview = [[WKRemindView alloc]init];
    NSArray *arr = [[NSBundle mainBundle]loadNibNamed:@"remindView" owner:nil options:nil];
    _remindview = [arr lastObject];
    CGFloat height2 = [WKRemindView heightForLabel:_remindview.twoLabel.text];
    _remindview.twoLabel.frame= CGRectMake(35, 0, SCREEN_WIDTH-72, height2);
    CGFloat height3 = [WKRemindView heightForLabel:_remindview.threeLabel.text];
    _remindview.threeLabel.frame= CGRectMake(35, height2, SCREEN_WIDTH-72, height3);
    CGFloat height4 = [WKRemindView heightForLabel:_remindview.fourLabel.text];
    _remindview.fourLabel.frame= CGRectMake(35, height2+height3, SCREEN_WIDTH-72, height4);
    CGFloat height5 = [WKRemindView heightForLabel:_remindview.fiveLabel.text];
    _remindview.fiveLabel.frame= CGRectMake(35, height2+height3+height4, SCREEN_WIDTH-72, height5);
    _remindview.frame = CGRectMake(0, 104, SCREEN_WIDTH, height2+height3+height4+height5);
    _remindview.translatesAutoresizingMaskIntoConstraints = NO;
    [_remindview setHidden:YES];
    [self.view addSubview:_remindview];
    [self.updownButton setBackgroundImage:[UIImage imageNamed:@"my_arrows_but"] forState:UIControlStateNormal];
    [self.updownButton setBackgroundImage:[UIImage imageNamed:@"my_arrows_top"] forState:UIControlStateSelected];
    _blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 104+_remindview.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-104-_remindview.frame.size.height)];
    _blackView.hidden = YES;
    _blackView.backgroundColor =[UIColor blackColor];
    _blackView.alpha = 0.7;
    [self.view addSubview:_blackView];
    self.colletionviewcontroller = [[WKTeachclassificationCollectionViewController alloc]init];
    [self addChildViewController:self.colletionviewcontroller];
    self.colletionviewcontroller.view.hidden =YES;
    [self.view addSubview:self.colletionviewcontroller.view];
    
    self.videoMenu.textColor = [WKColor colorWithHexString:@"666666"];
    self.gradeLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.courseLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.titlelabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.uploadLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.isCommentLabel.textColor = [WKColor colorWithHexString:@"666666"];
   self.isMerge.textColor = [WKColor colorWithHexString:@"666666"];
    self.classify.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectedcomment.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
     self.selectedMerge.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectgrade.textColor =[WKColor colorWithHexString:@"333333"];
    self.selectcourse.textColor =[WKColor colorWithHexString:@"333333"];
    self.titleTextfield.textColor =[WKColor colorWithHexString:@"333333"];
    self.selectgrade.userInteractionEnabled = YES;
    self.selectcourse.userInteractionEnabled = YES;
    self.selectgrade.delegate = self;
    self.selectcourse.delegate = self;
    self.selectedMerge.selectedSegmentIndex =1;
//    [self.selectgrade addGestureRecognizer:tap1];
//    [self.selectcourse addGestureRecognizer:tap2];
    self.gradeId = -1;
    self.courseId = -1;
       self.mediaView = [[ACSelectMediaView alloc]initWithFrame:self.mytableView.frame];
  
    
    _mediaView.type = ACMediaTypeVideoAndCamera;
    _mediaView.allowMultipleSelection = NO;
    _mediaView.viewController = self;
    _mediaView.isMerge = self.selectedMerge.selectedSegmentIndex;
    self.mediaView.uploadUrl = VIEDO_UPLOAD;
    self.mediaView.dic = @{@"loginUserId":LOGINUSERID};
    //self.mediaView.hidden = YES;
       self.mytableView.tableHeaderView = self.mediaView;
    self.mytableView.scrollEnabled = NO;
    self.mediaView.delegate = self;
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
    self.hud2 = [[MBProgressHUD alloc]init];
    self.hud2.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud2.label.text = @"正在上传";
     self.hud2.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud2.mode =MBProgressHUDModeDeterminateHorizontalBar;
    [self.view addSubview:self.hud2];
    self.mediaView.hud = self.hud2;
    [self.SureButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
    [self.SureButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.SureButton.userInteractionEnabled = YES ;

//    [self.SureButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
//    [self.SureButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    self.SureButton.userInteractionEnabled = NO;
    self.SureButton.layer.cornerRadius = 3;


}
-(void)textchangge:(NSNotification*)notifi{
 
    if (!self.selectgrade.text.length||!self.selectcourse.text.length) {
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

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    self.modalTransitionStyle = UIModalPresentationOverCurrentContext;
    // Do any additional setup after loading the view.
}

- (IBAction)uploadVideoAction:(id)sender {
  
//   [self.mianView mas_updateConstraints:^(MASConstraintMaker *make) {
//       make.top.mas_equalTo(114);
//       make.left.mas_equalTo(10);
//       make.right.mas_equalTo(-10);
//      make.size.height.mas_equalTo(297);
//   }];
    self.mainviewHeight.constant+=57;
    
   //    self.uploadView.hidden = NO;
        [self.uploadButton setHidden:YES];
    
    
    
}
- (IBAction)updownAction:(UIButton *)sender {
    sender.selected = !sender.selected;
    if (sender.selected) {
        self.remindview.hidden = NO;
        self.blackView.hidden = NO;
    }
    else{
        self.remindview.hidden = YES;
        self.blackView.hidden = YES;
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
//-(void)selectgradeAction{
//    self.selectcourse.text = nil;
//    [self.colletionviewcontroller selectgradeAction:self.classify.selectedSegmentIndex ];
//}
-(void)showGradeOrCourse:(NSString*) celltext withModel:(WKGrade *)model{
    if (model.courseName==nil) {
        self.selectgrade.text  =celltext;
    }
    else{
         self.gradeModel = model;
        self.selectcourse.text = celltext;
    }
}
-(void)selectcourseAction{
    [self.colletionviewcontroller selectcourseAction:self.gradeId];
}
- (IBAction)selectedMenuAction:(UISegmentedControl *)sender {
    self.selectgrade.text = nil;
    self.selectcourse.text = nil;
    switch (self.classify.selectedSegmentIndex) {
        case 0:
            self.courseH.constant = 37;
            self.courseFieldH.constant = 37;
          
            self.lineview3.hidden = NO;
            //            [self.selectedcourse
            break;
        case 1:
            
            self.courseH.constant = 0;
            self.courseFieldH.constant =0;
            self.lineview3.hidden = YES;
            break;
        case 2:
            
            self.courseH.constant = 0;
            self.courseFieldH.constant =0;
            self.lineview3.hidden = YES;
            break;
            
            
        default:
            break;
    }

}
- (IBAction)isMergeVideoAction:(id)sender {
    self.mediaView.isMerge = self.selectedMerge.selectedSegmentIndex;
    
    if (self.selectedMerge.selectedSegmentIndex == 1) {
        self.titleHeight.constant = 35;
        self.titleFieldh.constant = 35;
       self.lineH.constant = 0.6;
    }
    else{
        self.titleHeight.constant = 0;
        self.titleFieldh.constant = 0;
        self.lineH.constant = 0;
    }
    [self.mediaView.collectionView reloadData];
}
-(BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //NSLog(@"uiview = %@",touch.view);
    if (!self.colletionviewcontroller.view.hidden) {
       // NSLog(@"344");
        return NO;
    }
    if (touch.view.frame.size.height>300||touch.view.frame.size.height<50) {
        return YES;
    }
     return NO;
}
- (IBAction)SureUploadVideoAction:(id)sender {
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
    if (!self.titleTextfield.text.length&&self.selectedMerge.selectedSegmentIndex==1) {
        self.hud.label.text = @"请输入合并标题";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated: YES afterDelay:1];
        return;
    }
    if (!self.mediaView.upModelarr.count) {
        self.hud.label.text = @"请添加上传视频";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated: YES afterDelay:1];
        return;
    }
    if (self.mediaView.upModelarr.count<2&&self.selectedMerge.selectedSegmentIndex==1) {
        self.hud.label.text = @"请添加两个及以上视频";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated: YES afterDelay:1];
        return;
    }
    NSString *videoMsg;
    NSLog(@" -----%lu",self.mediaView.upModelarr.count);
    for (int i=0; i<self.mediaView.upModelarr.count; i++) {
        WKUploadModel *model = self.mediaView.upModelarr[i];
        if (i==0) {
            videoMsg = [NSString stringWithFormat:@"%lu|%lu|%@|%@|%@|%@|%lu",model.fileName,model.fileSize,model.fileType,model.realPath,model.imageUrl,model.sourceName,model.videoTime];
            NSLog(@"....videmasg = %@",videoMsg);
        }
        else{
             videoMsg = [NSString stringWithFormat:@"%@,%lu|%lu|%@|%@|%@|%@|%lu",videoMsg,model.fileName,model.fileSize,model.fileType,model.realPath,model.imageUrl,model.sourceName,model.videoTime];
        }
      
    }
    NSDictionary *dic;
    if (self.selectedMerge.selectedSegmentIndex==1) {
        dic = @{@"schoolId":SCOOLID,@"commentFlag":[NSNumber numberWithInteger:self.selectedcomment.selectedSegmentIndex],@"concatFlag":[NSNumber numberWithInteger:self.selectedMerge.selectedSegmentIndex ],@"title":self.titleTextfield.text,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex+1],@"gradeId":self.selectgrade.text,@"courseId":[NSNumber numberWithInteger:self.gradeModel.id],@"loginUserId":LOGINUSERID,@"videoImage":self.mediaView.CoverImageUrl,@"videMsg":videoMsg};
    }
  else {
        dic = @{@"schoolId":SCOOLID,@"commentFlag":[NSNumber numberWithInteger:self.selectedcomment.selectedSegmentIndex],@"concatFlag":[NSNumber numberWithInteger:self.selectedMerge.selectedSegmentIndex ],@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex+1],@"gradeId":self.selectgrade.text,@"courseId":[NSNumber numberWithInteger:self.gradeModel.id],@"loginUserId":LOGINUSERID,@"videMsg":videoMsg};
    }
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoUploadKeepWithParameter:dic success:^(id object) {
//            NSLog(@"object  = %lu",[object allKeys].count);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [self.hud showAnimated:YES];
                    weakself.hud.label.text =@"上传成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
                else{
                    [self.hud showAnimated:YES];
                    weakself.hud.label.text =@"上传失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                        }
                
                //[weakself.videoTableview reloadData];
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });


}
-(void)selectedVideos:(NSInteger)count{
    if (self.selectedMerge.selectedSegmentIndex==0) {
        if (count>2) {
            self.mainviewHeight.constant = 397;
            self.tableviewH.constant = 175;
            self.mediaView.frame = CGRectMake(0, 0, self.mytableView.frame.size.width, 175);
            
        }
        else{
            self.mainviewHeight.constant = 307;
            self.tableviewH.constant = 85;
            self.mediaView.frame = CGRectMake(0, 0, self.mytableView.frame.size.width, 85);
        }

    }
    else{
        if (count>1) {
            self.mainviewHeight.constant = 397;
            self.tableviewH.constant = 175;
            self.mediaView.frame = CGRectMake(0, 0, self.mytableView.frame.size.width, 175);
            
        }
        else{
            self.mainviewHeight.constant = 307;
            self.tableviewH.constant = 85;
            self.mediaView.frame = CGRectMake(0, 0, self.mytableView.frame.size.width, 85);
        }

    }
       self.mediaView.collectionView.frame = self.mediaView.frame;
    self.mytableView.tableHeaderView = self.mediaView;
    
}

-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.selectgrade];
     [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.selectcourse];
   //  [[NSNotificationCenter defaultCenter]removeObserver:self name:UITextFieldTextDidChangeNotification object:self.titleTextfield];
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
