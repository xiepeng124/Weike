//
//  WKTeacherScreenViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/3.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherScreenViewController.h"
#import "WKTeachScreenCollectionViewCell.h"
#import "WKTescreenHeadCollectionReusableView.h"
#import "WKTeScreenFootCollectionReusableView.h"
#import "WKTeacherHandler.h"
@interface WKTeacherScreenViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)NSMutableArray *gradeList;
@property(strong,nonatomic)NSMutableArray *courseList;
@property (strong,nonatomic)WKTeachScreenCollectionViewCell *cell1;
@property (strong,nonatomic)WKTeachScreenCollectionViewCell *cell2;

@property(strong,nonatomic)NSNumber *gradeId;
@property(strong,nonatomic)NSNumber *courseId;
@end

@implementation WKTeacherScreenViewController
-(NSMutableArray*)gradeList{
    if (!_gradeList) {
        _gradeList = [NSMutableArray array];
    }
    return _gradeList;
}
-(NSMutableArray*)courseList{
    if (!_courseList) {
        _courseList = [NSMutableArray array];
    }
    return _courseList;
}
-(void)initdata{
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSDictionary *dic =@{@"schoolId":SCOOLID,@"typeId":@1};
        [WKTeacherHandler executeGetAcademyGradeWithParameter:dic success:^(id object) {
            for (WKGrade *grade in object ) {
                //NSLog(@"object =%@",object);
                [weakself.gradeList addObject:grade];
                //NSLog(@"grade = %@",weakself.gradeList);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.GradeCollectionView reloadData];
                    NSIndexPath *path2 = [NSIndexPath indexPathForItem:0 inSection:0];
                    [weakself.GradeCollectionView selectItemAtIndexPath:path2 animated:YES scrollPosition:UICollectionViewScrollPositionTop];
                    [weakself  collectionView:self.GradeCollectionView cellForItemAtIndexPath:path2].selected = YES;
                [weakself.GradeCollectionView cellForItemAtIndexPath:path2].selected =YES;

            });
        } failed:^(id object) {
            
        }];
        
    });

}
-(void)initCollection{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 2;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-35)/4, 33);
    layout.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
    self.GradeCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 115) collectionViewLayout:layout];
    UICollectionViewFlowLayout *layout2 = [[UICollectionViewFlowLayout alloc]init];
    layout2.minimumLineSpacing = 4;
    layout2.minimumInteritemSpacing = 2;
    layout2.itemSize = CGSizeMake((SCREEN_WIDTH-35)/4, 33);
    layout2.sectionInset = UIEdgeInsetsMake(0, 10, 10, 10);
     self.CourseCollectionView  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 115, SCREEN_WIDTH, (115-28)+38*((self.courseList.count+1)/4+1)) collectionViewLayout:layout2];
    self.GradeCollectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    [self.GradeCollectionView registerNib:[UINib nibWithNibName:@"WKTeachScreenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"mycell"];
    [self.GradeCollectionView registerNib:[UINib nibWithNibName:@"WKTescreenHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Head"];
    
    self.GradeCollectionView.delegate = self;
    self.GradeCollectionView.dataSource = self;
    self.CourseCollectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    [self.CourseCollectionView registerNib:[UINib nibWithNibName:@"WKTeachScreenCollectionViewCell" bundle:nil]
                forCellWithReuseIdentifier:@"mycell2"];
    [self.CourseCollectionView registerNib:[UINib nibWithNibName:@"WKTescreenHeadCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Head2"];
    [self.CourseCollectionView registerNib:[UINib nibWithNibName:@"WKTeScreenFootCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Foot"];
    self.CourseCollectionView.delegate = self;
    self.CourseCollectionView.dataSource = self;
    
    [self.view addSubview:self.CourseCollectionView];
    [self.view addSubview:self.GradeCollectionView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    

    [self initCollection];
    [self initdata];
   
     NSIndexPath *path2 = [NSIndexPath indexPathForItem:0 inSection:0];
     
    
    //NSIndexPath *path1 = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.CourseCollectionView selectItemAtIndexPath:path2 animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    [self  collectionView:self.CourseCollectionView cellForItemAtIndexPath:path2].selected = YES;
    

    // Do any additional setup after loading the view.
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView ==self.GradeCollectionView ) {
        return self.gradeList.count+1;
       
    }
        return self.courseList.count+1;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView==self.GradeCollectionView) {
        WKTeachScreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell" forIndexPath:indexPath];
        if (indexPath.row==0) {
            
            cell.TeachLabel.text = @"全部";
        }
        else{
            WKGrade *grade = self.gradeList[indexPath.row-1];
            cell.TeachLabel.text = grade.gradeName;
        }
        if (cell.selected) {
            //NSLog(@"11111");
            cell.selectedImage.image =[UIImage imageNamed:@"pitch-up"];
            cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
            cell.TeachLabel.textColor = [WKColor colorWithHexString:@"4481c2"];
        }
        else{
            cell.selectedImage.image = nil;
            
            cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
            cell.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
        }
        return cell;
    }
     WKTeachScreenCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"mycell2" forIndexPath:indexPath];
    if (indexPath.row == 0) {
        cell.TeachLabel.text = @"全部";
    }
    else{
        WKCourse *course = self.courseList[indexPath.row -1];
        cell.TeachLabel.text = course.courseName;
    }
    if (cell.selected) {
        cell.selectedImage.image =[UIImage imageNamed:@"pitch-up"];
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"4481c2"];
    }
    else{
        cell.selectedImage.image = nil;
        
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
    }

    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{

          //cell.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        //NSLog(@"zai zhe li");
   
    if (collectionView ==self.GradeCollectionView) {
         [self.courseList removeAllObjects];
         self.courseId = @0;
        //static NSString *mycell = @"cellid";
        
//        WKGrade *grade = self.gradeList [indexPath.row];
        WKTeachScreenCollectionViewCell *cell =(WKTeachScreenCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
        self.cell1 = cell;
        cell.selectedImage.image =[UIImage imageNamed:@"pitch-up"];
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"4481c2"];
        //NSLog(@"cell222 =%d",cell.selected);
        //[self.CourseCollectionView deselectItemAtIndexPath:indexPath animated:YES];
        if (indexPath.row ==0) {
            //NSLog(@"2222");
            self.gradeId = @0;
           
            [self.CourseCollectionView reloadData];
             self.CourseCollectionView.frame = CGRectMake(0, 115, SCREEN_WIDTH, (115-28)+38*((self.courseList.count+1)/4+1));
            [self.delegate Changeframe:self.CourseCollectionView.frame.size.height];
            for (int i=0; i<self.courseList.count; i++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
                [self.CourseCollectionView deselectItemAtIndexPath:index animated:YES];
                
  
                //[self.selectedIndexSet removeIndex:indexPath.item];
            }
            NSIndexPath *index1 = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.CourseCollectionView selectItemAtIndexPath:index1 animated:YES scrollPosition:UICollectionViewScrollPositionTop];
            [self collectionView:self.CourseCollectionView cellForItemAtIndexPath:index1].selected = YES;
             [self.CourseCollectionView cellForItemAtIndexPath:index1].selected = YES;
            
        }
        else{
            self.cell2 = [[WKTeachScreenCollectionViewCell alloc]init];
            self.cell2.TeachLabel.text = @"全部";
            WKGrade *grade = [[WKGrade alloc]init];
            grade= self.gradeList[indexPath.row-1];
            self.gradeId =[NSNumber numberWithInteger:grade.id];
            if (grade.gradeName!=nil) {
                __weak typeof(self) weakself = self;
                NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:grade.id],@"schoolId":SCOOLID};
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [WKTeacherHandler executeGetAcademyCourseWithParameter:dic success:^(id object) {
                        for (WKCourse * course in object) {
                            [weakself.courseList addObject:course];
                        };
                      
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakself.CourseCollectionView reloadData];
                            if ((self.courseList.count+1)%4!=0) {
                                weakself.CourseCollectionView.frame = CGRectMake(0, 115, SCREEN_WIDTH, (115-28)+38*((self.courseList.count+1)/4+1));
                              
                            }
                            else{
                            weakself.CourseCollectionView.frame = CGRectMake(0, 115, SCREEN_WIDTH, (115-28)+38*((self.courseList.count+1)/4));
                            }
                            [self.delegate Changeframe:weakself.CourseCollectionView.frame.size.height];
                            for (int i=0; i<self.courseList.count; i++) {
                                NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
                                //NSLog(@"wei deselect");
                                
                                [self.CourseCollectionView deselectItemAtIndexPath:index animated:YES];
                               // NSLog(@"%d",[self.CourseCollectionView cellForItemAtIndexPath:index].selected);
                            }

                        });
                    } failed:^(id object) {
                    }];
                    
                });
            }
 
        }
        
    }
    if (collectionView== self.CourseCollectionView) {
       
        if (indexPath.row == 0) {
            //NSLog(@"4444");
            self.courseId = @0;
        }
        else{
            WKCourse *course = self.courseList[indexPath.row-1];
            self.courseId =[NSNumber numberWithInteger:course.id] ;
        }
        WKTeachScreenCollectionViewCell *cell =(WKTeachScreenCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
        cell.selectedImage.image =[UIImage imageNamed:@"pitch-up"];
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"4481c2"];
        self.cell2 =cell;
    }
    
    
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
//    if (collectionView ==self.GradeCollectionView) {
           WKTeachScreenCollectionViewCell *cell =(WKTeachScreenCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
        cell.selectedImage.image = nil;
    
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
    
    //}
//    if (collectionView == self.CourseCollectionView) {
//        WKTeachScreenCollectionViewCell *cell =(WKTeachScreenCollectionViewCell*) [collectionView cellForItemAtIndexPath:indexPath];
//        cell.selectedImage.image = nil;
//        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
//        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
//
//    }
   
}
//- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
//{
//    return YES;
//}
- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"%s", __FUNCTION__);
    return YES;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.CourseCollectionView) {
        if (kind ==UICollectionElementKindSectionHeader) {
            WKTescreenHeadCollectionReusableView *head = (WKTescreenHeadCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Head2" forIndexPath:indexPath];
            head.TeaScreenImage.image = [UIImage imageNamed:@"subject_teach"];
           [head.TeaScreenLabel setTitle:@"科目" forState:UIControlStateNormal];
            return head;
        }
        WKTeScreenFootCollectionReusableView *Foot = (WKTeScreenFootCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"Foot" forIndexPath:indexPath];
        [Foot.cancelButton addTarget:self action:@selector(cancelAllselected) forControlEvents:UIControlEventTouchUpInside];
        [Foot.SureButton addTarget:self action:@selector(getResults) forControlEvents:UIControlEventTouchUpInside];
        return Foot;
        
    }
    WKTescreenHeadCollectionReusableView *head = (WKTescreenHeadCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Head" forIndexPath:indexPath];
    return head;
}
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 35);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    if (collectionView == self.GradeCollectionView) {
        return CGSizeMake(0, 0);
    }
    return CGSizeMake(SCREEN_WIDTH, 48);
}
-(void)getResults{
    
    [self.delegate GetSelectefResultGradeCell:self.cell1.TeachLabel.text coursecell:self.cell2.TeachLabel.text];
    //NSLog(@"%@_____",self.cell1.TeachLabel.text);
    [self.delegate GetTeacherGradeId:self.gradeId courseId:self.courseId];
    //NSLog(@"%@...%@",self.gradeId,self.courseId);
    
}
-(void)cancelAllselected{
    //NSLog(@"111");
    for (int i=0; i<self.gradeList.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForItem:i inSection:0];
        [self.GradeCollectionView deselectItemAtIndexPath:index animated:YES];
        
    }
   
    [self.GradeCollectionView reloadData];
    NSIndexPath *path2 = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.GradeCollectionView selectItemAtIndexPath:path2 animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    [self  collectionView:self.GradeCollectionView cellForItemAtIndexPath:path2].selected =YES;
    [self.GradeCollectionView cellForItemAtIndexPath:path2].selected = YES;
    self.cell1 =(WKTeachScreenCollectionViewCell*) [self.GradeCollectionView cellForItemAtIndexPath:path2];
    //self.cell1.TeachLabel.text = @"全部";
    self.gradeId = @0;
    for ( int j=0; j<self.courseList.count; j++) {
         NSIndexPath *index = [NSIndexPath indexPathForItem:j inSection:0];
        [self.CourseCollectionView deselectItemAtIndexPath:index animated:YES];
        
        
    }
    [self.courseList removeAllObjects];
    [self.CourseCollectionView reloadData];
    NSIndexPath *path = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.CourseCollectionView selectItemAtIndexPath:path animated:YES scrollPosition:UICollectionViewScrollPositionTop];
    [self  collectionView:self.CourseCollectionView cellForItemAtIndexPath:path].selected = YES;
    [self.CourseCollectionView cellForItemAtIndexPath:path].selected = YES;
    self.cell2.TeachLabel.text = nil;
    self.courseId = @0;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
//    if (touch.view.frame.size.height==40) {
//        return YES;
//    }
    return NO;
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
