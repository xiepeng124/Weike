//
//  WKHomeViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHomeViewController.h"
#import "WKHomeCollectionViewCell.h"
#import "WKHeaderCollectionReusableView.h"
#import "WKHomeAdHandler.h"
#import "WKHomeFooterCollectionReusableView.h"
#import "WKplayViewController.h"
#import "WKHomeOutLinkViewController.h"

@interface WKHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property(strong,nonatomic)UICollectionView *collectionview;
@property(strong,nonatomic)NSMutableArray *advertiselist;
@property(strong,nonatomic)NSMutableArray *NewVideo;
@property(strong,nonatomic)NSMutableArray *HotVideo;
@end

@implementation WKHomeViewController
#pragma mark - init
-(void)initCollectionView{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
    collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-15, 142);
    //collectionflowlayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    self.collectionview=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-113) collectionViewLayout:collectionflowlayout];
    self.collectionview.delegate=self;
    self.collectionview.dataSource=self;
    self.collectionview.backgroundColor=[WKColor colorWithHexString:WHITE_COLOR];
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellid"];
    [self.collectionview registerClass:[WKHeaderCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView"];
    [self.collectionview registerNib:[UINib nibWithNibName:@"WKHomeFooterCollectionReusableView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"HeaderView2"];
    [self.collectionview registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView"];
    self.collectionview.mj_header=[MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(freshaction)];
    self.collectionview.mj_header.automaticallyChangeAlpha=YES;
    //self.collectionview.mj_header.backgroundColor = [UIColor lightGrayColor];
    [self.collectionview.mj_header beginRefreshing];
    self.collectionview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.collectionview.mj_footer.automaticallyChangeAlpha=YES;
   
    [self.view addSubview:self.collectionview];
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"@@@@@");
    if (indexPath.section ==1) {
       WKHomeNew *new= self.NewVideo[indexPath.row];
        NSLog(@"new.link = %@",new.videoLink);
    if(new.videoLink.length ){
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
            player.hidesBottomBarWhenPushed = YES;
        //跳转事件
        [self.navigationController pushViewController:player animated:YES];
        }

    }
    if (indexPath.section ==2) {
        WKHomeNew *new= self.HotVideo[indexPath.row];
        NSLog(@"new.link = %@",new.videoLink);
               if(new.videoLink.length){
            if (![new.videoLink  isEqual: @"1"]) {
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
        [self.navigationController pushViewController:player animated:YES];
        }
    }
}
#pragma mark - collectiondatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (section==1) {
        return self.NewVideo.count;

    }
    if (section==2) {
        return self.HotVideo.count;
    }
    return 0;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKHomeCollectionViewCell *cell = (WKHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
    
    if (indexPath.section==0) {
        return nil;
    }
    if (indexPath.section==1) {
        WKHomeNew *new=self.NewVideo[indexPath.row];
        if (new.videoLink.length) {
            cell.outLinkButton.hidden = NO;
        }
        else{
            cell.outLinkButton.hidden = YES;

        }
        if (new.videoImage.length==0) {
            [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:new.videoImgUrl]placeholderImage:[UIImage imageNamed:@"girl"] options:SDWebImageRetryFailed|SDWebImageLowPriority];

        }
        else{
        //NSLog(@"me=%@",[NSString stringWithFormat:SERVER_IP@"%@",new.videoImage]);
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:new.videoImage]placeholderImage:[UIImage imageNamed:@"girl"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        }
        cell.Title.text = new.title;
        cell.TeacherName.text = new.teacherName;
        cell.gradeLabel.text = new.gradeName;
        //cell.backgroundColor=[UIColor whiteColor];
        return cell;

    }
    WKHomeNew *hot = self.HotVideo[indexPath.row];
    if (hot.videoLink.length) {
        cell.outLinkButton.hidden = NO;
    }
    else{
        cell.outLinkButton.hidden = YES;
        
    }
    if (!hot.videoImage.length) {
         [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:hot.videoImgUrl] placeholderImage:[UIImage imageNamed:@"girl"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    }
    [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:hot.videoImage] placeholderImage:[UIImage imageNamed:@"girl"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    cell.Title.text = hot.title;
    cell.TeacherName.text = hot.teacherName;
    cell.gradeLabel.text= hot.gradeName;
    //cell.backgroundColor=[UIColor whiteColor];
    return cell;

    
}
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 3;
}

-(UICollectionReusableView*)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    if (kind==UICollectionElementKindSectionHeader) {

    if (indexPath.section==0) {
                    WKHeaderCollectionReusableView *header = (WKHeaderCollectionReusableView*)[collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView" forIndexPath:indexPath];
            
            [header imageURLStringsGroup:self.advertiselist];
            return header;

        
        
        
    }
    if (indexPath.section==1) {
        WKHomeFooterCollectionReusableView *header =(WKHomeFooterCollectionReusableView*) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
        header.Footbutton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:16];
        header.Footbutton.titleLabel.textColor = [WKColor colorWithHexString:@"72c456"];
        [header.Footbutton setTitle:@"最新微课" forState:UIControlStateNormal];
        header.leftImage.image = [UIImage imageNamed:@"-left"];
        header.rightImage.image = [UIImage imageNamed:@"home_new"];
        return header;
    }
    if (indexPath.section==2) {
        WKHomeFooterCollectionReusableView *header =(WKHomeFooterCollectionReusableView*) [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"HeaderView2" forIndexPath:indexPath];
        header.Footbutton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:16];
        header.Footbutton.titleLabel.textColor = [WKColor colorWithHexString:@"d94e4e"];
        header.leftImage.image = [UIImage imageNamed:@"home_hot-left"];
        header.rightImage.image = [UIImage imageNamed:@"home_hot"];
        [header.Footbutton setTitle:@"热门微课" forState:UIControlStateNormal];
        return header;
    }
    else{
        return nil;
    }
}
    UICollectionReusableView *footer = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"FootView" forIndexPath:indexPath];
    footer.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    
    return footer;
}
#pragma mark - collectiondelegate
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    if (section==0) {
         return CGSizeMake(SCREEN_WIDTH, SCREEN_WIDTH*0.4);
    }
    if (section==1||section==2) {
        return CGSizeMake(SCREEN_WIDTH, 40);
    }
    return CGSizeMake(0, 0);
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    return  CGSizeMake(SCREEN_WIDTH, 10);
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    if (section==0) {
        return UIEdgeInsetsMake(0, 0, 0, 0);
    }
    return UIEdgeInsetsMake(5, 10, 5, 10);
}
- (void)viewDidLoad {
    [super viewDidLoad];
//    [self.view setBackgroundColor:[UIColor clearColor]];
    self.advertiselist=[[NSMutableArray alloc]init];
    self.NewVideo=[[NSMutableArray alloc]init];
    self.HotVideo=[NSMutableArray array];
    [self initCollectionView];
    [self loadadvertisement];
    [self loadNewVideo];
    [self loadHotVideo];

}
#pragma mark - 获取数据
-(void)loadadvertisement{
    __weak typeof(self) weakself =self;
    [self.advertiselist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKHomeAdHandler executeGetHomeAdWithSuccess:^(id object) {
            //NSLog(@"object= %@",object);
            for (WKHomeAD *ad in object) {
             NSString *string=[ad valueForKey:@"bannerUrl"];
              //NSString *bannerURL=[NSString stringWithFormat:SERVER_IP@"%@",string];
             [weakself.advertiselist addObject:string];
                
            }
           // NSLog(@"object1 =%@",object);
                        dispatch_async(dispatch_get_main_queue(), ^{
                    if (weakself.advertiselist.count) {
                    [weakself.collectionview reloadData];
                    
                }
            });

        } failed:^(id object) {
                   }];
    });
}
-(void)loadNewVideo{
    [self.NewVideo removeAllObjects];
     __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKHomeAdHandler executeGetHomeNewVideoWithSuccess:^(id object) {
            for (WKHomeNew *ad in object) {
                [weakself.NewVideo addObject:ad];
            }
          //  NSLog(@"object2 =%@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"new=%lu",self.NewVideo.count);
                if (weakself.NewVideo.count) {
                    [weakself.collectionview reloadData];
                    
                }
            });

        } failed:^(id object) {
            
        }];
        
    });
    
}
-(void)loadHotVideo{
    [self.HotVideo removeAllObjects];
     __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKHomeAdHandler executeGetHomeHotVideoWithSuccess:^(id object) {
            for (WKHomeNew *ad in object) {
                [weakself.HotVideo addObject:ad];
            }
            //NSLog(@"object2 =%@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                //NSLog(@"new=%lu",self.NewVideo.count);
                if (weakself.HotVideo.count) {
                    [weakself.collectionview reloadData];
                    
                }
            });
            
        } failed:^(id object) {
            
        }];
        
    });

}
#pragma mark - Action
-(void)freshaction{
    [self loadmore];
    [self loadNewVideo];
    [self loadHotVideo];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionview.mj_header endRefreshing];
    });
}
-(void)loadmore{
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.collectionview.mj_footer endRefreshing];
    });

    
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
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
