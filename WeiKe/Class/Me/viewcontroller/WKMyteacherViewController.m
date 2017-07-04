//
//  WKMyteacherViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMyteacherViewController.h"
#import "WKFlowLayout.h"
#import "WKTeacherCollectionViewCell.h"
#import "WKMeHandler.h"
#import "WKTeacherVideoListViewController.h"

@interface WKMyteacherViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CustomeCollectionViewLayoutDelegate,UIScrollViewDelegate>
@property (nonatomic) NSInteger cellColumn;
@property (nonatomic) CGFloat cellMargin;
@property (nonatomic) CGFloat cellMinHeight;
@property (nonatomic) CGFloat cellMaxHeight;
@property (nonatomic,strong) NSMutableArray *arrlist;
@property (nonatomic,strong) UICollectionView *collect;
@end
#define CELL_COLUMN 3
#define CELL_MARGIN 2
#define CELL_MIN_HEIGHT 120
#define CELL_MAX_HEIGHT 180
#define SECTIONS_COUNT 1
#define CELL_COUNT 1000
#define SCROLL_OFFSET_Y 300
@implementation WKMyteacherViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    WKFlowLayout * layout = [[WKFlowLayout alloc]init];
    layout.layoutDelegate = self;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    layout.sectionInset =UIEdgeInsetsMake(5, 5, 5, 5);
  _collect  = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) collectionViewLayout:layout];
    _collect.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    _collect.delegate=self;
    _collect.dataSource=self;
    
    [_collect registerNib:[UINib nibWithNibName:@"WKTeacherCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellid"];
    [self.view addSubview:_collect];
    [self initData];
//    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:
//                             @"返回" style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = nil;
    // Do any additional setup after loading the view.
}
- (void)initData {
    _cellColumn = CELL_COLUMN;
    _cellMargin = CELL_MARGIN;
    _cellMinHeight = CELL_MIN_HEIGHT;
    _cellMaxHeight = CELL_MAX_HEIGHT;
    [self.arrlist removeAllObjects];
    __weak typeof(self) weakSelf= self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetmyTeacherListWithSuccess:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKTeacherData *model in object) {
                    [weakSelf.arrlist addObject:model];
                }
                [weakSelf.collect reloadData];
            });
            NSLog(@"****=%@",object);
        } failed:^(id object) {
            NSLog(@"????=%@",object);
        }];

    });
  }

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (self.arrlist.count) {
        return self.arrlist.count;
    }
    return 0;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    WKTeacherCollectionViewCell * cell  =(WKTeacherCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellid" forIndexPath:indexPath];
    //cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.subjectImage.image = [UIImage imageNamed:@"classroom_subject"];
    if (self.arrlist.count) {
        WKTeacherData *model = self.arrlist[indexPath.row];
        [cell.teacherImage sd_setImageWithURL:[NSURL URLWithString:model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
        cell.teachername.text = model.teacherName;
        cell.grade.text = model.gradeName;
        return cell;
    }
    return cell;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKTeacherData *model = self.arrlist[indexPath.row];
    WKTeacherVideoListViewController *list = [[WKTeacherVideoListViewController alloc]init];
    list.myId = model.id;
    list.isAll = NO;
    [self.navigationController pushViewController:list animated:YES];
}
#pragma mark - <CustomeCollectionViewLayoutDelegate>
- (NSInteger) numberOfColumnWithCollectionView:(UICollectionView *)collectionView
                          collectionViewLayout:( WKFlowLayout *)collectionViewLayout{
    return _cellColumn;
}

- (CGFloat)marginOfCellWithCollectionView:(UICollectionView *)collectionView
                     collectionViewLayout:(WKFlowLayout *)collectionViewLayout{
    return _cellMargin;
}

- (CGFloat)minHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(WKFlowLayout *)collectionViewLayout{
    return _cellMinHeight;
}

- (CGFloat)maxHeightOfCellWithCollectionView:(UICollectionView *)collectionView
                        collectionViewLayout:(WKFlowLayout *)collectionViewLayout{
    return _cellMaxHeight;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    CGFloat offsetY = scrollView.contentOffset.y;
    
    if (offsetY < 0) {
        offsetY = 0;
    }
    
    self.navigationController.navigationBar.alpha = (SCROLL_OFFSET_Y - offsetY) / SCROLL_OFFSET_Y;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
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
