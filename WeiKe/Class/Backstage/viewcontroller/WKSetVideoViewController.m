//
//  WKSetVideoViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/15.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSetVideoViewController.h"
#import "WKVideoClassfiCollectionViewCell.h"
#import "WKAcedemyHandler.h"
#import "WKTeachclassificationCollectionViewController.h"
@interface WKSetVideoViewController ()<UITextFieldDelegate,TeachClassDelegate>
@property (weak, nonatomic) IBOutlet UILabel *videoMenu;
@property (weak, nonatomic) IBOutlet UILabel *gradeLabel;
@property (weak, nonatomic) IBOutlet UILabel *courseLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *classify;
@property (weak, nonatomic) IBOutlet UITextField *selectedgrade;
@property (weak, nonatomic) IBOutlet UITextField *selectedcourse;

@property (weak, nonatomic) IBOutlet UIButton *sureButton;
@property (weak, nonatomic) IBOutlet UIView *lineview1;
@property (weak, nonatomic) IBOutlet UIView *lineview2;
@property (strong,nonatomic)UICollectionView *mycollectView;
@property (strong,nonatomic)UIView *backgroundView;

@property (strong,nonatomic)NSMutableArray *arrlist;
@property (assign,nonatomic)NSInteger gradeNumber;
@property (assign,nonatomic)NSInteger courseNumber;
@property(strong,nonatomic)UIButton *button;
@property(strong,nonatomic)NSMutableArray *arrcount;
@property (strong,nonatomic) WKTeachclassificationCollectionViewController *colletionviewcontroller;
@property (strong,nonatomic)MBProgressHUD *hud;
@property (strong ,nonatomic) WKGrade *gradeModel;

@end

@implementation WKSetVideoViewController
-(NSMutableArray*)arrcount{
    if (!_arrcount) {
        _arrcount=[NSMutableArray array];
    }
    return  _arrcount;
}
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
    [self.classify setTintColor:[WKColor colorWithHexString:GREEN_COLOR]];
    switch (self.videoModel.videoType ) {
        case 1:
            self.classify.selectedSegmentIndex =0;
            self.courseLabel.hidden = NO;
            self.selectedcourse.hidden = NO;
            break;
        case 2:
            self.classify.selectedSegmentIndex =1;
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            break;
        case 3:
            self.classify.selectedSegmentIndex =2;
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            break;

            
        default:
            break;
    }
    self.selectedgrade.textColor = [WKColor colorWithHexString:@"333333"];
    self.selectedgrade.text = self.videoModel.gradeName;
    self.selectedcourse.textColor = [WKColor colorWithHexString:@"333333"];
    self.selectedcourse.text = self.videoModel.courseName;
    
    [self.sureButton setTitleColor:[WKColor colorWithHexString:LIGHT_COLOR] forState: UIControlStateNormal];
    [self.sureButton setBackgroundColor:[WKColor colorWithHexString:GREEN_COLOR]];
    self.sureButton.layer.cornerRadius = 3;
    [self.sureButton addTarget:self action:@selector(updateVideoset) forControlEvents:UIControlEventTouchUpInside];
    self.lineview1.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    self.lineview2.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
//    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectgradeAction)];
//    tap1.numberOfTouchesRequired =1;
//    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(selectcourseAction)];
//    tap2.numberOfTouchesRequired =1;
    self.selectedgrade.delegate = self;
    self.selectedcourse.delegate = self;
    self.selectedgrade.userInteractionEnabled = YES;
    self.selectedcourse.userInteractionEnabled = YES;
//
//    [self.selectedgrade addGestureRecognizer:tap1];
//    [self.selectedcourse addGestureRecognizer:tap2];
//    self.backgroundView  = [[UIView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64)];
//    self.backgroundView.backgroundColor = [UIColor blackColor];
//    self.backgroundView.alpha = 0.6;
//    self.backgroundView.hidden = YES;
//    [self.view addSubview:self.backgroundView];

    //self.backgroundView.hidden = YES;
//    self.contentviews = [[UIView alloc]init];
//  self.contentviews.backgroundColor = [UIColor whiteColor];
//    self.contentviews.layer.cornerRadius = 3;
//    self.contentviews.layer.masksToBounds = YES;
////    self.contentviews.alpha = 1;
//    //[self.view addSubview:self.contentviews];
//    __weak  typeof(self) weakself = self;
//    [self.contentviews mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakself.view);
//        make.top.mas_equalTo(154);
//        make.size.mas_equalTo(CGSizeMake(270, 305));
//    }];
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
//-(void)initconllectionView{
//    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.minimumLineSpacing = 20;
//    layout.minimumInteritemSpacing = 0;
//    layout.itemSize = CGSizeMake((270/2-40), 17);
//    layout.sectionInset = UIEdgeInsetsMake(20, 20, 5, 20);
//    layout.footerReferenceSize = CGSizeMake(270, 55);
//    layout.sectionFootersPinToVisibleBounds = YES;
//    self.mycollectView = [[UICollectionView alloc]initWithFrame:
//                                           CGRectMake(0, 0, 0,0) collectionViewLayout:layout];
//    self.mycollectView.dataSource = self;
//    self.mycollectView.delegate = self;
//    self.mycollectView.layer.cornerRadius = 3;
//    self.mycollectView.layer.masksToBounds = YES;
//    [self.mycollectView registerNib:[UINib nibWithNibName:@"WKVideoClassfiCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
//    [self.mycollectView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer"];
//    self.mycollectView.layer.cornerRadius = 3;
//    self.mycollectView.layer.masksToBounds = YES;
//    self.mycollectView.backgroundColor = [UIColor whiteColor];
//    self.mycollectView.hidden = YES;
//    [self.view addSubview:self.mycollectView];
//     __weak  typeof(self) weakself = self;
//    [self.mycollectView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(weakself.view);
//        make.top.mas_equalTo(154);
//        make.size.mas_equalTo(CGSizeMake(270, 165));
//    }];
//
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[WKColor colorWithHexString:LIGHT_COLOR]];
    [self initStyle];
   // [self initconllectionView];
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


//- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
//    if (self.arrlist.count == 0) {
//        return 1;
//    }
//    return self.arrlist.count;
//}
//
//
//- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
//    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
////    [collectionView selectItemAtIndexPath:[NSIndexPath indexPathForItem: self.gradeNumber inSection:0] animated:YES scrollPosition:UICollectionViewScrollPositionTop];
////    [collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:self.gradeNumber inSection:0]];
//    if (self.arrlist.count ==0) {
//        return cell;
//    }
//  
//    WKGrade *model = self.arrlist[indexPath.row];
//    if (model.courseName==nil) {
//        if (model.gradeName==nil) {
//            if (model.sectionId==1) {
//                cell.mylabel.text = @"初中部";
//            }
//            
//            else if (model.sectionId==2) {
//                cell.mylabel.text = @"高中部";
//            }
//            
//        }
//        else{
//            cell.mylabel.text = model.gradeName;
//        }
//    }
//    else{
//        cell.mylabel.text = model.courseName;
//    }
//    
// cell.backgroundColor = [UIColor whiteColor];
//    return cell;
//}
//- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
//    UICollectionReusableView *foot = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Footer" forIndexPath:indexPath];;
//    foot.backgroundColor = [UIColor whiteColor];
//   
//    _button = [UIButton buttonWithType:UIButtonTypeCustom];
//    [_button setTitle:@"确定" forState:UIControlStateNormal];
//    [_button setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    _button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
//    _button.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
//    _button.layer.cornerRadius = 3;
//    UIButton * button2 = [UIButton buttonWithType:UIButtonTypeCustom];
//    [button2 setTitle:@"取消" forState:UIControlStateNormal];
//    [button2 setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
//    button2.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
//    [_button addTarget:self action:@selector(keepdata) forControlEvents:UIControlEventTouchUpInside];
//    [button2 addTarget:self action:@selector(canceldata) forControlEvents:UIControlEventTouchUpInside];
//    //_button.userInteractionEnabled = NO;
//  [foot addSubview:_button];
//   [foot addSubview:button2];
//    [_button  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-15);
//        make.bottom.mas_equalTo(-10);
//        make.size.mas_equalTo(CGSizeMake(54, 30));
//    }];
//    [button2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.bottom.mas_equalTo(-10);
//        make.size.mas_equalTo(CGSizeMake(54, 30));
//        make.right.mas_equalTo(-(25+54));
//    }];
//    
//      return foot;
//}
//- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
//    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
//     //_button.userInteractionEnabled = YES;
//    cell.myselected.image = [UIImage imageNamed:@"role_on"];
//   WKGrade *model = self.arrlist [indexPath.row];
//             self.gradeNumber = indexPath.row ;
//    if (model.courseName == nil) {
//        self.courseNumber = self.gradeNumber;
//    }
//   }
//- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    WKVideoClassfiCollectionViewCell *cell =(WKVideoClassfiCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
//     //_button.userInteractionEnabled = NO;
//    cell.myselected.image = [UIImage imageNamed:@"role_off"];
//    
//}

//-(void)selectgradeAction{
//    self.mycollectView.hidden =NO;
//    self.backgroundView.hidden = NO;
//    for (int i= 0; i<self.arrlist.count; i++) {
//        NSIndexPath *index2 = [NSIndexPath indexPathForItem:0 inSection:0];
//        [self.mycollectView deselectItemAtIndexPath:index2 animated:YES];
//        [self.mycollectView cellForItemAtIndexPath:index2].selected = NO;
//    }
//
//    [self.arrcount addObject:[NSNumber numberWithInteger:self.classify.selectedSegmentIndex]];
//    //WKGrade *model = self.arrlist[0];
//   
////    if (self.arrcount.count==2) {
////        if ([self.arrcount[0]intValue]==[self.arrcount[1]intValue]&&model.courseName==nil) {
////            [self.arrcount removeObjectAtIndex:0];
////        }
////
////    }
//    
////        else  {
//               [self.arrlist removeAllObjects];
//            if (self.classify.selectedSegmentIndex ==0) {
//                //NSLog(@"2222");
//                NSDictionary *dic = @{@"typeId":@1,@"schoolId":SCOOLID};
//                __weak typeof(self) weakself = self;
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [WKAcedemyHandler executeGetAcademyGradeWithParameter:dic success:^(id object) {
//                        NSLog(@"object = %@",object);
//                        for (WKGrade * grade in object) {
//                            
//                            [weakself.arrlist addObject:grade];
//                        };
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [weakself.mycollectView reloadData];
//                            
//                            [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
//                                make.centerX.equalTo(weakself.view);
//                                make.top.mas_equalTo(154);
//                                make.size.mas_equalTo(CGSizeMake(270, 165));
//                            }];
//                        });
//                    } failed:^(id object) {
//                        NSLog(@"123");
//                    }];
//                    
//                });
//            }
//            else {
//                NSDictionary *dic = @{@"typeId":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex+1],@"schoolId":SCOOLID};
//                __weak typeof(self) weakself = self;
//                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                    [WKAcedemyHandler executeGetAcademySectionWithParameter:dic success:^(id object) {
//                        for (WKGrade * grade in object) {
//                            [weakself.arrlist addObject:grade];
//                        };
//                        dispatch_async(dispatch_get_main_queue(), ^{
//                            [weakself.mycollectView reloadData];
//                            [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
//                                make.centerX.equalTo(weakself.view);
//                                make.top.mas_equalTo(154);
//                                make.size.mas_equalTo(CGSizeMake(270, 91));
//                            }];
//                            
//                        });
//                    } failed:^(id object) {
//                    }];
//                    
//                });
//                
//                
//            }
//
//        //}
////[self.arrcount removeObjectAtIndex:0];
//
//        // _button.userInteractionEnabled = NO;
//    
// 
//   // NSLog(@"1111");
//    
//}
//-(void)selectcourseAction{
//    self.mycollectView.hidden =NO;
//    self.backgroundView.hidden = NO;
//    WKGrade *grade = [[WKGrade alloc]init];
//    grade= self.arrlist[self.gradeNumber];
//    //self.Grade = [NSNumber numberWithInteger:grade.id];
//        if (grade.gradeName!=nil) {
//            [self.arrlist removeAllObjects];
//
//        __weak typeof(self) weakself = self;
//        NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:grade.id],@"schoolId":SCOOLID};
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//            [WKAcedemyHandler executeGetAcademyCourse2WithParameter:dic success:^(id object) {
//                for (WKGrade * course in object) {
//                    [weakself.arrlist addObject:course];
//                };
//                dispatch_async(dispatch_get_main_queue(), ^{
//                    [weakself.mycollectView reloadData];
//                    [weakself.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
//                        make.centerX.equalTo(weakself.view);
//                        make.top.mas_equalTo(154);
//                        make.size.mas_equalTo(CGSizeMake(270, 310));
//                    }];
//                });
//            } failed:^(id object) {
//            }];
//            
//        });
//   }
//        else{
//            [self.mycollectView mas_updateConstraints:^(MASConstraintMaker *make) {
//                make.centerX.equalTo(self.view);
//                make.top.mas_equalTo(154);
//                make.size.mas_equalTo(CGSizeMake(270, 310));
//            }];
//
//        }
//}
//-(void)keepdata{
//    self.mycollectView.hidden = YES;
//    self.backgroundView.hidden = YES;
//     WKGrade *model = self.arrlist [self.gradeNumber];
//    
//    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
//    WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.mycollectView cellForItemAtIndexPath:index];
//    if (model.courseName ==nil) {
//         self.selectedgrade.text  =cell.mylabel.text;
//    }
//    else{
//        self.selectedcourse.text = cell.mylabel.text;
//    }
//   
//    [self.mycollectView deselectItemAtIndexPath:index animated:YES];
//    cell.myselected.image = [UIImage imageNamed:@"role_off"];
//    
//    
//    
//}
//-(void)canceldata{
//    self.mycollectView.hidden = YES;
//    self.backgroundView.hidden = YES;
//    NSIndexPath *index = [NSIndexPath indexPathForRow:self.gradeNumber inSection:0];
//      WKVideoClassfiCollectionViewCell *cell = (WKVideoClassfiCollectionViewCell*)[self.mycollectView cellForItemAtIndexPath:index];
//    [self.mycollectView deselectItemAtIndexPath:index animated:YES];
//    cell.myselected.image = [UIImage imageNamed:@"role_off"];
//    
//}
- (IBAction)videoTypeAction:(UISegmentedControl *)sender {
    self.selectedgrade.text = nil;
    self.selectedcourse.text = nil;
    switch (sender.selectedSegmentIndex) {
        case 0:
            
            self.courseLabel.hidden = NO;
            self.selectedcourse.hidden = NO;
            break;
        case 1:
            
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            break;
        case 2:
           
            self.courseLabel.hidden = YES;
            self.selectedcourse.hidden = YES;
            break;
            
            
        default:
            break;
    }


}
-(void)updateVideoset{
    if (!self.selectedgrade.text.length) {
        self.hud.label.text = @"请选择年级";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    if (!self.selectedgrade.text.length||self.classify.selectedSegmentIndex==0) {
        self.hud.label.text = @"请选择学科";
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

   
    
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"videoType":[NSNumber numberWithInteger:self.classify.selectedSegmentIndex +1],@"gradeId": self.selectedgrade.text,@"courseId":couseId };
    [WKBackstage executeGetBackstageSetVideoWithParameter:dic success:^(id object) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
        
    } failed:^(id object) {
        
    }];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    //NSLog(@"class = %@",NSStringFromClass([touch.view class]));
    
    if (touch.view != self.colletionviewcontroller.collectionView) {
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
