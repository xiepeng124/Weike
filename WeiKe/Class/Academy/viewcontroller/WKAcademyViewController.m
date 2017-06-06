//
//  WKAcademyViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAcademyViewController.h"
#import "WKAcadeTableViewCell.h"
#import "WKMenuDetail.h"
#import "WKGradeTableViewCell.h"
#import "WKCourseTableViewCell.h"
#import "WKAcadeallTableViewCell.h"
#import "WKAcadeResultsViewController.h"
#import "WKAcedemyHandler.h"


@interface WKAcademyViewController ()<SLSlideMenuProtocol,UITextFieldDelegate,UITableViewDataSource, UITableViewDelegate,UIGestureRecognizerDelegate>
@property(strong,nonatomic)WKMenuDetail *detail;
@property(strong,nonatomic)UITableView *onetableview;
@property(strong,nonatomic)UITableView *twotableview;
@property(strong,nonatomic)UITableView *threetableview;
//@property (strong,nonatomic) WKGrade *grade;
@property (strong,nonatomic) NSMutableArray *arrayGrade;
@property (strong,nonatomic) NSMutableArray *arrayCourse;
@property (strong,nonatomic) NSNumber *subject;
@property (strong,nonatomic) NSNumber *Grade;
//@property(strong,nonatomic)WKMenuCollectionViewCell *cell;
@end


@implementation WKAcademyViewController
#pragma mark - init
-(void)initStyle{
    self.onetableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH*0.34, SCREEN_HEIGHT-113) style:UITableViewStylePlain];
    self.onetableview.delegate =self;
    self.onetableview.dataSource =self;
    //NSLog(@"123");
    [self.onetableview registerNib:[UINib nibWithNibName:@"WKAcadeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Stylecell"];
    [self.onetableview registerNib:[UINib nibWithNibName:@"WKAcadeallTableViewCell" bundle:nil] forCellReuseIdentifier:@"Stylecell3"];
    self.onetableview.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
    //    self.oneTableView.userInteractionEnabled =YES;
    [self.onetableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.twotableview = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.33, 64, SCREEN_WIDTH*0.34, SCREEN_HEIGHT-113) style:UITableViewStylePlain];
    self.twotableview.delegate =self;
    self.twotableview.dataSource =self;
    //NSLog(@"123");
    [self.twotableview registerNib:[UINib nibWithNibName:@"WKGradeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Gradecell"];
    self.twotableview.backgroundColor = [WKColor colorWithHexString:@"e4e4e4"];
    //    self.oneTableView.userInteractionEnabled =YES;
    [self.twotableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    self.threetableview = [[UITableView alloc]initWithFrame:CGRectMake(SCREEN_WIDTH*0.66, 64, SCREEN_WIDTH*0.34, SCREEN_HEIGHT-113) style:UITableViewStylePlain];
    self.threetableview.delegate =self;
    self.threetableview.dataSource =self;
    //NSLog(@"123");
    [self.threetableview registerNib:[UINib nibWithNibName:@"WKCourseTableViewCell" bundle:nil] forCellReuseIdentifier:@"Coursecell"];
    
    self.threetableview.backgroundColor = [WKColor colorWithHexString:@"f2f2f2"];
    //    self.oneTableView.userInteractionEnabled =YES;
    [self.threetableview setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    //[self.view insertSubview:self.oneTableView atIndex:0];
//    self.twotableview.hidden = YES;
//    self.threetableview.hidden = YES;

    [self.view addSubview:self.onetableview];
    [self.view addSubview:self.twotableview];
    [self.view addSubview:self.threetableview];

    
}
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"click me");
   }
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (tableView == self.onetableview) {
               //       self.twotableview.hidden =NO;
        self.subject = [NSNumber numberWithInteger:indexPath.row];
        [self.arrayGrade removeAllObjects];
        CATransition* trans = [CATransition animation];
        [trans setType:kCATransitionPush];
        [trans setDuration:0.5];
        [trans setSubtype:kCATransitionFromBottom];
        
        CALayer *layer = self.twotableview.layer;
        [layer addAnimation:trans forKey:nil];
        if (indexPath.row==0) {
            WKAcadeResultsViewController *result = [[WKAcadeResultsViewController alloc]init];
            result.hidesBottomBarWhenPushed = YES;
            result.schoolId = @1;
            result.typeId = @1;
            result.courseId = @0;
            result.sectionId= @0;
            result.gradeId = @0;
            [self.navigationController pushViewController:result animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
      
        }
        if (indexPath.row ==1) {
            NSDictionary *dic = @{@"typeId":[NSNumber numberWithInteger:indexPath.row],@"schoolId":@1};
            __weak typeof(self) weakself = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [WKAcedemyHandler executeGetAcademyGradeWithParameter:dic success:^(id object) {
                   
                    for (WKGrade * grade in object) {
                       
                        [weakself.arrayGrade addObject:grade];
                    };
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [self.twotableview reloadData];
                        
                    });
                } failed:^(id object) {
                    
                }];
                
            });
        }
        if (indexPath.row ==2||indexPath.row == 3) {
            NSDictionary *dic = @{@"typeId":[NSNumber numberWithInteger:indexPath.row],@"schoolId":@1};
            __weak typeof(self) weakself = self;
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [WKAcedemyHandler executeGetAcademySectionWithParameter:dic success:^(id object) {
                    for (WKGrade * grade in object) {
                        [weakself.arrayGrade addObject:grade];
                    };
                    dispatch_async(dispatch_get_main_queue(), ^{
                       [self.twotableview reloadData];
                        
                    });
                } failed:^(id object) {
                    }];
                
            });

            
            }
        for (int i=0; i<self.arrayCourse.count+1; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
            [self.twotableview deselectRowAtIndexPath:index animated:YES];
        }
        
    }
    if (tableView == self.twotableview) {
        //self.threetableview.hidden = NO;
        if (indexPath.row==0) {
            WKAcadeResultsViewController *result = [[WKAcadeResultsViewController alloc]init];
            result.schoolId = @1;
            result.typeId = self.subject;
            result.courseId = @0;
            result.gradeId = @0;
            result.sectionId= @0;
            result.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:result animated:YES];
            [tableView deselectRowAtIndexPath:indexPath animated:YES];
            
        }else{
         [self.arrayCourse removeAllObjects];
            if (self.subject.intValue !=1) {
                WKAcadeResultsViewController *result = [[WKAcadeResultsViewController alloc]init];
                WKGrade *grade= self.arrayGrade[indexPath.row-1];
                result.schoolId = @1;
                result.typeId = self.subject;
                result.courseId = @0;
                result.sectionId= [NSNumber numberWithInteger:grade.sectionId];
                result.gradeId = @0;
                result.hidesBottomBarWhenPushed = YES;
                [self.navigationController pushViewController:result animated:YES];

            }
            else{
        WKGrade *grade = [[WKGrade alloc]init];
        grade= self.arrayGrade[indexPath.row-1];
                self.Grade = [NSNumber numberWithInteger:grade.id];
            if (grade.gradeName!=nil) {
                __weak typeof(self) weakself = self;
                NSDictionary *dic = @{@"gradeId":[NSNumber numberWithInteger:grade.id],@"schoolId":@1};
                dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                    [WKAcedemyHandler executeGetAcademyCourseWithParameter:dic success:^(id object) {
                        for (WKCourse * course in object) {
                            [weakself.arrayCourse addObject:course];
                        };
                        dispatch_async(dispatch_get_main_queue(), ^{
                            [weakself.threetableview reloadData];
                            
                        });
                    } failed:^(id object) {
                    }];
                    
                });
            }
                CATransition* trans = [CATransition animation];
                [trans setType:kCATransitionPush];
                [trans setDuration:0.5];
                [trans setSubtype:kCATransitionFromTop];
                
                CALayer *layer = self.threetableview.layer;
                [layer addAnimation:trans forKey:nil];
            }
//            else{
//                self.threetableview.hidden = YES;
//            }
       
    }
    }
    if (tableView == self.threetableview) {
        WKAcadeResultsViewController *result = [[WKAcadeResultsViewController alloc]init];
        
        result.schoolId = @1;
        result.typeId = self.subject;
       
        result.sectionId= @0;
        result.gradeId = self.Grade;
        if (indexPath.row==0) {
            result.courseId = @0;
        }
        else{
            WKCourse *course = self.arrayCourse[indexPath.row-1];
            result.courseId = [NSNumber numberWithInteger:course.id];
        }
        result.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:result animated:YES];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
    

    //NSLog(@"me");
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (tableView == self.onetableview) {
        return self.detail.subjectlist.count;
    }
    if (tableView == self.twotableview) {
        //NSLog(@"self.count = %lu",self.arrayGrade.count);
        return self.arrayGrade.count+1;

    }
    //NSLog(@"self.count = %lu",self.arrayCourse.count);

    return self.arrayCourse.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.onetableview) {
        if (indexPath.row ==0) {
            WKAcadeallTableViewCell *cell = (WKAcadeallTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Stylecell3" forIndexPath:indexPath];
//            cell.CourseImage.image = [UIImage imageNamed:self.detail.Imagelist[indexPath.row]];
//            cell.CourseLabel.text = self.detail.courselist[indexPath.row];
            return cell;
        }
        WKAcadeTableViewCell *cell=(WKAcadeTableViewCell*) [tableView dequeueReusableCellWithIdentifier:@"Stylecell" forIndexPath:indexPath];
        
//        cell.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        cell.StyleLabel.text = self.detail.subjectlist[indexPath.row];
        return cell;
    }
    if (tableView == self.twotableview) {
        WKGradeTableViewCell *cell= (WKGradeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Gradecell" forIndexPath:indexPath];
        if (indexPath.row ==0) {
            cell.Gradelable.text = @"全部";

        }
        else{
        WKGrade *grade = [[WKGrade alloc]init];
        grade= self.arrayGrade[indexPath.row-1];
        if (grade.gradeName==nil) {
            if (grade.sectionId==1) {
                cell.Gradelable.text = @"初中部";
            }
           
                if (grade.sectionId==2) {
                    cell.Gradelable.text = @"高中部";
                }
            
        }
        else{
           cell.Gradelable.text = grade.gradeName;
            NSLog(@"  %lu",grade.id);
        }
        }
        //cell.textLabel.text =self.detail.gradelist[indexPath.row];
        return cell;

    }
    if (tableView == self.threetableview) {
        WKCourseTableViewCell *cell = (WKCourseTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Coursecell" forIndexPath:indexPath];
        if (indexPath.row ==0) {
            cell.CourseLabel.text = @"全部";
            
        }
        else{
            WKCourse *course = self.arrayCourse[indexPath.row-1];
            cell.CourseLabel.text = course.courseName;

        }
        //cell.CourseImage.image = [UIImage imageNamed:self.detail.Imagelist[indexPath.row]];
        
        return cell;

    }
    return nil;
    }

#pragma mark - Viewdid
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索学科/课程";
    [self ClickOnTheBlankspace];
    [self initStyle];
//    [self initCollectionView];
    self.search.delegate =self;
    

    self.detail=[[WKMenuDetail alloc]init];
    self.arrayGrade = [NSMutableArray array];
    self.arrayCourse = [NSMutableArray array];
    
//    NSIndexPath *path1 = [NSIndexPath indexPathForRow:1 inSection:0];
//    [self.onetableview selectRowAtIndexPath:path1 animated:YES scrollPosition:UITableViewScrollPositionTop];
//    [self tableView:self.onetableview didSelectRowAtIndexPath:path1];
//    
//    
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        NSIndexPath *path2 = [NSIndexPath indexPathForRow:2 inSection:0];
//        [self.twotableview selectRowAtIndexPath:path2 animated:YES scrollPosition:UITableViewScrollPositionTop];
//        [self tableView:self.twotableview didSelectRowAtIndexPath:path2];
    
        
    //});

}
#pragma mark - Action
//-(void)freshaction{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.collectionview.mj_header endRefreshing];
//    });
//}
//-(void)loadmore{
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self.collectionview.mj_footer endRefreshing];
//    });
//    
//    
//}

//-(void)selectLeftAction:(id)sender{
//    [SLSlideMenu slideMenuWithFrame:self.view.frame delegate:self direction:SLSlideMenuDirectionLeft slideOffset:250 allowSwipeCloseMenu:YES aboveNav:YES identifier:@"right1"];
//}
//- (void)slideMenu:(SLSlideMenu *)slideMenu prepareSubviewsForMenuView:(UIView *)menuView{
//    if (slideMenu.direction == SLSlideMenuDirectionLeft) {
//        NSLog(@"left...");
//        menuView.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
//        UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
//        collectionflowlayout.minimumLineSpacing=10;
//        collectionflowlayout.minimumInteritemSpacing=10;
//        collectionflowlayout.itemSize=CGSizeMake(70, 30);
//        collectionflowlayout.sectionInset=UIEdgeInsetsMake(5, 10, 5, 10);
//        self.Menucollectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 20, 250, SCREEN_HEIGHT) collectionViewLayout:collectionflowlayout];
//        self.Menucollectionview.delegate=self;
//        self.Menucollectionview.dataSource=self;
//        self.Menucollectionview.backgroundColor=[UIColor colorWithWhite:1 alpha:0.8];
//;
//        [self.Menucollectionview registerNib:[UINib nibWithNibName:@"WKMenuCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"CellMenu"];
//        [self.Menucollectionview registerClass:[WKMenuCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuHeaderView"];
//        [menuView addSubview:self.Menucollectionview];
//        //[self.Menucollectionview reloadData];
//    }
//
//}
#pragma mark - 隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
//    [self.navigationItem.titleView resignFirstResponder];
    //[self.search endEditing:YES];
    [textField resignFirstResponder];
    NSLog(@"123");
    return YES;
    
}//Click on the blank space
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
    singletap.delegate =self;
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
//    [self.view endEditing:YES];
    [self.search endEditing: YES];
}
#pragma mark - 屏蔽手势事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}
-(void)viewDidAppear:(BOOL)animated{
    

}
-(void)viewWillAppear:(BOOL)animated{
    
                //NSLog(@"self.count= %lu",self.arrayGrade.count);
    
    
    
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
