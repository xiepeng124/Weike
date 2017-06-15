//
//  WKViewingrecordViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/15.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKViewingrecordViewController.h"
#import "WKViewingTableViewCell.h"
#import "WKMeHandler.h"
#import "WKViewRecordModel.h"
#import "WKplayViewController.h"
@interface WKViewingrecordViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UITableView *mytableView;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,strong)NSMutableArray*arrToday;
@property (nonatomic,strong)NSMutableArray*arrYesterday;
@property (nonatomic,strong)NSMutableArray*arrBefore;
@end

@implementation WKViewingrecordViewController
-(NSMutableArray*)arrToday{
    if (!_arrToday) {
        _arrToday = [NSMutableArray array];
    }
    return _arrToday;
}
-(NSMutableArray*)arrYesterday{
    if (!_arrYesterday) {
        _arrYesterday = [NSMutableArray array];
    }
    return _arrYesterday;
}
-(NSMutableArray*)arrBefore{
    if (!_arrBefore) {
        _arrBefore = [NSMutableArray array];
    }
    return _arrBefore;
}
-(void)initTableView{
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.mytableView registerNib:[UINib nibWithNibName:@"WKViewingTableViewCell" bundle:nil] forCellReuseIdentifier:@"viewRecord"];
   // [self.mytableView reg]
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.mytableView.mj_footer.automaticallyChangeAlpha=YES;
    [self.view addSubview:self.mytableView];
}
-(void)initData{
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;
    [self.arrToday removeAllObjects];
    [self.arrYesterday removeAllObjects];
    [self.arrBefore removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetWatchVideorecordWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.arrToday = [WKViewRecordModel mj_objectArrayWithKeyValuesArray:object[@"todayList"]];
                weakSelf.arrYesterday = [WKViewRecordModel mj_objectArrayWithKeyValuesArray:object[@"yesterDayList"]];
                  weakSelf.arrBefore = [WKViewRecordModel mj_objectArrayWithKeyValuesArray:object[@"beforeList"]];
                [weakSelf.mytableView reloadData];
            });
        } failed:^(id object) {
            
        }];
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initTableView];
    [self initData];
    // Do any additional setup after loading the view.
}
-(void)viewDidDisappear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section ==0) {
        if (self.arrToday.count) {
            return self.arrToday.count;
        }
        return 0;
        
    }
    if (section == 1) {
        if (self.arrYesterday.count) {
            return  self.arrYesterday.count;
        }
        return 0;
    }
    if (section == 2) {
        if (self.arrBefore.count) {
            return self.arrBefore.count;
        }

    }
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKViewingTableViewCell *cell = (WKViewingTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"viewRecord" forIndexPath:indexPath];
    if (indexPath.section==0) {
        if (self.arrToday.count) {
            WKViewRecordModel *model = self.arrToday[indexPath.row];
            [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
            cell.titleLab.text = model.title;
            cell.teacherName.text = model.teacherName;
            cell.subject.text = model.gradeName;
            return cell;
        }
        return nil;
    }
    if (indexPath.section ==1) {
        if (self.arrYesterday.count) {
            WKViewRecordModel *model = self.arrYesterday[indexPath.row];
            [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
            cell.titleLab.text = model.title;
            cell.teacherName.text = model.teacherName;
            cell.subject.text = model.gradeName;
            return cell;
            
        }
        return nil;
    }
    if (self.arrBefore.count) {
        WKViewRecordModel *model = self.arrBefore[indexPath.row];
        [cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
        cell.titleLab.text = model.title;
        cell.teacherName.text = model.teacherName;
        cell.subject.text = model.gradeName;
        return cell;
        
    }
    return nil;
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (section==2) {
        return 0;
    }
    return 10;
}
-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionView = [[UIView alloc]init];
    sectionView.layer.borderWidth = 0.5;
    sectionView.layer.borderColor = [WKColor colorWithHexString:BACK_COLOR].CGColor;
    sectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(10,10, 6, 15)];
    image.image = [UIImage imageNamed:@"GK_dian"];
    image.contentMode =  UIViewContentModeScaleAspectFit;
//    UILabel *pointLabel = [[UILabel alloc]initWithFrame:CGRectMake(10,10, 6, 15)];
//    pointLabel.textColor =[WKColor colorWithHexString:@"4481c2"];
//    pointLabel.text = @"·";
    UILabel *TimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, 9, 32, 17)];
    TimeLabel.textColor =[WKColor colorWithHexString:DARK_COLOR];
    TimeLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    if (section ==0) {
        TimeLabel.text =@"今天";
    }
    else if (section==1){
        TimeLabel.text =@"昨天";
    }
    else{
        TimeLabel.text = @"更早";
    }
    [sectionView addSubview:image];
    [sectionView addSubview:TimeLabel];
    return sectionView;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UIStoryboard *mainStoryBoard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    //将第二个控制器实例化，"SecondViewController"为我们设置的控制器的ID
    WKplayViewController *player = [mainStoryBoard instantiateViewControllerWithIdentifier:@"PlayerView"];
    if (indexPath.section ==0) {
        WKViewRecordModel *model = self.arrToday[indexPath.row];
        player.myId = model.id;
    }
    if (indexPath.section ==1) {
        WKViewRecordModel *model = self.arrYesterday[indexPath.row];
        player.myId = model.id;
    }
    if (indexPath.section ==2) {
        WKViewRecordModel *model = self.arrBefore[indexPath.row];
        player.myId = model.id;
    }
    [self.navigationController pushViewController:player animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //NSLog(@"111");
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}

-(void)loadmore{
    self.page += 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;
       dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetWatchVideorecordWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                
                NSArray *arr = [WKViewRecordModel mj_objectArrayWithKeyValuesArray:object[@"beforeList"]];
                if (arr.count) {
                    for (WKViewRecordModel *model in arr) {
                        [weakSelf.arrBefore addObject:model];
                    }
                    NSIndexSet *inset = [NSIndexSet indexSetWithIndex:2];
                    [weakSelf.mytableView reloadSections:inset withRowAnimation:UITableViewRowAnimationFade];
                    [weakSelf.mytableView.mj_footer endRefreshing];
                }
                else{
                    [weakSelf.mytableView.mj_footer endRefreshingWithNoMoreData];
                }
                
               
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
