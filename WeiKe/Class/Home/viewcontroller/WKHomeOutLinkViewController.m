//
//  WKHomeOutLinkViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKHomeOutLinkViewController.h"
#import "WKHomeCollectionViewCell.h"
@interface WKHomeOutLinkViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (strong,nonatomic)UICollectionView *collectionview;
@property (strong,nonatomic) NSMutableArray *arrlist;
@end

@implementation WKHomeOutLinkViewController
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
}
-(void)initData{
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:self.myId]};
    __weak typeof(self) weakself = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKPlayerHandler executeGetOutVideoWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKPlayOutVideo *model in object) {
                    [weakself.arrlist addObject:model];
                    weakself.navigationItem.title = model.bigTitle;
                
                }
                [weakself.collectionview reloadData];

                
                
            });
        } failed:^(id object) {
            
        }];
    });

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[WKColor colorWithHexString:LIGHT_COLOR]];
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
        WKPlayOutVideo *model = self.arrlist[indexPath.row];
        if (model.videoLink.length) {
            cell.outLinkButton.hidden = NO;
        }
        else{
            cell.outLinkButton.hidden = YES;
            
        }

        cell.Title.text = model.title;
        cell.TeacherName.text = model.teacherName;
        cell.gradeLabel.text = model.gradeName;
        [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
        return cell;

    }
    return nil;
    }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKPlayOutVideo *model =  self.arrlist[indexPath.row];
    NSLog(@"...videoLink = %@",model.videoLink);
    [[UIApplication sharedApplication]openURL:[NSURL URLWithString:model.videoLink]];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{
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
