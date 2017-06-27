//
//  WKCommentHelpViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCommentHelpViewController.h"
#import "WKMessageHandler.h"
#import "WKCommentMeTableViewCell.h"
#import "UUInputAccessoryView.h"
@interface WKCommentHelpViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) UISegmentedControl *segControl;
@property (nonatomic,assign) NSInteger page;
@property (strong ,nonatomic) UITableView *myTableView;
@property (strong,nonatomic) NSMutableArray *arrList;
@property (assign ,nonatomic) CGFloat oneHeight;
@property (assign ,nonatomic) CGFloat twoHeight;
@property (strong,nonatomic)  MBProgressHUD *hud;
@end

@implementation WKCommentHelpViewController
#pragma mark - 懒加载
-(NSMutableArray *)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}

#pragma mark - init (初始化)
-(void)initStyle{
    self.segControl = [[UISegmentedControl alloc]initWithItems:@[@"我的评论",@"评论我的"]];
    self.segControl.frame = CGRectMake(0, 0, 168, 26);
    self.segControl.selectedSegmentIndex = 0;
    self.segControl.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.segControl addTarget:self action:@selector(segmentChangeselected:) forControlEvents:UIControlEventValueChanged];
    self.navigationItem.titleView = self.segControl;
   }
-(void)initTabelView{
    self.myTableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    [_myTableView registerNib:[UINib nibWithNibName:@"WKCommentMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"commentCell"];
     _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    self.myTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.myTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.myTableView.mj_footer.automaticallyChangeAlpha=YES;
    self.myTableView.mj_header=[MJRefreshNormalHeader  headerWithRefreshingTarget:self refreshingAction:@selector(freshData)];
    self.myTableView.mj_header.automaticallyChangeAlpha=YES;
    [self.view addSubview:_myTableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];

}

-(void)initData{
    self.page =1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"sendOrReceiver":[NSNumber numberWithInteger:self.segControl.selectedSegmentIndex+1]};
    __weak typeof(self) weakself =self;
    [self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageCommentWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKCommentListModel *model in object) {
                    [weakself.arrList addObject:model];
                }
                [weakself.myTableView reloadData];
            });
        } failed:^(id object) {
            
        }];
    });
    
}

#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    [self initTabelView];
    [self initData];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
   
    return 1;
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKCommentMeTableViewCell *cell = (WKCommentMeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"commentCell" forIndexPath:indexPath];
    cell.deleteButton.tag = indexPath.section;
    [cell.deleteButton addTarget:self action:@selector(deleteCommentAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrList.count ) {
        WKCommentListModel *model = self.arrList[indexPath.section];
        if (self.segControl.selectedSegmentIndex == 0) {
            cell.headImage.hidden = YES;
            if (model.videoImg.length>2) {
                NSString *string = [NSString stringWithFormat:@"我 评论了%@的视频《%@》",model.receiverName,model.videoTitle];
                NSMutableAttributedString *Mutstring = [[NSMutableAttributedString alloc]initWithString:string];
                NSRange greenRange = NSMakeRange(0, 1);
                [Mutstring addAttribute:NSForegroundColorAttributeName value:[WKColor colorWithHexString:GREEN_COLOR] range:greenRange];
                [cell.commenttitle setAttributedText:Mutstring];
                [ cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImg] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
                cell.videoImage.hidden = NO;
                cell.commentbackView.hidden = YES;
            }
            else{
                 NSString *string = [NSString stringWithFormat:@"我 回复了%@在视频《%@》",model.receiverName,model.videoTitle];
                NSMutableAttributedString *Mutstring = [[NSMutableAttributedString alloc]initWithString:string];
                NSRange greenRange = NSMakeRange(0, 1);
                [Mutstring addAttribute:NSForegroundColorAttributeName value:[WKColor colorWithHexString:GREEN_COLOR] range:greenRange];
                [cell.commenttitle setAttributedText:Mutstring];
                cell.commentbackView.hidden = NO;
                cell.commented.text = model.pIdConText;
                cell.videoImage.hidden = YES;
            }
            
            self.oneHeight = [WKCommentMeTableViewCell heightForLabel:cell.commenttitle.text withIndex:1];
            cell.commenttitle.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, self.oneHeight);
            cell.commentCOntent.text = model.contentText;
            self.twoHeight = [WKCommentMeTableViewCell heightForTwoLabel:cell.commentCOntent.text];
            cell.commentCOntent.frame = CGRectMake(10, 20+self.oneHeight, SCREEN_WIDTH-118, self.twoHeight);
            cell.commentTime.text = model.sendTime;
         return cell;
        
        }
        cell.headImage.hidden = NO;
       [cell.headImage sd_setImageWithURL:[NSURL URLWithString:model.senderImg] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
        if (model.videoImg.length>2) {
            NSString *string = [NSString stringWithFormat:@"%@ 评论了你的视频《%@》",model.senderName,model.videoTitle];;
            NSMutableAttributedString *Mutstring = [[NSMutableAttributedString alloc]initWithString:string];
            NSRange greenRange = NSMakeRange(0, model.senderName.length);
            [Mutstring addAttribute:NSForegroundColorAttributeName value:[WKColor colorWithHexString:GREEN_COLOR] range:greenRange];
           [cell.commenttitle setAttributedText:Mutstring];
            [ cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImg] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
            cell.videoImage.hidden = NO;
            cell.commentbackView.hidden = YES;
        }
        else{
            NSString *string = [NSString stringWithFormat:@"%@ 回复了你在视频《%@》",model.senderName,model.videoTitle];
            NSMutableAttributedString *Mutstring = [[NSMutableAttributedString alloc]initWithString:string];
            NSRange greenRange = NSMakeRange(0, model.senderName.length);
            [Mutstring addAttribute:NSForegroundColorAttributeName value:[WKColor colorWithHexString:GREEN_COLOR] range:greenRange];
            [cell.commenttitle setAttributedText:Mutstring];

            //cell.commenttitle.text = [NSString stringWithFormat:@"%@ 回复了你在视频《%@》",model.senderName,model.videoTitle];
            cell.commentbackView.hidden = NO;
            cell.commented.text = model.pIdConText;
            cell.videoImage.hidden = YES;
        }
        self.oneHeight = [WKCommentMeTableViewCell heightForLabel:cell.commenttitle.text withIndex:2];
        cell.commenttitle.frame = CGRectMake(54, 16, SCREEN_WIDTH-64, self.oneHeight);
        cell.commentCOntent.text = model.contentText;
        self.twoHeight = [WKCommentMeTableViewCell heightForTwoLabel:cell.commentCOntent.text];
        cell.commentCOntent.frame = CGRectMake(10, 26+self.oneHeight, SCREEN_WIDTH-118, self.twoHeight);
        cell.commentTime.text = model.sendTime;
        return cell;


    }
         return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrList.count) {
        return self.arrList.count;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segControl.selectedSegmentIndex == 1) {
        WKCommentListModel *model = self.arrList[indexPath.section];
        if (model.videoImg.length&&model.senderId!=model.receiverId) {
            UIKeyboardType type =  UIKeyboardTypeDefault;
            NSString *content = @"";
            
            [UUInputAccessoryView showKeyboardType:type
                                           content:content
                                             Block:^(NSString *contentStr)
             {
              
                 
                 NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:model.id],@"senderType":USERTYPE,@"contentText":contentStr};
                 __weak typeof(self) weakself = self;
                 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                     [WKMessageHandler executeGetMessageCommentReplyWithParameter:dic success:^(id object) {
                         dispatch_async(dispatch_get_main_queue(), ^{
                             [weakself.hud showAnimated:YES];
                             if ([[object objectForKey:@"flag"]intValue]) {
                                 [weakself initData];
                             }
                             weakself.hud.label.text = [object objectForKey:@"msg"];
                             [weakself.hud hideAnimated:YES afterDelay:1];

                         });
                     } failed:^(id object) {
                         
                     }];
                 });
                 
             }];

        }
    }
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.segControl.selectedSegmentIndex==0) {
        if (self.twoHeight+32>88) {
            return self.oneHeight+20+self.twoHeight+32;
        }
        return self.oneHeight+20+88;

    }
    else{
        if (self.oneHeight+26>54) {
            if (self.twoHeight+32>88) {
                return self.oneHeight+26+self.twoHeight+32;
            }
            return self.oneHeight+26+88;

        }
        else{
            if (self.twoHeight+32>88) {
                return 54+26+self.twoHeight+32;
            }
            return 54+88;

        }
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
  
    return 10;
    
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
#pragma mark - MJrefresh(刷新和更多)

-(void)freshData{
    self.page = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"sendOrReceiver":[NSNumber numberWithInteger:self.segControl.selectedSegmentIndex+1]};
    __weak typeof(self) weakself =self;
 
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageCommentWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKCommentListModel *model in object) {
                    [weakself.arrList addObject:model];
                }
                [weakself.myTableView reloadData];
                  [weakself.myTableView.mj_header endRefreshing];
            });
        } failed:^(id object) {
            
        }];
    });
    
}


-(void)loadmore{
    self.page +=1;
 
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"sendOrReceiver":[NSNumber numberWithInteger:self.segControl.selectedSegmentIndex+1]};
    __weak typeof(self) weakself =self;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageCommentWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
           
                for (WKCommentListModel *model in object) {
                    [weakself.arrList addObject:model];
                }
                [weakself.myTableView reloadData];
                  [weakself.myTableView.mj_footer endRefreshing];
            });
        } failed:^(id object) {
            
        }];
    });
    
    
}
#pragma mark - Action(点击事件)
-(void)deleteCommentAction:(UIButton*)sender{
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
    [self.hud showAnimated:YES];
    WKCommentListModel *model = self.arrList[tag];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:model.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageCommentdeleteWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]integerValue]) {
                    [weakself initData];
                }
                weakself.hud.label.text = [object objectForKey:@"msg"];
                [weakself.hud hideAnimated:YES afterDelay:1];
            });
        } failed:^(id object) {
            
        }];
    });

}
-(void)segmentChangeselected:(UISegmentedControl*)seg{
 
    [self initData];
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
