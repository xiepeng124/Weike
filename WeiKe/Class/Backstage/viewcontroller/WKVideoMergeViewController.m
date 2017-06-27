//
//  WKVideoMergeViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/5/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoMergeViewController.h"
#import "WKUploadImage.h"
#import "WKVideoClassfiCollectionViewCell.h"
#import "WKAcedemyHandler.h"
#import "WKTeachclassificationCollectionViewController.h"
@interface WKVideoMergeViewController ()<UITextFieldDelegate,upImageDelegate,TeachClassDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoMenu;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *classify;
@property (weak, nonatomic) IBOutlet UITextField *selectedgrade;
@property (weak, nonatomic) IBOutlet UITextField *selectedcourse;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *lineview1;
@property (weak, nonatomic) IBOutlet UIView *lineview2;
@property (weak, nonatomic) IBOutlet UIView *lineview3;
@property (weak, nonatomic) IBOutlet UIView *lineview4;
@property (weak, nonatomic) IBOutlet UIView *lineview5;
@property (weak, nonatomic) IBOutlet UITextField *titleTextfield;
@property (weak, nonatomic) IBOutlet UILabel *titlelabel;
@property (weak, nonatomic) IBOutlet UILabel *videoCover;
@property (weak, nonatomic) IBOutlet UIImageView *videoimage;
@property (weak, nonatomic) IBOutlet UIButton *editCover;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextView *mytextView;
@property (weak, nonatomic) IBOutlet UILabel *isCommentLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *selectedcomment;
@property (strong,nonatomic) WKUploadImage *upload;
@property (strong,nonatomic)UICollectionView *mycollectView;
@property (strong,nonatomic)UIView *backgroundView;
@property (strong,nonatomic)NSMutableArray *arrlist;
@property (assign,nonatomic)NSInteger gradeNumber;
@property (assign,nonatomic)NSInteger courseNumber;
@property(strong,nonatomic)UIButton *button;
@property (assign,nonatomic)NSInteger gradeId;
@property (assign,nonatomic)NSInteger courseId;
@property(strong ,nonatomic)NSString *imageUrl;
@property (strong, nonatomic)MBProgressHUD *hud;
@property (strong,nonatomic) WKTeachclassificationCollectionViewController *colletionviewcontroller;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *commentH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *segCommentH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseH;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *courseFieldH;


@property (strong,nonatomic)WKGrade *gradeModel;
@end

@implementation WKVideoMergeViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}

-(void)initStyle{
    self.videoMenu.textColor = [WKColor colorWithHexString:@"666666"];
     self.gradeLabel.textColor = [WKColor colorWithHexString:@"666666"];
     self.courseLabel.textColor = [WKColor colorWithHexString:@"666666"];
  self.titlelabel.textColor = [WKColor colorWithHexString:@"666666"];
     self.videoCover.textColor = [WKColor colorWithHexString:@"666666"];
    self.isCommentLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.descriptionLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.classify.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectedcomment.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.selectedgrade.textColor =[WKColor colorWithHexString:@"333333"];
    self.selectedcourse.textColor =[WKColor colorWithHexString:@"333333"];
    self.titleTextfield.textColor =[WKColor colorWithHexString:@"333333"];
    self.titleTextfield.delegate = self;
    [self.editCover setTitleColor:[WKColor colorWithHexString:@"333333"] forState:UIControlStateNormal ];
    self.editCover.layer.cornerRadius = 3;
    self.videoimage.layer.cornerRadius = 3;
    self.videoimage.layer.masksToBounds = YES;
    
    self.selectedgrade.userInteractionEnabled = YES;
    self.selectedcourse.userInteractionEnabled = YES;
    self.selectedgrade.delegate = self;
    self.selectedcourse.delegate = self;
    self.mytextView.textColor = [WKColor colorWithHexString:@"333333"];
    
   
    self.sureButton.layer.cornerRadius = 3;
    self.lineview1.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview2.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview3.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview4.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview5.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    switch (self.videoModel.videoType)  {
        case 1:
            self.classify.selectedSegmentIndex =0;
            self.courseH.constant =35;
            self.courseFieldH.constant = 35;
            self.lineview3.hidden = NO;
            break;
        case 2:
            self.classify.selectedSegmentIndex =1;
            self.courseH.constant =0;
            self.courseFieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
        case 3:
            self.classify.selectedSegmentIndex =2;
            self.courseH.constant =0;
            self.courseFieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
            
            
        default:
            break;
    }
    self.selectedgrade.text = self.videoModel.gradeName;
    self.selectedcourse.text = self.videoModel.courseName;
    self.titleTextfield.text = self.videoModel.title;
       if (self.titleTextfield.text.length==0) {
        [self.sureButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.sureButton.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
        self.sureButton.userInteractionEnabled = NO;
    }
    else{
        [self.sureButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.sureButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.sureButton.userInteractionEnabled = YES ;
    }
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textChange:) name:UITextFieldTextDidChangeNotification object:self.titleTextfield];
    self.gradeNumber = -1;
    if (self.isCommet) {
        self.commentH.constant = 35;
        self.selectedcomment.hidden = NO;
        self.lineview4.hidden = NO;
    }
    else{
        self.commentH.constant = 0;
       self.selectedcomment.hidden = YES;
        self.lineview4.hidden = YES;
    }
    self.imageUrl = @"";
    
}
-(void)initconllectionView{
    self.colletionviewcontroller = [[WKTeachclassificationCollectionViewController alloc]init];
    [self addChildViewController:self.colletionviewcontroller];
    self.colletionviewcontroller.view.hidden =YES;
    [self.view addSubview:self.colletionviewcontroller.view];

    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];

}

-(void)initdata{
    NSString *cellid =@"0";
    for (int i=0; i<self.videoarr.count; i++) {
        WKVideoModel *model = self.videoarr[i];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }
        
    }
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"ids":cellid,@"token":TOKEN};
    [WKBackstage executeGetBackstageVideoMergelWithParameter:dic success:^(id object) {
        NSLog(@"respnt = %@",object);
    } failed:^(id object) {
        
    }];
   
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[WKColor colorWithHexString:LIGHT_COLOR]];
    [self initStyle];
    [self initconllectionView];
   // [self initdata];
    self.upload = [WKUploadImage shareManager];
    self.upload.url = VIEDO_COVER;
    self.upload.diction = @{@"loginUserId":LOGINUSERID};
    
    // Do any additional setup after loading the view.
}
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField ==self.selectedgrade) {
        self.selectedcourse.text = nil;
        [self.colletionviewcontroller selectgradeAction:self.classify.selectedSegmentIndex ];
        self.colletionviewcontroller.delegate= self;
        
    }
    else if (textField == self.selectedcourse)
    {
        if (self.selectedgrade.text.length ==0) {
            [self.hud showAnimated:YES];
            self.hud.label.text =@"请优先选择年级";
            [self.hud hideAnimated:YES afterDelay:1];
        }
        else{
            [self.colletionviewcontroller selectcourseAction:self.videoModel.gradeId];
            self.colletionviewcontroller.delegate= self;
        }
    }
    return NO;
}
-(void)showGradeOrCourse:(NSString*) celltext withModel:(WKGrade *)model{
    if (model.courseName==nil) {
        self.selectedgrade.text  =celltext;
    }
    else{
        self.gradeModel = model;
        self.selectedcourse.text = celltext;
    }
}


-(void)textChange:(NSNotification*)noti{
      NSLog(@"6666");
    if (!self.titleTextfield) {
      
        [self.sureButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.sureButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.sureButton.userInteractionEnabled = NO;
    }
    else{
          NSLog(@"3366");
        [self.sureButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.sureButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.sureButton.userInteractionEnabled = YES ;
        
    }

}
- (IBAction)selectType:(UISegmentedControl *)sender {
    self.selectedgrade.text = nil;
    self.selectedcourse.text = nil;
    switch (self.classify.selectedSegmentIndex) {
        case 0:

            self.courseH.constant =35;
            self.courseFieldH.constant = 35;
            self.lineview3.hidden = NO;
            break;
        case 1:
                     self.courseH.constant =0;
            self.courseFieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
        case 2:
            self.courseH.constant =0;
            self.courseFieldH.constant = 0;
            self.lineview3.hidden = YES;
            break;
            
            
        default:
            break;
    }
    
    
}
- (IBAction)editCoverAction:(id)sender {
    [self.upload selectUserpicSourceWithViewController:self];
    self.upload.delegate = self;
}

-(void)selctedImage:(NSDictionary*)Imgestring{
    NSLog(@"logkkddkd");
    if (Imgestring ==nil) {
        self.imageUrl = nil;
    }
    else{
   [self.videoimage sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"videoImage"] ] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.imageUrl = [Imgestring objectForKey:@"videoImage"];
    }
}
-(void)sendImagesource:(NSString *)sourceName{
    
}
- (IBAction)sureAction:(id)sender {
    NSLog(@"self.arr =%@",self.videoarr);
    if (!self.selectedgrade.text.length) {
        self.hud. label.text = @"请选择年级";

        [self.hud showAnimated:YES];
             [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    if (!self.selectedcourse.text.length&&self.classify.selectedSegmentIndex==0) {
        self.hud. label.text = @"请选择学科";
        
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }


    NSString *cellid =@"0";
    for (int i=0; i<self.videoarr.count; i++) {
        WKVideoModel *model = self.videoarr[i];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }
        
    }
    NSNumber *couseId ;
    if (self.colletionviewcontroller.gradeNumber == -1) {
        couseId =[NSNumber numberWithInteger: self.videoModel.courseId];
    }
    else{
        couseId = [NSNumber numberWithInteger:self.gradeModel.id];
    }
    
    NSDictionary *dic;
    NSLog(@"....%@",self.imageUrl);
     NSLog(@"....%@",self.mytextView.text);
    if (self.isCommet) {
        if (!self.imageUrl) {
            self.imageUrl =@"";
        }
        dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectedgrade.text,@"courseId": couseId,@"videoImage":self.imageUrl,@"title":self.titleTextfield.text ,@"remark":self.mytextView.text,@"commentFlag":[NSNumber numberWithInteger:self.selectedcomment.selectedSegmentIndex],@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
    }
    else{
        if (!self.imageUrl) {
            self.imageUrl =@"";
        }

     dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectedgrade.text,@"courseId": couseId,@"title":self.titleTextfield.text ,@"videoImage":self.imageUrl,@"remark":self.mytextView.text,@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
    }
    __weak typeof(self ) weakself = self;
   dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
       [WKBackstage executeGetBackstageVideoMergeCreateWithParameter:dic success:^(id object) {
           dispatch_async(dispatch_get_main_queue(), ^{
               if ([[object objectForKey:@"flag"] intValue]) {
                   [weakself.hud showAnimated:YES];
                   weakself.hud. label.text = @"合并成功";
                   [weakself.hud hideAnimated:YES afterDelay:1];
                   [weakself.navigationController popViewControllerAnimated:YES];
               }
               else{
                   [weakself.hud showAnimated:YES];
                   weakself.hud. label.text = @"合并失败";
                   [weakself.hud hideAnimated:YES afterDelay:1];
               }
               
           });
           
       } failed:^(id object) {
           
       }];

   });


}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"+++%@",self.upload.diction);
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    //NSLog(@"class = %@",NSStringFromClass([touch.view class]));
    
    if (touch.view != self.self.colletionviewcontroller.collectionView) {
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
