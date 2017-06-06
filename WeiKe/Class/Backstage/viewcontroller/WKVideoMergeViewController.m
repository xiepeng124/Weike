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
@interface WKVideoMergeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate,upImageDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoMenu;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *classify;
@property (weak, nonatomic) IBOutlet UILabel *selectedgrade;
@property (weak, nonatomic) IBOutlet UILabel *selectedcourse;
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
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectgradeAction)];
    tap1.numberOfTouchesRequired =1;
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcourseAction)];
    tap2.numberOfTouchesRequired =1;
    
    self.selectedgrade.userInteractionEnabled = YES;
    self.selectedcourse.userInteractionEnabled = YES;
    [self.selectedgrade addGestureRecognizer:tap1];
    [self.selectedcourse addGestureRecognizer:tap2];
    self.mytextView.textColor = [WKColor colorWithHexString:@"999999"];
    
   
    self.sureButton.layer.cornerRadius = 3;
    self.lineview1.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview2.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview3.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview4.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
     self.lineview5.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    switch (self.videoModel.videoType)  {
        case 1:
            self.classify.selectedSegmentIndex =0;
            self.courseLabel.hidden = NO;
            self.selectedcourse.hidden = NO;
            self.lineview3.hidden = NO;
            break;
        case 2:
            self.classify.selectedSegmentIndex =1;
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            self.lineview3.hidden = YES;
            break;
        case 3:
            self.classify.selectedSegmentIndex =2;
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            self.lineview3.hidden = YES;
            break;
            
            
        default:
            break;
    }
    self.selectedgrade.text = self.videoModel.gradeName;
    self.selectedcourse.text = self.videoModel.courseName;
    self.titleTextfield.text = self.videoModel.title;
    if (self.selectedcourse.text.length ==0) {
        self.selectedcourse.text = @"请选择学科";
        self.selectedcourse.textColor = [WKColor colorWithHexString:@"999999"];
    }
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
    self.backgroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
    self.backgroundView.backgroundColor = [UIColor blackColor];
    self.backgroundView.alpha = 0.6;
    self.backgroundView.hidden = YES;
    [self.view addSubview:self.backgroundView];
    self.gradeId = self.videoModel.gradeId;
    self.courseId = self.videoModel.courseId;
    NSLog(@"self.garde=%lu",self.gradeId);
    self.gradeNumber = -1;
    if (self.isCommet) {
        self.isCommentLabel.hidden = NO;
        self.selectedcomment.hidden = NO;
    }
    else{
        self.isCommentLabel.hidden = YES;
        self.selectedcomment.hidden = YES;
    }
    self.imageUrl = nil;
}
-(void)initconllectionView{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 20;
    layout.minimumInteritemSpacing = 0;
    layout.itemSize = CGSizeMake((270/2-40), 17);
    layout.sectionInset = UIEdgeInsetsMake(20, 20, 5, 20);
    layout.footerReferenceSize = CGSizeMake(270, 55);
    layout.sectionFootersPinToVisibleBounds = YES;
    self.mycollectView = [[UICollectionView alloc]initWithFrame:
                          CGRectMake(0, 0, 0,0) collectionViewLayout:layout];
    self.mycollectView.dataSource = self;
    self.mycollectView.delegate = self;
    self.mycollectView.layer.cornerRadius = 3;
    self.mycollectView.layer.masksToBounds = YES;
    [self.mycollectView registerNib:[UINib nibWithNibName:@"WKVideoClassfiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
    [self.mycollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];

    self.mycollectView.backgroundColor = [UIColor whiteColor];
    self.mycollectView.hidden = YES;
    [self.view addSubview:self.mycollectView];
    __weak  typeof(self) weakself = self;
    [self.mycollectView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(weakself.view);
        make.top.mas_equalTo(154);
        make.size.mas_equalTo(CGSizeMake(270, 165));
    }];
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
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.arrlist.count == 0) {
        return 1;
    }
    return self.arrlist.count;

}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
    //    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem: self.gradeNumber inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    //    [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.gradeNumber inSection:0]];
    if (self.arrlist.count ==0) {
        return cell;
    }
    
    WKGrade *model = self.arrlist[indexPath.row];
    if (model.courseName==nil) {
        if (model.gradeName==nil) {
            if (model.sectionId==1) {
                cell.mylabel.text = @"初中部";
            }
            
            else if (model.sectionId==2) {
                cell.mylabel.text = @"高中部";
            }
            
        }
        else{
            cell.mylabel.text = model.gradeName;
        }
    }
    else{
        cell.mylabel.text = model.courseName;
    }
    
    cell.backgroundColor = [UIColor whiteColor];
    return cell;

}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];;
    foot.backgroundColor = [UIColor whiteColor];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    [_button setTitle:@"确定" forState:UIControlStateNormal];
    [_button setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    _button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    _button.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    _button.layer.cornerRadius = 3;
    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"取消" forState:UIControlStateNormal];
    [button2 setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    button2.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [_button addTarget:self action:@selector(keepdata) forControlEvents:UIControlEventTouchUpInside];
    [button2 addTarget:self action:@selector(canceldata) forControlEvents:UIControlEventTouchUpInside];
    _button.userInteractionEnabled = NO;
    [foot addSubview:_button];
    [foot addSubview:button2];
//    for ( int i=0; i<self.arrlist.count; i++) {
//        WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [self.mycollectView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
//        if (cell.selected) {
//            self.button.userInteractionEnabled = YES;
//            break;
//        }
//        NSLog(@"break");
//        self.button.userInteractionEnabled = NO;
//    }

    [_button  mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-15);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(54, 30));
    }];
    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake(54, 30));
        make.right.mas_equalTo(-(25+54));
    }];
    
    return foot;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
   _button.userInteractionEnabled = YES;
    cell.myselected.image = [UIImage imageNamed:@"role_on"];
    cell.selected  =YES;
    WKGrade *model = self.arrlist [indexPath.row];
    self.gradeNumber = indexPath.row ;
    if (model.courseName == nil) {
        self.courseNumber = self.gradeNumber;
    }
   // [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
    //_button.userInteractionEnabled = NO;
    cell.selected  =NO;
    cell.myselected.image = [UIImage imageNamed:@"role_off"];
    
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
    switch (self.classify.selectedSegmentIndex) {
        case 0:
            
            self.courseLabel.hidden = NO;
            self.selectedcourse.hidden = NO;
            self.lineview3.hidden = NO;
//            [self.selectedcourse 
            break;
        case 1:
            
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            self.lineview3.hidden = YES;
            break;
        case 2:
            
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
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

-(void)selectgradeAction{
    self.mycollectView.hidden =NO;
    self.backgroundView.hidden = NO;
    self.selectedcourse.text = @"请选择学科";
    self.selectedcourse.textColor = [WKColor colorWithHexString:@"999999"];
    for (int i= 0; i<self.arrlist.count; i++) {
        NSIndexPath *index2 = [NSIndexPath indexPathForItem:0 inSection:0];
        [self.mycollectView deselectItemAtIndexPath:index2 animated:YES];
        [self.mycollectView cellForItemAtIndexPath:index2].selected = NO;
    }
    
   // [self.arrcount addObject:[NSNumber numberWithInteger:self.classify.selectedSegmentIndex]];
    //WKGrade *model = self.arrlist[0];
    
    //    if (self.arrcount.count==2) {
    //        if ([self.arrcount[0]intValue]==[self.arrcount[1]intValue]&&model.courseName==nil) {
    //            [self.arrcount removeObjectAtIndex:0];
    //        }
    //
    //    }
    
    //        else  {
    [self.arrlist removeAllObjects];
    if (self.classify.selectedSegmentIndex ==0) {
        //NSLog(@"2222");
        NSDictionary *dic = @{@"typeId":@1,@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademyGradeWithParameter:dic success:^(id object) {
                NSLog(@"object = %@",object);
                for (WKGrade * grade in object) {
                    
                    [weakself.arrlist addObject:grade];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.mycollectView reloadData];
                    
                    [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 165));
                    }];
                });
            } failed:^(id object) {
                NSLog(@"123");
            }];
            
        });
    }
    else {
        NSDictionary *dic = @{@"typeId":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex+1],@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademySectionWithParameter:dic success:^(id object) {
                for (WKGrade * grade in object) {
                    [weakself.arrlist addObject:grade];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.mycollectView reloadData];
                    [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 91));
                    }];
                    
                });
            } failed:^(id object) {
            }];
            
        });
        
        
    }
    
    //}
    //[self.arrcount removeObjectAtIndex:0];
    
    // _button.userInteractionEnabled = NO;
    
    
    // NSLog(@"1111");
    
}
-(void)selectcourseAction{
    self.mycollectView.hidden =NO;
    self.backgroundView.hidden = NO;
    WKGrade *grade = [[WKGrade alloc]init];
    if (self.gradeNumber==-1) {
//       grade.id = self.gradeId;
//      NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:grade.id],@"schoolId":SCOOLID};
        NSLog(@"123456");
         [self.arrlist removeAllObjects];
        
            __weak typeof(self) weakself = self;
            NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:self.gradeId],@"schoolId":SCOOLID};
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [WKAcedemyHandler executeGetAcademyCourse2WithParameter:dic success:^(id object) {
                    for (WKGrade * course in object) {
                        [weakself.arrlist addObject:course];
                    };
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [weakself.mycollectView reloadData];
                        [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
                            make.centerX.equalTo(weakself.view);
                            make.top.mas_equalTo(154);
                            make.size.mas_equalTo(CGSizeMake(270, 310));
                        }];
                    });
                } failed:^(id object) {
                }];
                
            });
       
        
    }
    else{
   grade= self.arrlist[self.gradeNumber];
   
   
    if (grade.gradeName!=nil) {
        [self.arrlist removeAllObjects];
        self.gradeId = grade.id;
        __weak typeof(self) weakself = self;
        NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:self.gradeId],@"schoolId":SCOOLID};
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKAcedemyHandler executeGetAcademyCourse2WithParameter:dic success:^(id object) {
                for (WKGrade * course in object) {
                    [weakself.arrlist addObject:course];
                };
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.mycollectView reloadData];
                    [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
                        make.centerX.equalTo(weakself.view);
                        make.top.mas_equalTo(154);
                        make.size.mas_equalTo(CGSizeMake(270, 310));
                    }];
                });
            } failed:^(id object) {
            }];
            
        });
    }
    else{
        [self.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.view);
            make.top.mas_equalTo(154);
            make.size.mas_equalTo(CGSizeMake(270, 310));
        }];
        
    }
    }
}
-(void)keepdata{
    self.mycollectView.hidden = YES;
    self.backgroundView.hidden = YES;
     _button.userInteractionEnabled = NO;
    WKGrade *model = self.arrlist [self.gradeNumber];
    
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.mycollectView cellForItemAtIndexPath:index];
    if (model.courseName ==nil) {
        self.selectedgrade.text  =cell.mylabel.text;
    }
    else{
        self.selectedcourse.text = cell.mylabel.text;
        self.selectedcourse.textColor = [WKColor colorWithHexString:@"333333"];
    }
    
    [self.mycollectView deselectItemAtIndexPath:index animated:YES];
    cell.myselected.image = [UIImage imageNamed:@"role_off"];
    
    
    
}
-(void)canceldata{
    self.mycollectView.hidden = YES;
    self.backgroundView.hidden = YES;
    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.mycollectView cellForItemAtIndexPath:index];
    [self.mycollectView deselectItemAtIndexPath:index animated:YES];
    cell.myselected.image = [UIImage imageNamed:@"role_off"];
    
}
- (IBAction)sureAction:(id)sender {
    NSLog(@"self.arr =%@",self.videoarr);
    if ([self.selectedcourse.text isEqualToString:@"请选择学科"]) {
        [self.hud showAnimated:YES];
        self.hud. label.text = @"请选择学科";
        [self.hud hideAnimated:YES afterDelay:1];
    }
else{
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
        if (self.gradeNumber == -1) {
            
        }
        else{
    WKGrade *model = self.arrlist [self.gradeNumber];
            self.courseId = model.id;
        }
    NSDictionary *dic;
    NSLog(@"....%@",self.imageUrl);
     NSLog(@"....%@",self.mytextView.text);
    if (self.isCommet) {
        if (!self.imageUrl) {
            self.imageUrl =@"";
        }
        dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectedgrade.text,@"courseId": [NSNumber numberWithInteger:self.courseId],@"videoImage":self.imageUrl,@"title":self.titleTextfield.text ,@"remark":self.mytextView.text,@"commentFlag":[NSNumber numberWithInteger:self.selectedcomment.selectedSegmentIndex],@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
    }
    else{
        if (!self.imageUrl) {
            self.imageUrl =@"";
        }

     dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId":self.selectedgrade.text,@"courseId": [NSNumber numberWithInteger:self.courseId],@"title":self.titleTextfield.text ,@"videoImage":self.imageUrl,@"remark":self.mytextView.text,@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
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

}

-(void)viewWillDisappear:(BOOL)animated{
    NSLog(@"+++%@",self.upload.diction);
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
