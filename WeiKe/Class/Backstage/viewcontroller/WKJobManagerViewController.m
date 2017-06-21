//
//  WKJobManagerViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobManagerViewController.h"
#import "WKRoleView.h"
#import "WKJobTableViewCell.h"
#import "WKBackstage.h"
#import "WKJobEditViewController.h"
#import "WKJobScoreViewController.h"
#import "WKOpenTeachTaskViewController.h"
#import "WKMeHandler.h"
@interface WKJobManagerViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) WKRoleView *roleHeadView;
@property (strong,nonatomic) UITableView *jobTableView;
@property (strong,nonatomic) MBProgressHUD *hud;
@property (strong ,nonatomic) NSMutableArray *arrlist;
@property (assign ,nonatomic) CGFloat heightcontent;
@property (strong ,nonatomic) NSMutableArray *arrNumber;
@property (strong,nonatomic) UIButton *allButton;
@property (assign,nonatomic)BOOL isMore;
@property (assign,nonatomic)NSInteger page;
@end

@implementation WKJobManagerViewController
-(NSMutableArray*)arrNumber{
    if (!_arrNumber) {
        _arrNumber = [NSMutableArray array];
    }
    return _arrNumber;
}

-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(void)initStyle{
    NSArray *arrlist = [[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil];
    self.roleHeadView = [[WKRoleView alloc]init];
    self.roleHeadView  = [arrlist lastObject];
    self.roleHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.roleHeadView.localButton setHidden:YES];
   self.roleHeadView.roleLable.text = @"作业管理";
    self.roleHeadView.addLable.text =@"添加作业";
    [self.roleHeadView .backButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteTapGesture:)];
    tap.numberOfTapsRequired = 1 ;
    [self.roleHeadView.deleteView addGestureRecognizer:tap];
    [self.roleHeadView.addView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.roleHeadView];
    UIView *allJobView = [[UIView alloc]initWithFrame:CGRectMake(10, 118, SCREEN_WIDTH-20, 32)];
    allJobView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    allJobView.layer.cornerRadius = 3;
   _allButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _allButton.frame = CGRectMake(10, 10, 17, 17);
    [_allButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [_allButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    [_allButton addTarget:self action:@selector(selectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
    UILabel *allJobLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 4, 80, 28)];
    allJobLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    allJobLabel.textColor = [WKColor colorWithHexString:@"333333"];
    allJobLabel.text = @"全部作业";
    [allJobView addSubview:_allButton];
    [allJobView addSubview:allJobLabel];
    [self.view addSubview:allJobView];
}
-(void)initTableView{
    self.jobTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 150, SCREEN_WIDTH-20, SCREEN_HEIGHT-160) style:UITableViewStylePlain];
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    self.jobTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.jobTableView.showsVerticalScrollIndicator = NO;
    self.jobTableView.showsHorizontalScrollIndicator = NO;
    [self.jobTableView registerNib:[UINib nibWithNibName:@"WKJobTableViewCell" bundle:nil]
            forCellReuseIdentifier:@"mycell"];
    self.jobTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.jobTableView.mj_footer.automaticallyChangeAlpha=YES;
    [self.view addSubview:self.jobTableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];

}
-(void)initData{
    __weak typeof(self) weakSelf = self;
    [self.arrlist removeAllObjects];
    self.page = 1;
    NSDictionary *dic = @{@"page": @1,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageIJobSearchKeepWithParameter:dic success:^(id object) {
            for (WKJobModel *model in object) {
                [weakSelf.arrlist addObject:model];
            }
            NSLog(@"arrlist.cont= %lu",weakSelf.arrlist.count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.jobTableView reloadData];
            });
        } failed:^(id object) {
            
        }];
    });
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
        [self initTableView];
    self.navigationItem.hidesBackButton  = YES;
    self.search.placeholder = @"搜索相关作业";
    [self.view setBackgroundColor:[WKColor colorWithHexString:LIGHT_COLOR]];
    self.isMore = NO;
    self.page = 1;
    //[self initData];

   
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
     [self initData];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKJobTableViewCell *cell = [[WKJobTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKJobTableViewCell" owner:nil options:nil]lastObject];
    if (self.arrlist.count ==0) {
        return cell;
    }
    for (int i= 0; i<self.arrNumber.count; i++) {
        if ([self.arrNumber[i]integerValue]==indexPath.section) {
            cell.selectButton.selected = YES;
        }
    }

    
    WKJobModel *Model = self.arrlist[indexPath.section];
    cell.roleName.text = Model.taskName;
    cell.editButton.tag = indexPath.section;
    cell.deleteButton.tag = indexPath.section;
    cell.selectButton.tag = indexPath.section;
    cell.scoreButton.tag = indexPath.section;
    cell.downloadButton.tag = indexPath.section;
    cell.promulgator.text = [NSString stringWithFormat:@"发布者：%@",Model.teacherName];
    cell.schoolYear.text = [NSString stringWithFormat:@"学年：%lu",Model.schoolYear];
    cell.contentLabel.text = [NSString stringWithFormat:@"班级：%@",Model.className];
    self.heightcontent = [WKJobTableViewCell heightForLabel:
                          cell.contentLabel.text];
    cell.contentLabel.frame = CGRectMake(10, 72, SCREEN_WIDTH-40, self.heightcontent);
    [cell.editButton addTarget:self action:@selector(editJobAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.deleteButton addTarget:self action:@selector(deleteJobAction:) forControlEvents:UIControlEventTouchUpInside];
      [cell.selectButton addTarget:self action:@selector(selectedJobAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.scoreButton addTarget:self action:@selector(scoreJobAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.downloadButton addTarget:self action:@selector(watchJobAction:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrlist.count==0) {
        return 1;
    }
   
    return self.arrlist.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
      return 122+self.heightcontent;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //NSLog(@"111");
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}

-(void)tapGesture:(UITapGestureRecognizer*)gesture{
    WKJobEditViewController *edit = [[WKJobEditViewController alloc]init];
    edit.isAdd = YES;
    edit.jobModel = [[WKJobModel alloc]init];
    [self.navigationController pushViewController:edit animated:YES];
}
-(void)deleteTapGesture:(UITapGestureRecognizer*)gesture{
    self.isMore = YES;
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定进行批量删除?" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteJobAction:nil];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];

//    for (int i=0; i<self.arrNumber.count; i++) {
//        NSString *cellid;
//        WKJobModel *model = self.arrlist[[self.arrNumber[i]integerValue]];
//        if (i==0) {
//            cellid = [NSString stringWithFormat:@"%lu",model.id];
//        }
//        else{
//            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
//        }
//        
//        
//    }
//
}
-(void)selectedAllAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    [self.arrNumber removeAllObjects];
    if (sender.selected) {
        for (int i =0; i<self.arrlist.count; i++) {
            [self.arrNumber addObject:[NSNumber numberWithInteger:i]];
        }
    }
    else{
        
    }
    [self.jobTableView reloadData];
}
-(void)editJobAction:(UIButton*)button{
    WKJobEditViewController *edit = [[WKJobEditViewController alloc]init];
    edit.jobModel = self.arrlist[button.tag];
    edit.isAdd = NO;
    [self.navigationController pushViewController:edit animated:YES];
}
-(void)deleteJobAction:(UIButton*)button{
    NSLog(@";;;;");
    NSString *cellid;
    if (self.isMore) {
        for (int i=0; i<self.arrNumber.count; i++) {
          
            WKJobModel *model = self.arrlist[[self.arrNumber[i]integerValue]];
            if (i==0) {
                cellid = [NSString stringWithFormat:@"%lu",model.id];
            }
            else{
                cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
            }
            
            
        }
        self.isMore = NO;
    }
    else{
          WKJobModel *job = self.arrlist[button.tag];
        cellid = [NSString stringWithFormat:@"%lu",job.id];
    }
    NSLog(@"button.tag =%lu",button.tag);
  
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"ids":
                              cellid};
    __weak typeof(self) weakself =self;
    [WKBackstage executeGetBackstageIJobDeleteWithParameter:dic success:^(id object) {
        if ([[object objectForKey:@"flag"]intValue]) {
            [weakself initData];
        }
    } failed:^(id object) {
        
    }];
}
-(void)watchJobAction:(UIButton*)sender{
    WKJobModel *model = self.arrlist[sender.tag];
    __weak typeof(self) weakself = self;
    WKOpenTeachTaskViewController *open = [[WKOpenTeachTaskViewController alloc]init];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:model.id]};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyTeachTaskWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *string = [object objectForKey:@"taskUrl"];
                open.taskUrl = string;
                [weakself.navigationController pushViewController:open animated:YES];
            });
        } failed:^(id object) {
            
        }];
    });

}
-(void)selectedJobAction:(UIButton*)button{
    button.selected = !button.selected;
    if (button.selected) {
        [self.arrNumber addObject:[NSNumber numberWithInteger:button.tag]];
    }
    else{
         [self.arrNumber removeObject:[NSNumber numberWithInteger:button.tag]];
    }
}
-(void)scoreJobAction:(UIButton*)sender{
    WKJobScoreViewController *score = [[WKJobScoreViewController alloc]init];
    score.JobModel = self.arrlist[sender.tag];
    [self.navigationController pushViewController:score animated:YES];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)loadMore{
    __weak typeof(self) weakSelf = self;
    self.page +=1;
    NSDictionary *dic = @{@"page": [NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageIJobSearchKeepWithParameter:dic success:^(id object) {
            for (WKJobModel *model in object) {
                [weakSelf.arrlist addObject:model];
            }
            NSLog(@"arrlist.cont= %lu",weakSelf.arrlist.count);
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf.jobTableView reloadData];
                [weakSelf.jobTableView.mj_footer endRefreshing];
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
