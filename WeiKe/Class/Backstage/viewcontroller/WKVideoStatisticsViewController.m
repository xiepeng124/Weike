//
//  WKVideoStatisticsViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/13.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoStatisticsViewController.h"
#import "WKVideoStatisticsTableViewCell.h"
#import "WKHeadview.h"
#import "WKBackstage.h"
#import "WKStatisticsSectionView.h"
#import "WKTeacherVideoListViewController.h"
@interface WKVideoStatisticsViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
@property (strong,nonatomic) UITableView *myTableView;
@property (strong ,nonatomic) WKHeadview *myheadview;
@property (assign,nonatomic) NSInteger page;
@property (strong,nonatomic) WKStatisticsSectionView *sectionView;
@property (strong,nonatomic) NSMutableArray *arrlist;
@property (strong,nonatomic) NSMutableArray *arrSection;
@end

@implementation WKVideoStatisticsViewController
-(NSMutableArray *)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray *)arrSection{
    if (!_arrSection) {
        _arrSection = [NSMutableArray array];
    }
    return _arrSection;
}

-(void)initStyle{
    NSArray *arrlist = [[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil];
    self.myheadview = [[WKHeadview alloc]init];
    //    self.headView = [[WKHeadview alloc]init];
    self.myheadview  = [arrlist lastObject];
    self.myheadview.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.myheadview.localButton setHidden:YES];
    [self.myheadview.addView setHidden:YES];
    [self.myheadview.deleteView setHidden:YES];
    self.myheadview.roleLable.text = @"视频统计管理";
    [self.myheadview.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.myheadview];
}
-(void)initTableView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 118, SCREEN_WIDTH-20, SCREEN_HEIGHT-118) style:UITableViewStylePlain];
    self.myTableView.showsVerticalScrollIndicator = NO;
    self.myTableView.showsHorizontalScrollIndicator = NO;
    self.myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.myTableView registerNib:[UINib nibWithNibName:@"WKVideoStatisticsTableViewCell" bundle:nil] forCellReuseIdentifier:@"statisticsCell"];
    self.myTableView.delegate =self;
    self.myTableView.dataSource = self;
    self.myTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self.view addSubview:self.myTableView];
    self.myTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.myTableView.mj_footer.automaticallyChangeAlpha=YES;

}
-(void)InitData{
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"searchMsg":self.search.text,@"schoolId":SCOOLID};
    __weak typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoStatistWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKVIdeoStatisticsModel *model in object) {
                    [weakself.arrlist addObject:model];
                }
                [weakself.myTableView reloadData];
            });
        } failed:^(id object) {
            
        }];
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initStyle];
    [self initTableView];
    [self InitData];
    self.search.delegate = self;
    self.search.placeholder = @"搜索职务";
    self.navigationItem.hidesBackButton = YES;
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if (self.arrlist.count) {
        
        WKVIdeoStatisticsModel *model = self.arrlist[section];
        for (int i=0; i<self.arrSection.count; i++) {
            if (section == [self.arrSection[i]integerValue]) {
              return model.videoStatic.count;
            }
        }
        
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoStatisticsTableViewCell *cell = (WKVideoStatisticsTableViewCell*)  [tableView dequeueReusableCellWithIdentifier:@"statisticsCell" forIndexPath:indexPath];
    if (self.arrlist.count) {
        WKVIdeoStatisticsModel *model = self.arrlist[indexPath.section];
        NSString *stingOne = [model.videoStatic[indexPath.row] objectForKey:@"percentTime"];
        NSString *stringTwo = [model.videoStatic[indexPath.row] objectForKey:@"title"];
        cell.videoName.text = [NSString stringWithFormat:@"(%lu)%@",indexPath.row+1,stringTwo];
        cell.videoPercent.text = [NSString stringWithFormat:@"(%@)",stingOne];
        return cell;
    }
    
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrlist.count) {
        return self.arrlist.count;
    }
    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 107;
}
- (void)tableView:(UITableView *)tableView willDisplayFooterView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //NSLog(@"111");
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 10;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    self.sectionView = [[WKStatisticsSectionView alloc]init];
    self.sectionView = [[[NSBundle mainBundle]loadNibNamed:@"statisticsSectionView" owner:nil options:nil]lastObject];
    [self.sectionView.updownButton addTarget:self action:@selector(controlCellAction:) forControlEvents:UIControlEventTouchUpInside];
    self.sectionView.updownButton.tag = section;
    self.sectionView.videoNumber.tag = section;
        [self.sectionView.videoNumber addTarget:self action:@selector(videoListlAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrlist.count) {
        WKVIdeoStatisticsModel *model = self.arrlist[section];
        
        self.sectionView.teachName.text = model.teacherName;
        [ self.sectionView.videoNumber setTitle:[NSString stringWithFormat:@"视频个数：%lu",model.hasNum] forState: UIControlStateNormal ];
        if (model.totalPlaytimes.intValue>0) {
            self.sectionView.playNumber.text =[NSString stringWithFormat:@"播放量：%@", model.totalPlaytimes];
            
        }
        else{
            self.sectionView.playNumber.text = @"播放量：无";
        }
        for (int i=0; i<self.arrSection.count; i++) {
            if (section == [self.arrSection[i]integerValue]) {
                self.sectionView.updownButton.selected = YES;
            }
        }
        return self.sectionView;

    }
        return self.sectionView;
}
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)controlCellAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.arrSection addObject:[NSNumber numberWithInteger:sender.tag]];
    }
    else{
        [self.arrSection removeObject:[NSNumber numberWithInteger:sender.tag]];
    }
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:sender.tag];
    [self.myTableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];

}
-(void)videoListlAction:(UIButton*)sender{
    WKTeacherVideoListViewController *videoList= [[WKTeacherVideoListViewController alloc]init];
    WKVIdeoStatisticsModel *model = self.arrlist[sender.tag];
    videoList.myId =model.teacherId;
    [self.navigationController pushViewController:videoList animated:YES];
}
-(void)loadmore{
    self.page+=1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"searchMsg":self.search.text,@"schoolId":SCOOLID};
    __weak typeof(self) weakself = self;
      dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoStatistWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *arr = object;
                if (!arr.count) {
                    [weakself.myTableView.mj_footer endRefreshingWithNoMoreData];
                }
                for (WKVIdeoStatisticsModel *model in object) {
                    [weakself.arrlist addObject:model];
                                    }
                               [weakself.myTableView reloadData];
                [weakself.myTableView.mj_footer endRefreshing];
            });
        } failed:^(id object) {
            
        }];
    });

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self InitData];
    return YES;
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
