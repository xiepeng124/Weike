//
//  WKSearchResultViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearchResultViewController.h"
#import "WKSearchResultHeaderView.h"
#import "WKTeachScreenCollectionViewCell.h"
#import "WKSearchHandler.h"
#import "WKHomeCollectionViewCell.h"
@interface WKSearchResultViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource>
@property (nonatomic ,strong) WKSearchResultHeaderView *headerview;
@property (nonatomic,strong) UICollectionView *classfityCollectionView;
@property (nonatomic,strong) UITableView *gradeTableView;
@property (strong,nonatomic)UIView *oneBack;
@property (strong,nonatomic)UIView *twoBack;
@property (strong,nonatomic)NSArray *arrClassfity;
@property (strong,nonatomic)NSArray *arrGrade;
@property (assign,nonatomic)NSInteger index;
@property (assign,nonatomic)NSInteger twoIndex;
@property (strong,nonatomic)NSMutableArray *arrlist;
@end

@implementation WKSearchResultViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSArray*)arrClassfity{
    if (!_arrClassfity) {
        _arrClassfity = [NSArray arrayWithObjects:@"综合排序",@"人气排序",@"最新排序", nil];
    }
    return _arrClassfity;
}
-(NSArray*)arrGrade{
    if (!_arrGrade) {
        _arrGrade = [NSArray arrayWithObjects:@"全部", @"初一级",@"初二级",@"初三级",@"高一级",@"高二级",@"高三级",nil];
    }
    return _arrGrade;
}
-(void)initData{
    NSDictionary *dic;
    if (self.index==0) {
        dic = @{@"page":@1,@"schoolId":SCOOLID,@"searchMsg":self.searchtext,@"newOrHot":[NSNumber numberWithInteger:self.twoIndex]};
    }
    else{
        NSString *string = [self.arrGrade[self.index] substringToIndex:2];
   dic = @{@"page":@1,@"schoolId":SCOOLID,@"searchMsg":self.searchtext,@"gradeName":string,@"newOrHot":[NSNumber numberWithInteger:self.twoIndex]};
    }
    __weak typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKSearchHandler executeGetSearchVideoWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKHomeNew *model in object) {
                    [weakself.arrlist addObject:model];
                }
                [weakself.resultCollectionView reloadData];
            });
                  } failed:^(id object) {
            
        }];
         });
}
-(void)initStyle{
    self.headerview = [[WKSearchResultHeaderView alloc ]init];
   self.headerview = [[[NSBundle mainBundle]loadNibNamed:@"searchResultHeader" owner:nil options:nil]lastObject];
    self.headerview.frame = CGRectMake(0, 44, SCREEN_WIDTH, 40);
    [self.headerview.classifyButton addTarget:self action:@selector(selectedClassfityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerview.Updpwnclassify addTarget:self action:@selector(selectedClassfityAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerview.gradebutton addTarget:self action:@selector(selectedGradeAction) forControlEvents:UIControlEventTouchUpInside];
    [self.headerview.Updowngrade addTarget:self action:@selector(selectedGradeAction) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.headerview];
}
-(void)initTableView{
    self.gradeTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 45, SCREEN_WIDTH, 165) style:UITableViewStylePlain];
    self.gradeTableView.delegate = self;
    self.gradeTableView.dataSource = self;
    self.gradeTableView.scrollEnabled = NO;
    self.gradeTableView.hidden = YES;
    self.gradeTableView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    [self.view addSubview:self.gradeTableView];
    self.oneBack = [[UIView alloc]initWithFrame:CGRectMake(0, 210, SCREEN_WIDTH, SCREEN_HEIGHT-210)];
    self.oneBack.backgroundColor = [UIColor blackColor];
    self.oneBack.alpha = 0.6;
    self.oneBack.hidden = YES;
    [self.view addSubview:self.oneBack];
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumLineSpacing = 4;
    layout.minimumInteritemSpacing = 2;
    layout.itemSize = CGSizeMake((SCREEN_WIDTH-35)/4, 33);
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    self.classfityCollectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, 93) collectionViewLayout:layout];
    [self.classfityCollectionView registerNib:[UINib nibWithNibName:@"WKTeachScreenCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"classCell"];
    self.classfityCollectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    self.classfityCollectionView.delegate= self;
    self.classfityCollectionView.dataSource = self;
    self.classfityCollectionView.hidden = YES;
    [self.view addSubview:self.classfityCollectionView];
    self.twoBack = [[UIView alloc]initWithFrame:CGRectMake(0, 178, SCREEN_WIDTH, SCREEN_HEIGHT-178)];
    self.twoBack.backgroundColor = [UIColor blackColor];
    self.twoBack.alpha = 0.6;
    self.twoBack.hidden = YES;
    [self.view addSubview:self.twoBack];

    
}
-(void)initCollectView{
    UICollectionViewFlowLayout *collectionflowlayout=[[UICollectionViewFlowLayout alloc]init];
    collectionflowlayout.minimumLineSpacing=10;
    collectionflowlayout.minimumInteritemSpacing=5;
    collectionflowlayout.itemSize=CGSizeMake(SCREEN_WIDTH/2-15, 142);
    collectionflowlayout.sectionInset=UIEdgeInsetsMake(10, 10, 10, 10);
    self.resultCollectionView=[[UICollectionView alloc]initWithFrame:CGRectMake(0, 85, SCREEN_WIDTH, SCREEN_HEIGHT-85) collectionViewLayout:collectionflowlayout];
    self.resultCollectionView.delegate=self;
    self.resultCollectionView.dataSource=self;
    self.resultCollectionView.backgroundColor=[WKColor colorWithHexString:LIGHT_COLOR];
    [self.resultCollectionView registerNib:[UINib nibWithNibName:@"WKHomeCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Cellid"];
    [self.view addSubview:self.resultCollectionView];

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initCollectView];
       [self initTableView];
     [self initStyle];
    self.index = 0;
    self.twoIndex = 0;
    self.view.backgroundColor = [ WKColor colorWithHexString:LIGHT_COLOR];
 
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.arrClassfity.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellid = @"mycell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    cell.textLabel.textColor = [WKColor colorWithHexString:@"333333"];
    cell.textLabel.text =self.arrClassfity[indexPath.row];
    cell.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    if (collectionView == self.classfityCollectionView) {
        return self.arrGrade.count;

    }else{
        if (self.arrlist.count) {
            return self.arrlist.count;
        }
    }
    return 0;
  }


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.classfityCollectionView) {
        WKTeachScreenCollectionViewCell *cell = (WKTeachScreenCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"classCell" forIndexPath:indexPath];
        cell.TeachLabel.text =self.arrGrade[indexPath.row];
        return cell;

    }
    else{
        WKHomeCollectionViewCell *cell = (WKHomeCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Cellid" forIndexPath:indexPath];
        if (self.arrlist.count) {
            WKHomeNew *model= self.arrlist [indexPath.row];
            cell.Title.text = model.title;
            cell.TeacherName.text = model.teacherName;
            cell.gradeLabel.text = model.gradeName;
            [cell.CeImage sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
            return cell;
            
        }
    }
    return nil;
   }
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.classfityCollectionView) {
        WKTeachScreenCollectionViewCell *cell = (WKTeachScreenCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        self.index= indexPath.row;
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"4481c2"];
        cell.selectedImage.image =[UIImage imageNamed:@"pitch-up"];

    }
   }
-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (collectionView == self.classfityCollectionView) {
        WKTeachScreenCollectionViewCell *cell = (WKTeachScreenCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
        cell.TeachLabel.backgroundColor = [WKColor colorWithHexString:@"d7d7d7"];
        cell.TeachLabel.textColor = [WKColor colorWithHexString:@"666666"];
        cell.selectedImage.image = nil;

    }
   
}
-(void)selectedClassfityAction{
    self.headerview.classifyButton.selected = !self.headerview.classifyButton.selected;
    self.headerview.Updpwnclassify.selected = ! self.headerview.Updpwnclassify.selected;
    if (self.headerview.Updpwnclassify.selected) {
        self.gradeTableView.hidden = NO;
        self.oneBack.hidden = NO;
    }
    else{
        self.gradeTableView.hidden = YES;
        self.oneBack.hidden = YES;

    }
    self.classfityCollectionView.hidden = YES;
    self.twoBack.hidden = YES;
    self.headerview.gradebutton.selected = NO;
    self.headerview.Updowngrade.selected = NO;
}
-(void)selectedGradeAction{
    self.headerview.gradebutton.selected = !self.headerview.gradebutton.selected;
    self.headerview.Updowngrade.selected = ! self.headerview.Updowngrade.selected;
    if (self.headerview.Updowngrade.selected) {
        self.classfityCollectionView.hidden = NO;
        self.twoBack.hidden = NO;
    }
    else{
        self.classfityCollectionView.hidden = YES;
        self.twoBack.hidden = YES;
        
    }
    self.gradeTableView.hidden = YES;
    self.oneBack.hidden = YES;
    self.headerview.classifyButton.selected = NO;
    self.headerview.Updpwnclassify.selected = NO;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    //NSLog(@"class = %@",NSStringFromClass([touch.view class]));
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    if (!self.classfityCollectionView.hidden) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
 
    if ([touch.view isKindOfClass:[UIButton class]]) {
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
