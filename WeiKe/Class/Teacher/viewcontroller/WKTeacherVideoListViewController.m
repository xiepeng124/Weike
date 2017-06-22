//
//  WKTeacherVideoListViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherVideoListViewController.h"
#import "WKHomeCollectionViewCell.h"
#import "WKTeacherHandler.h"
#import "WKHomeOutLinkViewController.h"
#import "WKplayViewController.h"
#import "WKBackstage.h"
@interface WKTeacherVideoListViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)UICollectionView *collectionview;
@property (strong,nonatomic) NSMutableArray *arrlist;
@property (assign,nonatomic) NSInteger page;
@end

@implementation WKTeacherVideoListViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(void)initTableView{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
    collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-15, 142);
    collectionflowlayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionview=[[UICollectionView alloc]initWithFrame:self.view.frame collectionViewLayout:collectionflowlayout];
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    self.collectionview.backgroundColor=[WKColor colorWithHexString:LIGHT_COLOR];
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellid"];
    [self.view addSubview:self.collectionview];
    self.collectionview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.collectionview.mj_footer.automaticallyChangeAlpha=YES;
}
-(void)initData{

        NSDictionary *dic = @{@"teacherId":[NSNumber numberWithInteger:self.myId],@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
        [self.arrlist removeAllObjects];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKTeacherHandler executeGetTeacherOutListWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKTeacherVideoList *model in object) {
                        [weakself.arrlist addObject:model];
                        weakself.navigationItem.title = model.teacherName;
                        
                    }
                    [weakself.collectionview reloadData];
                    
                    
                    
                });
            } failed:^(id object) {
                
            }];
        });


    
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
//    [self.navigationController setNavigationBarHidden:YES animated:NO];
//    [self.navigationController setNavigationBarHidden:NO animated:NO];
    //self.navigationItem.hidesBackButton = YES;
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initTableView];
    [self initData];
    // Do any additional setup after loading the view.
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.arrlist.count) {
        return self.arrlist.count;
        
    }
    return 0;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrlist.count) {
        WKHomeCollectionViewCell *cell = (WKHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
        WKTeacherVideoList *model = self.arrlist[indexPath.row];
        if (model.videoLink.length) {
            cell.outLinkButton.hidden = NO;
        }
        else{
            cell.outLinkButton.hidden = YES;
            
        }
        
        cell.Title.text = model.title;
        cell.TeacherName.text = model.teacherName;
        cell.gradeLabel.text = model.gradeName;
        if (model.videoImage.length) {
              [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
        }
        else{
             [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
        }
      
        return cell;
        
    }
    return nil;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKTeacherVideoList *new = self.arrlist[indexPath.row];
    if (new.videoLink.length) {
        if (![new.videoLink  isEqual: @"1"]) {
            NSLog(@"111");
            
            [[UIApplication sharedApplication]openURL:[NSURL URLWithString:new.videoLink]];
        }
        else{
            WKHomeOutLinkViewController *outlink = [[WKHomeOutLinkViewController alloc]init];
            outlink.myId = new.id;
            outlink.hidesBottomBarWhenPushed = YES;
            
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
        player.myNumber=2;
        [self presentViewController:player animated:YES completion:nil];
       // [self.navigationController pushViewController:player animated:YES];
    }
    
    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    return NO;
}
-(void)loadmore{
    self.page +=1;
 
        NSDictionary *dic = @{@"teacherId":[NSNumber numberWithInteger:self.myId],@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID};
        __weak typeof(self) weakself = self;
       // [self.arrlist removeAllObjects];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKTeacherHandler executeGetTeacherOutListWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKTeacherVideoList *model in object) {
                        [weakself.arrlist addObject:model];
                        //weakself.navigationItem.title = model.teacherName;
                        
                    }
                    [weakself.collectionview reloadData];
                    [weakself.collectionview.mj_footer endRefreshing];
                    
                    
                });
            } failed:^(id object) {
                
            }];
        });
        
 
    
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
