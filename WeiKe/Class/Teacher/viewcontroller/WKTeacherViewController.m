//
//  WKTeacherViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherViewController.h"
#import "WKTeacherCollectionViewCell.h"
#import "WKTeacherHeaderCollectionReusableView.h"
#import "WKTeacherHandler.h"
#import "WKTeacherScreenViewController.h"
@interface WKTeacherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate,TeacherHeaderDelegate,TeacherScreenDelegate>
@property(strong,nonatomic)UICollectionView *collectionview;
@property(strong,nonatomic)NSNumber* page;
@property(strong,nonatomic)NSNumber* gradeId;
@property(strong,nonatomic)NSNumber* courseId;
@property(assign,nonatomic)BOOL myTea;
@property(strong,nonatomic)NSDictionary *dic;
@property(strong,nonatomic)NSMutableArray *teacherList;
@property (strong,nonatomic)WKTeacherHeaderCollectionReusableView *headCollection;
@property(strong,nonatomic)WKTeacherScreenViewController *TeacherScreen;
@property(strong,nonatomic)UIView *backView;
@property (strong,nonatomic)UIButton *mybutton;
@end

@implementation WKTeacherViewController
#pragma mark - init
-(NSMutableArray*)teacherList{
    if (!_teacherList) {
        _teacherList = [NSMutableArray array];
    }
    return _teacherList;
}
-(void)initCollectionView{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
    collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/3-13, (SCREEN_WIDTH/3-13)*1.5);
    collectionflowlayout.sectionInset=UIEdgeInsetsMake(5, 10, 5, 10);
    collectionflowlayout.sectionHeadersPinToVisibleBounds = YES;
  //collectionflowlayo
    self.collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113) collectionViewLayout:collectionflowlayout];
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    self.collectionview.hidden = NO;

    self.collectionview.backgroundColor=[UIColor whiteColor];
   
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKTeacherCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellid"];
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKTeacherHeaderCollectionReusableView" bundle:nil]  forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
        self.collectionview.mj_header=[MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(freshaction)];
    CATransition* trans = [CATransition animation];
    [trans setType:kCATransitionMoveIn];
    [trans setDuration:0.8];
    [trans setSubtype:kCATransitionFromLeft];
    
    CALayer *layer = self.collectionview.layer;
    [layer addAnimation:trans forKey:nil];
    self.collectionview.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.collectionview.mj_header.automaticallyChangeAlpha=YES;
    [self.collectionview.mj_header beginRefreshing];
    self.collectionview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.collectionview.mj_footer.automaticallyChangeAlpha=YES;
    //self.collectionview.hidden = YES;
    [self.view addSubview:self.collectionview];
}
-(void)initData{
    __weak typeof(self) weakself = self;
    [self.teacherList removeAllObjects];
   
    self.dic =@{@"page":self.page,@"token":TOKEN,@"schoolId":SCOOLID,@"userType":USERTYPE,@"gradeId":self.gradeId,@"courseId":self.courseId,@"myTea":[NSNumber numberWithBool:self.myTea]};
     NSLog(@"mtteach=%@...",[self.dic objectForKey:@"gradeId"]);
    NSLog(@"course = %@",[self.dic objectForKey:@"courseId"]);
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKTeacherHandler executeGetTeacherListWithParameters:self.dic success:^(id object) {
            for (WKTeacherList *teach in object) {
                [weakself.teacherList addObject:teach];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.collectionview reloadData];
            });
        } failed:^(id object) {
            
        }];

    });
}
-(void)GetTeacherGradeId:(NSNumber *)grade courseId:(NSNumber *)course{
    if (grade==nil) {
        self.page=@1;
        self.gradeId=@0;
        self.courseId=@0;
        //self.myTea=0;

    }
   else if (course == nil) {
        self.page=@1;
        self.gradeId=grade;
        self.courseId=@0;
        //self.myTea=0;
    }
    else{
        self.page =@1;
    self.gradeId=grade;
    self.courseId=course;
    //self.myTea=0;
   // NSLog(@"...%@",self.gradeId);
    }
    [self initData];
}
-(void)GetSelectefResultGradeCell:(NSString *)grade coursecell:(NSString *)course{
    
    self.headCollection.garde.text =[grade substringToIndex:2];
    if (course.length==1) {
        self.headCollection.course.text = course ;
    }
    else{
    self.headCollection.course.text = [course substringToIndex:2] ;
    }
    if ([self.headCollection.garde.text isEqualToString:@"全部"]) {
        self.headCollection.course.text = nil;

    }
    if (grade.length ==0) {
        self.headCollection.garde.text =@"全部";
    }
    else if(course.length ==0&&![self.headCollection.garde.text isEqualToString:@"全部"]){
        self.headCollection.course.text = @"全部";
    }
    self.headCollection.bottomButton.selected = NO;
    self.TeacherScreen.view.hidden = YES;
    self.backView.hidden = YES;
}
-(void)ChanggeMyteacher:(UIButton *)selected{
    if (selected.selected) {
        self.myTea = 1;
    }
    else{
        self.myTea = 0;
    }
    if (self.mybutton==nil||!self.mybutton.selected) {
        NSLog(@"ffffff");
        [self initData];
    }
}
-(void)ChangeBottom:(UIButton*)selected{
    self.mybutton = selected;
    //NSLog(@"delegate1");
    //    NSIndexPath *path2 = [NSIndexPath indexPathForItem:0 inSection:0];
//    [self.TeacherScreen.CourseCollectionView selectItemAtIndexPath:path2 animated:YES scrollPosition:UICollectionViewScrollPositionTop];
//    [self  collectionView:self.TeacherScreen.GradeCollectionView cellForItemAtIndexPath:path2];
    if (selected.selected) {
        self.TeacherScreen.view.hidden = NO;
        self.backView.hidden = NO;
        //NSLog(@"delegate2");
    }
    else{
        self.TeacherScreen.view.hidden = YES;
        self.backView.hidden = YES;
    }
    
}
-(void)Changeframe:(CGFloat)height{
    self.TeacherScreen.view.frame = CGRectMake(0, 104, SCREEN_WIDTH,self.TeacherScreen.GradeCollectionView.frame.size.height+height);
    self.backView.frame= CGRectMake(0, 104+self.TeacherScreen.view.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-104-self.TeacherScreen.view.frame.size.height);
   
   

}

#pragma mark - collectiondatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.teacherList.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKTeacherCollectionViewCell *cell=(WKTeacherCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
    //cell.backgroundColor=[UIColor whiteColor];
    WKTeacherList *teach = self.teacherList[indexPath.row];
    [cell.teacherImage sd_setImageWithURL:[NSURL URLWithString:teach.imgFileUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    cell.teachername.text = teach.teacherName;
    cell.grade.text = teach.gradeName;
    return cell;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WKTeacherHeaderCollectionReusableView *header=(WKTeacherHeaderCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    self.headCollection = header;
    //[header.bottomButton setHidden:NO];
    header.delegate = self;
        return header;
}
#pragma mark - collectiondelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 35);
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索老师";
     self.search.delegate =self;
    [self initCollectionView];
    self.TeacherScreen = [[WKTeacherScreenViewController alloc]init];
    self.TeacherScreen.delegate =self;
    self.TeacherScreen.GradeCollectionView.dataSource = self;
    self.TeacherScreen.CourseCollectionView.delegate = self;
    self.TeacherScreen.view.frame = CGRectMake(0, 104, SCREEN_WIDTH,self.TeacherScreen.GradeCollectionView.frame.size.height+self.TeacherScreen.CourseCollectionView.frame.size.height);
    
    self.backView = [[UIView alloc]initWithFrame:CGRectMake(0, 104+self.TeacherScreen.view.frame.size.height, SCREEN_WIDTH, SCREEN_HEIGHT-104-self.TeacherScreen.view.frame.size.height)];
    self.backView.backgroundColor = [UIColor blackColor];
    self.backView.alpha = 0.65;
    self.TeacherScreen.view.hidden = YES;
    self.backView.hidden = YES;
    [self.view addSubview:self.TeacherScreen.view];
    [self.view addSubview:self.backView];
    
        [self addChildViewController:self.TeacherScreen];
    self.page=@1;
    self.gradeId=@0;
    self.courseId=@0;
    self.myTea=0;
//    [self.view addSubview:self.TeacherScreen.CourseCollectionView];
    [self initdictionry];
    [self initData];
    
    // Do any additional setup after loading the view.
}

-(void)initdictionry{
   
    NSLog(@"objecttoken =%@",[[NSUserDefaults standardUserDefaults]objectForKey:@"token"]);
    self.dic =@{@"page":self.page,@"token":TOKEN,@"schoolId":SCOOLID,@"userType":USERTYPE,@"gradeId":self.gradeId,@"courseId":self.courseId,@"myTea":[NSNumber numberWithBool:self.myTea]};
}
-(void)viewDidAppear:(BOOL)animated{
    
}

#pragma mark - Action
//-(void)ChangeSelectedImage{
//    self.selectedbutton.selected = !self.selectedbutton.selected;
-(void)freshaction{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionview.mj_header endRefreshing];
    });
}
-(void)loadmore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionview.mj_footer endRefreshing];
    });
    
    
}
#pragma mark - 隐藏键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    [textField resignFirstResponder];
    NSLog(@"123");
    return YES;
    
}//Click on the blank space
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
    [self.search endEditing:YES];
    //[self.view endEditing:YES];
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