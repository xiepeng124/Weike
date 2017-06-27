//
//  WKMessageViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/19.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMessageViewController.h"
#import "WKMessageOneTableViewCell.h"
#import "WKMessageTwoTableViewCell.h"
#import "WKMessageHandler.h"
#import "WKCommentHelpViewController.h"
#import "WKWatchShareTaskViewController.h"
@interface WKMessageViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (strong ,nonatomic) UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *arrList;
@property (assign,nonatomic) NSInteger page;
@property (assign,nonatomic) CGFloat labelHeight;

@end

@implementation WKMessageViewController
#pragma mark - 懒加载
-(NSMutableArray *)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}
#pragma mark - init (初始化)
-(void)initStyle{
     UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton.title = @"标记全部已读";
    rightButton.tintColor = [WKColor colorWithHexString:DARK_COLOR];
    [rightButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:13]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
    self.navigationItem.title = @"消息中心";
}
-(void)initTabelView{
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_myTableView registerNib:[UINib nibWithNibName:@"WKMessageOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"oneCell"];
      [_myTableView registerNib:[UINib nibWithNibName:@"WKMessageTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"twoCell"];
    _myTableView.showsVerticalScrollIndicator = YES;
    //_myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    self.myTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.myTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.myTableView.mj_footer.automaticallyChangeAlpha=YES;
    self.myTableView.mj_header=[MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTableView.mj_header.automaticallyChangeAlpha=YES;
    [self.view addSubview:_myTableView];
}
-(void)initData{
    self.page = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;

    [self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [WKMessageHandler executeGetMessageListWithParameter:dic success:^(id object) {
         dispatch_async(dispatch_get_main_queue(), ^{
             for (WKMessageModel *model in object) {
                 [weakSelf.arrList addObject:model];
             }
             [weakSelf.myTableView reloadData];

         });
             } failed:^(id object) {
         
     }];
    });
}
#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    [self initStyle];
    [self initTabelView];
    [self initData];
    
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  1;

  
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section ==0) {
        WKMessageOneTableViewCell *cell = (WKMessageOneTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"oneCell" forIndexPath:indexPath];
        [cell.watchAllButton addTarget:self action:@selector(goCommentList) forControlEvents:UIControlEventTouchUpInside];
           [cell.allCommentButton addTarget:self action:@selector(goCommentList) forControlEvents:UIControlEventTouchUpInside];
        if (self.arrList.count) {
            WKMessageModel *model =self.arrList[0];
            if (model.commentLength) {
                [cell.commentImage setBackgroundImage:[UIImage imageNamed:@"message_two_on"] forState:UIControlStateNormal];
            }
            else{
                [cell.commentImage setBackgroundImage:[UIImage imageNamed:@"message_two_off"] forState:UIControlStateNormal];
            }
        }
        return cell;
    }
    
    WKMessageTwoTableViewCell *cell = (WKMessageTwoTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"twoCell" forIndexPath:indexPath];
    cell.messageDelete.tag = indexPath.section;
    cell.watchTask.tag = indexPath.section;
    cell.watchButton.tag = indexPath.section;
    [cell.messageDelete addTarget:self action:@selector(deleteMessageAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrList.count) {
        WKMessageModel *model = self.arrList[indexPath.section-1];
        switch ([model.msgType intValue]) {
            case 2:
            {
                [cell.watchButton setHidden:YES];
                [cell.watchTask setHidden:YES];
                if ([model.readFlag intValue]==0) {
                    [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"inform_on"] forState:UIControlStateNormal];

                }
                else{
                    [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"inform-off"] forState:UIControlStateNormal];

                }
            }
                break;
            case 3:
            {
                [cell.watchButton setHidden:YES];
                [cell.watchTask setHidden:YES];
                if ([model.readFlag intValue]==0){
                  [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"work_on"] forState:UIControlStateNormal];
                }
                else{
                    [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"work"] forState:UIControlStateNormal];
                 
                }
            }
                break;
            case 4:
            {
                [cell.watchButton setHidden:NO];
                [cell.watchTask setHidden:NO];
                [cell.watchButton addTarget:self action:@selector(watchShareTaskButton:) forControlEvents:UIControlEventTouchUpInside];
                  [cell.watchTask addTarget:self action:@selector(watchShareTaskButton:) forControlEvents:UIControlEventTouchUpInside];
                if ([model.readFlag intValue]==0){
                   
                [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"shareing"] forState:UIControlStateNormal];
                }
                else{
                [cell.messageImage setBackgroundImage:[UIImage imageNamed:@"share"] forState:UIControlStateNormal];
                }
            }
                break;
                
            default:
                break;
        }
        cell.messageTitle.text = model.msgTitle;
        cell.messageTime.text = model.sendTime;
        cell.messageContent.text = model.msgContent;
        self.labelHeight = [WKMessageTwoTableViewCell heightForLabel:cell.messageContent.text];
        cell.messageContent.frame = CGRectMake(10, 75, SCREEN_WIDTH-20, self.labelHeight);
        return cell;

    }
    return cell;
    
    
  
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrList.count) {
        
        return self.arrList.count+1;
    }
    return 1;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        WKCommentHelpViewController *comment = [[WKCommentHelpViewController alloc]init];
        [self.navigationController pushViewController:comment animated:YES];
    }
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
 }
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0) {
        return 60;
    }
    return 60+15+self.labelHeight+10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section ==0) {
        return 0;
    }
    return 10;
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;

    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}

#pragma mark - MJrefresh(刷新和更多)
-(void)freshData{
       self.page = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;
 
    [self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageListWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKMessageModel *model in object) {
                    [weakSelf.arrList addObject:model];
                }
                [weakSelf.myTableView reloadData];
                [weakSelf.myTableView.mj_header endRefreshing];

            });
                   } failed:^(id object) {
            
        }];
    });

}


-(void)loadmore{
    self.page +=1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;

    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageListWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{

            
                    for (WKMessageModel *model in object) {
                        [weakSelf.arrList addObject:model];
                    }
                    [weakSelf.myTableView reloadData];
                    [weakSelf.myTableView.mj_footer endRefreshing];

      
                
            });
            } failed:^(id object) {
            
        }];
    });

}
#pragma mark - Action(点击事件)
-(void)goCommentList{
    WKCommentHelpViewController *comment = [[WKCommentHelpViewController alloc]init];
    [self.navigationController pushViewController:comment animated:YES];
}
-(void)selectRightAction:(UIButton*)sender{
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageSawWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself initData];
            });
        } failed:^(id object) {
            
        }];
    });
    
}
-(void)watchShareTaskButton:(UIButton*)sender{
    WKMessageModel *model = self.arrList[sender.tag-1];
    WKWatchShareTaskViewController *shareTask = [[WKWatchShareTaskViewController alloc]init];

   
    shareTask.msgId = model.msgId;
    shareTask.stid = model.stid;
    shareTask.stuName = model.stuName;
    [self.navigationController pushViewController:shareTask animated:YES];
}
-(void)deleteMessageAction:(UIButton*)sender{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定删除消息" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteAction:sender.tag];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];

}
-(void)deleteAction:(NSInteger)tag{
    WKMessageModel *model = self.arrList[tag];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:model.id],@"loginUserId":LOGINUSERID};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageDeleteWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakSelf initData];
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
