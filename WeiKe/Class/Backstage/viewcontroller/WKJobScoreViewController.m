//
//  WKJobScoreViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/1.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobScoreViewController.h"
#import "WKJobScore.h"
#import "WKJobScoreTableViewCell.h"
#import "WKJobSureScoreViewController.h"
#import "WKSelectedJoinClassViewController.h"
@interface WKJobScoreViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) WKJobScore *headerScore;
@property (nonatomic,strong) UITableView *myTableView;
@property (nonatomic,strong)WKJobDetail *jobheader;
@property (nonatomic,strong) NSMutableArray *arrlist;
@property (nonatomic,assign) NSInteger page;
@end

@implementation WKJobScoreViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(void)initTabelView{
    self.headerScore = [[WKJobScore alloc]init];
    self.headerScore = [[[NSBundle mainBundle]loadNibNamed:@"JobScore" owner:nil options:nil]lastObject];
    self.headerScore.frame = CGRectMake(0, 0, SCREEN_WIDTH-20, 397);
    self.headerScore.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.headerScore.jobName .text = self.JobModel.taskName;
    self.headerScore.joinClass.text = self.JobModel.className;
    self.headerScore.remarkText.text = self.JobModel.remark;
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10 ,SCREEN_WIDTH-20, SCREEN_HEIGHT-10) style:UITableViewStylePlain];
     //self.automaticallyAdjustsScrollViewInsets=NO;
    self.myTableView.delegate = self;
    self.myTableView.dataSource = self;
    
    self.myTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.myTableView.showsVerticalScrollIndicator = NO;
  [self.myTableView registerNib:[UINib nibWithNibName:@"WKJobScoreTableViewCell" bundle:nil] forCellReuseIdentifier:@"scoreCell"];
    self.myTableView.tableHeaderView = self.headerScore;
    [self.view addSubview:self.myTableView];
     self.myTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.myTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.myTableView.mj_footer.automaticallyChangeAlpha=YES;

    
    
}
-(void)initData{
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"taskId":[NSNumber numberWithInteger:self.JobModel.id]};
    __weak typeof(self) weakself = self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageJobScoreEditWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.jobheader = object;
                weakself.headerScore.beginTime.text = weakself.jobheader.beginTime;
                weakself.headerScore.endTime.text = weakself.jobheader.endTime;
                weakself.headerScore.joinStu.text =[NSString stringWithFormat:@"%lu",weakself.jobheader.stusNum] ;
                 weakself.headerScore.notSendStu.text =[NSString stringWithFormat:@"%lu",weakself.jobheader.notHandInNum] ;
                
            });
          
        } failed:^(id object) {
            
        }];

    });
   }
-(void)initDataTwo{
    self.page = 1;
    [self.arrlist removeAllObjects];
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"taskId":[NSNumber numberWithInteger:self.JobModel.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageJobSendStudentWithParameter:dic success:^(id object) {
            for (WKJobStu * stu in object ) {
                [weakself.arrlist addObject:stu];
             NSLog(@"----%@",stu.urlList[0]);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.myTableView reloadData];
            });
                 } failed:^(id object) {
            
        }];
        
    });


}
- (void)viewDidLoad {
    [super viewDidLoad];
     [self initTabelView];
    
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];

    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    self.page = 1;
    [self initData];
    [self initDataTwo];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKJobScoreTableViewCell *cell = (WKJobScoreTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"scoreCell" forIndexPath:indexPath];
    WKJobStu *stu = self.arrlist[indexPath.row];
    cell.stuName.text  = stu.stuName;
    cell.watchButton.tag = indexPath.row;
    cell.shareButton.tag = indexPath.row;
    [cell.watchButton addTarget:self action:@selector(setScoreAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.shareButton addTarget:self action:@selector(shareTaskAction:) forControlEvents:UIControlEventTouchUpInside];
    
    if (stu.taskScore == 0 ) {
         cell.Socre.text = @"未评分";
    }
    else{
          cell.Socre.text = [NSString stringWithFormat:@"%lu",stu.taskScore];
    }
      return cell;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, 37)];
    headerView.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    UILabel *onelabel =[[UILabel alloc]initWithFrame:CGRectMake(10, 0, 35, 37)];
    onelabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    onelabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
    onelabel.text = @"姓名";
    UILabel *twolabel =[[UILabel alloc]initWithFrame:CGRectMake(SCREEN_WIDTH/3+10, 0, 35, 37)];
    twolabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    twolabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
   twolabel.text = @"得分";
    UILabel *threelabel =[[UILabel alloc]initWithFrame:CGRectMake((SCREEN_WIDTH/3+10)*2, 0, 35, 37)];
    threelabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    threelabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
    threelabel.text = @"操作";
    [headerView addSubview:onelabel];
    [headerView addSubview:twolabel];
    [headerView addSubview:threelabel];
    return headerView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}
-(void)loadmore{
    self.page+=1;
    
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"taskId":[NSNumber numberWithInteger:self.JobModel.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageJobSendStudentWithParameter:dic success:^(id object) {
            for (WKJobStu * stu in object ) {
                [weakself.arrlist addObject:stu];
                NSLog(@"----%@",stu.urlList[0]);
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.myTableView reloadData];
                [weakself.myTableView.mj_footer endRefreshing];
            });
        } failed:^(id object) {
            
        }];
        
    });

}
-(void)setScoreAction:(UIButton*)button{
    WKJobSureScoreViewController *sure = [[WKJobSureScoreViewController alloc]init];
    sure.model = self.arrlist[button.tag];
    [self.navigationController pushViewController:sure animated:YES];
}
-(void)shareTaskAction:(UIButton*)button{
    WKSelectedJoinClassViewController *selected = [[WKSelectedJoinClassViewController alloc]init];
    selected.isShare = YES;
    selected.stuModel = self.arrlist [button.tag];
    selected.taskId = self.JobModel.id;
    [self.navigationController pushViewController:selected animated:YES];
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
