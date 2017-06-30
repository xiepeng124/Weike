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
#import "WKplayViewController.h"
#import "WKHomeOutLinkViewController.h"
@interface WKAcadeResultsViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UITextFieldDelegate>
@property (strong,nonatomic) UICollectionView *collectionview ;
@property (strong,nonatomic)NSMutableArray *Videolist;
@property (strong,nonatomic)NSDictionary *dic;
@property (assign,nonatomic)NSInteger page;
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
    self.collectionview.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.collectionview.mj_footer.automaticallyChangeAlpha= YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索学科/课程";
    self.Videolist = [NSMutableArray array];
    [self initcollection];
    [self initdata];
    self.search.delegate = self;
    
    // Do any additional setup after loading the view.
}
-(void)initdata{
    self.page=1;
    self.dic = @{@"schoolId":SCOOLID,@"typeId":self.typeId,@"gradeId":self.gradeId,@"courseId":self.courseId,@"sectionId":self.sectionId, @"page":@1,@"searchMsg":self.search.text};
    [self.Videolist removeAllObjects];
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
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    [self.navigationController setNavigationBarHidden:NO animated:NO];
    self.navigationItem.hidesBackButton = YES;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.Videolist.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeCollectionViewCell *cell = (WKHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
    WKHomeNew *viedos= self.Videolist[indexPath.row];
    if (viedos.videoLink.length) {
        cell.outLinkButton.hidden = NO;
    }
    else{
        cell.outLinkButton.hidden = YES;
    }
    if (viedos.videoImage.length==0) {
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:viedos.videoImgUrl]placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        
    }
    else{
        //NSLog(@"me=%@",[NSString stringWithFormat:SERVER_IP@"%@",new.videoImage]);
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:viedos.videoImage]placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }
    cell.Title.text = viedos.title;
    cell.TeacherName.text = viedos.teacherName;
    cell.gradeLabel.text = viedos.gradeName;

    return cell;
}
-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    WKTeacherHeaderCollectionReusableView *header=(WKTeacherHeaderCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
    [header.bottomButton setHidden:YES];
    if (self.gradeName.length==0) {
        header.course.text = @"全部";
       
    }
    else if([self.gradeName isEqualToString:@"初中部"]||[self.gradeName isEqualToString:@"高中部"]){
        header.course.text = self.gradeName;
    
        
    }
    else{
        if (!self.courseName.length ) {
            header.course.text = [NSString stringWithFormat:@"%@·全部", [self.gradeName substringToIndex:2] ];
                }
       else if (self.courseName.length>2) {
            header.course.text = [NSString stringWithFormat:@"%@·%@", [self.gradeName substringToIndex:2] , [self.courseName substringToIndex:2]];
        }

        else{
        header.course.text = [NSString stringWithFormat:@"%@·%@", [self.gradeName substringToIndex:2] ,self.courseName];
        }
    }
 
  
    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(10, 10, 50, 20);
    button.imageEdgeInsets = UIEdgeInsetsMake(0, -20, 0, 20);
//    if ([USERTYPE intValue]== 2) {
//        header.selectedbutton.hidden = NO;
//        header.myteacher.hidden = NO;
//    }
//    else{
        header.selectedbutton.hidden = YES;
        header.myteacher.hidden = YES;

//    }
    [button setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goResultViewController:) forControlEvents:UIControlEventTouchUpInside];
    [header addSubview:button];
    return header;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeNew *new = self.Videolist[indexPath.row];
    if (new.videoLink.length) {
        if (![new.videoLink  isEqual: @"1"]) {
            NSLog(@"111");
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:new.videoLink]];
        }
        else{
            WKHomeOutLinkViewController *outlink = [[WKHomeOutLinkViewController alloc]init];
            outlink.myId = new.id;
            //outlink.hidesBottomBarWhenPushed = YES;
            [self.navigationController pushViewController:outlink animated:YES];
        }

    }
    else{
        UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        
        //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
        
        WKplayViewController *player = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PlayerView"];
        player.myId = new.id;
        //跳转事件
       player.hidesBottomBarWhenPushed = YES;
        player.myNumber = 2;
        [self presentViewController:player animated:YES completion:nil];
       // [self.navigationController pushViewController:player animated:YES];
    }

   
}
#pragma mark - collectiondelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(SCREEN_WIDTH, 40);
}
-(void)goResultViewController:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)loadmore{
    self.page+=1;
    self.dic = @{@"schoolId":SCOOLID,@"typeId":self.typeId,@"gradeId":self.gradeId,@"courseId":self.courseId,@"sectionId":self.sectionId, @"page":[NSNumber numberWithInteger:self.page]};
   
    __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKAcedemyHandler executeGetAcademyVideoWithParameter:self.dic success:^(id object) {
            for(WKHomeNew *viedo in object){
                [weakself.Videolist addObject:viedo];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.collectionview reloadData];
                [weakself.collectionview.mj_footer endRefreshing];
            });
        } failed:^(id object) {
            
        }];
        
    });

}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self initdata];
    return YES;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
    if (touch.view.frame.size.height<45) {
        return YES;
    }
    if ([touch.view isKindOfClass:[UIButton class]]) {
        return NO;
    }
    return NO;
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
