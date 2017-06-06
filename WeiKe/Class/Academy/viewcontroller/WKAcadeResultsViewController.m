//
//  WKAcadeResultsViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAcadeResultsViewController.h"
#import "WKHomeCollectionViewCell.h"
#import "WKTeacherHeaderCollectionReusableView.h"
#import "WKAcedemyHandler.h"
@interface WKAcadeResultsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic) UICollectionView *collectionview ;
@property (strong,nonatomic)NSMutableArray *Videolist;
@property (strong,nonatomic)NSDictionary *dic;
@end

@implementation WKAcadeResultsViewController

-(void)initcollection{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
    collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-15, 142);
    collectionflowlayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    collectionflowlayout.sectionHeadersPinToVisibleBounds = true;
    self.collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) collectionViewLayout:collectionflowlayout];
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    self.collectionview.backgroundColor=[WKColor colorWithHexString:LIGHT_COLOR];
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellid"];
   
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKTeacherHeaderCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
  [self.view addSubview:self.collectionview];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索学科/课程";
    self.Videolist = [NSMutableArray array];
    [self initcollection];
    [self initdata];
   self.dic = @{@"schoolId":self.schoolId,@"typeId":self.typeId,@"gradeId":self.gradeId,@"courseId":self.courseId,@"sectionId":self.sectionId, @"page":@1};
    
    // Do any additional setup after loading the view.
}
-(void)initdata{
    
    __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKAcedemyHandler executeGetAcademyVideoWithParameter:self.dic success:^(id object) {
            for(WKHomeNew *viedo in object){
                [weakself.Videolist addObject:viedo];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.collectionview reloadData];
            });
        } failed:^(id object) {
            
        }];

    });
    }
-(void)viewWillAppear:(BOOL)animated{
    self.navigationItem.hidesBackButton = YES;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.Videolist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeCollectionViewCell *cell = (WKHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
    WKHomeNew *viedos= self.Videolist[indexPath.row];
    if (viedos.videoImage.length==0) {
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:SERVER_IP@"%@",viedos.videoImgUrl]]placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        
    }
    else{
        //NSLog(@"me=%@",[NSString stringWithFormat:SERVER_IP@"%@",new.videoImage]);
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:SERVER_IP@"%@",viedos.videoImage]]placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }
    cell.Title.text = viedos.title;
    cell.TeacherName.text = viedos.teacherName;
    cell.gradeLabel.text = viedos.gradeName;

    return cell;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WKTeacherHeaderCollectionReusableView *header=(WKTeacherHeaderCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [header.bottomButton setHidden:YES];
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 10, 20);
    [button setBackgroundImage:[UIImage imageNamed:@"boy"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goResultViewController:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    return header;
}
#pragma mark - collectiondelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}
-(void)goResultViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
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
