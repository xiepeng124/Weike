//
//  WKApprovalViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKApprovalViewController.h"
#import "WKRoleView.h"
#import "WKVideoTableViewCell.h"
#import "WKBackstage.h"
#import "WKApprovalingViewController.h"
#import "WKHomeOutLinkViewController.h"
#import "WKplayViewController.h"
@interface WKApprovalViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,VideoDelegate>
@property (strong ,nonatomic) WKRoleView *roleHeadView;
@property (strong,nonatomic) UIButton *outside;
@property(strong,nonatomic)UITableView *videoTableview;
@property (strong,nonatomic)MBProgressHUD *hud;
@property(strong,nonatomic)NSMutableArray *videolist;
@property (strong,nonatomic)NSMutableArray *arrnumber;
@property (assign,nonatomic)BOOL isApproal;
@property (assign ,nonatomic) NSInteger onePage;
@property (assign ,nonatomic) NSInteger twoPage;
@end

@implementation WKApprovalViewController
-(NSMutableArray*)videolist{
    if (!_videolist) {
        _videolist = [NSMutableArray array];
    }
    return _videolist;
}
-(NSMutableArray*)arrnumber{
    if (!_arrnumber) {
        _arrnumber = [NSMutableArray array];
    }
    return _arrnumber;
}
-(void)initStyle{
    NSArray *arrlist = [[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil];
    self.roleHeadView = [[WKRoleView alloc]init];
    //    self.headView = [[WKHeadview alloc]init];
    self.roleHeadView  = [arrlist lastObject];
    self.roleHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.roleHeadView.localButton setHidden:NO];
    self.roleHeadView.roleLable.hidden = YES;
    
    self.outside = [UIButton buttonWithType:UIButtonTypeCustom];
    self.outside.frame = CGRectMake(130, 0, 70, 44);
    self.outside.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:17];
    [self.outside setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [ self.outside  setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected];
    [self.roleHeadView.localButton setTitle:@"待审批" forState:  UIControlStateNormal];

    [self.outside setTitle:@"已审批" forState:  UIControlStateNormal];
    self.roleHeadView.localButton.selected = YES;
    self.outside.selected = NO;
    self.roleHeadView.onvideoImage.hidden = YES;
    self.roleHeadView.addLable.hidden = YES;
    self.roleHeadView.deleteLable.text = @"批量审核";
    self.roleHeadView.rightImage.image = [UIImage imageNamed:@"组-5"];
    [self.roleHeadView.localButton addTarget:self action:@selector(getNotApprovalVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.outside addTarget:self action:@selector(getApprovalVideo:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.roleHeadView addSubview:self.outside];
    [self.roleHeadView .backButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreApprovalTapGesture:)];
    tap.numberOfTapsRequired = 1 ;
    [self.roleHeadView.deleteView addGestureRecognizer:tap];
     [self.view addSubview:self.roleHeadView];
    self.isApproal = NO;
}
-(void)initTableView{
    self.videoTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 114, SCREEN_WIDTH, SCREEN_HEIGHT-114) style:UITableViewStylePlain];
    self.videoTableview.delegate = self;
    self.videoTableview.dataSource = self;
    self.videoTableview.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.videoTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.videoTableview.showsVerticalScrollIndicator = NO;
    self.videoTableview.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:self.videoTableview];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
    self.videoTableview.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.videoTableview.mj_footer.automaticallyChangeAlpha=YES;


}
-(void)initData{
    self.onePage= 1;
    NSDictionary *dic =@{@"page":[NSNumber numberWithBool:self.onePage],@"token": TOKEN,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    [self.videolist removeAllObjects];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageNotApprovalVideoWithParameter:dic success:^(id object) {
            // NSLog(@"object  = %@",object);
            for (WKVideoModel *model  in object) {
                [weakself.videolist addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.videoTableview reloadData];
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });

}
-(void)initDataTwo{
    self.twoPage = 1;
    NSDictionary *dic =@{@"page":[NSNumber numberWithInteger:self.twoPage],@"token": TOKEN,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    [self.videolist removeAllObjects];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageApprovaledVideoWithParameter:dic success:^(id object) {
            // NSLog(@"object  = %@",object);
            for (WKVideoModel *model  in object) {
                [weakself.videolist addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.videoTableview reloadData];
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.search.placeholder = @"搜索视频";
    self.search.delegate = self;
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    [self initTableView];
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    if (self.isApproal) {
        [self initDataTwo];
    }
    else{
    [self initData];
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoTableViewCell *cell = [[WKVideoTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKVideoTableViewCell" owner:nil options:nil]lastObject];
    WKVideoModel *model = self.videolist[indexPath.section];
    cell.titleLabel.text = model.title;
    [cell.adButton setHidden: YES];
    cell.delegate = self;
    cell.selectedButton.tag = indexPath.section;
    cell.promuButton.tag = indexPath.section;
   [ cell.promuButton setTitle:@"审批" forState: UIControlStateNormal ];
    for (int i= 0; i<self.arrnumber.count; i++) {
        if ([self.arrnumber[i]integerValue]==indexPath.section) {
            cell.selectedButton.selected = YES;
        }
    }
    if (model.videoImage) {
        [ cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImage] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority ];
    }
    else{
        [ cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority ];
    }
    
    
    cell.promulgator.text = [NSString stringWithFormat:@"发布者：%@",model.teacherName];
    [cell.promuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake([WKVideoTableViewCell widthForLabel:cell.promuButton.currentTitle ]+20, 25));
    }];
    if (self.isApproal ) {
        [cell.promuButton setHidden:YES];
    }
    else{
        [cell.promuButton setHidden:NO];
    }
    [cell.promuButton addTarget:self action:@selector(goingApprovalAction:) forControlEvents:UIControlEventTouchUpInside];
    switch (model.approvalStatus.intValue) {
        case 1:
            cell.stateLabel.text = @"待审核";
            break;
        case 2:
            cell.stateLabel.text = @"已发布";
            break;
        case 3:
            cell.stateLabel.text = @"审核不通过";
            break;
        case 4:
            cell.stateLabel.text = @"待发布";
            break;

        default:
            break;
    }
    return cell;

}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
     return self.videolist.count;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoModel *new= self.videolist[indexPath.section];
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
    player.myNumber =2;
       [self presentViewController:player animated:YES completion:nil];
     // [self.navigationController pushViewController:player animated:YES];
    }
    

}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50+(SCREEN_WIDTH-233)*0.56;
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

-(void)selctedVideo:(UIButton*) button{
    // NSLog(@"button.select= %d",button.selected);
    if (button.selected) {
        [self.arrnumber addObject:[NSNumber numberWithInteger:button.tag]];
    }
    else{
        [self.arrnumber removeObject:[NSNumber numberWithInteger:button.tag]];
    }
    
}

-(void)getNotApprovalVideo:(UIButton*)sender{
    //self.iscomment = YES;
    self.isApproal = NO;
    self.roleHeadView.deleteView.hidden =NO;
    if (self.roleHeadView.localButton.selected) {
        self.roleHeadView.localButton.selected = self.roleHeadView.localButton.selected;
        
        
    }
    else{
        self.roleHeadView.localButton .selected = !self.roleHeadView.localButton.selected;
        self.outside.selected  = !self.roleHeadView.localButton.selected;
        //self.isOutLink = NO;
       [self initData];
    }
    
}
-(void)getApprovalVideo:(id)sender{
    //self.iscomment = NO;
    self.isApproal = YES;
     self.roleHeadView.deleteView.hidden = YES;
      if (self.outside.selected) {
        self.outside.selected = self.outside.selected;
        
    }
    else{
        self.outside.selected  = !self.outside.selected;
        self.roleHeadView.localButton.selected =!self.outside.selected;
        //self.isOutLink = YES;
        
       [self initDataTwo];
    }
}
-(void)goingApprovalAction:(UIButton*)sender{
    
    WKApprovalingViewController *set = [[WKApprovalingViewController alloc]init];
    set.videoModel = self.videolist[sender.tag];
    set.isMore =0;
[self.navigationController pushViewController:set animated:YES];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [textField resignFirstResponder];
    if (textField ==self.search) {
        if (self.isApproal) {
            [self initDataTwo];
        }
        else{
        [self initData];
        }
    }
    return YES;
}
-(void)moreApprovalTapGesture:(id)sender{
    WKApprovalingViewController *set = [[WKApprovalingViewController alloc]init];
    set.videoarr = [NSMutableArray array];
    set.isMore =1;
    for (int i=0; i<self.arrnumber.count; i++) {
        WKVideoModel *model = self.videolist[[self.arrnumber[i]integerValue]];
        [set.videoarr addObject:model];
        
    }
    
    [self.navigationController pushViewController:set animated:YES];
    [self.arrnumber removeAllObjects];
    for (int i=0; i<self.videolist.count; i++) {
        [self.videoTableview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES];
        
    }
    [self.videoTableview reloadData];

}
-(void)loadmore{
    if (self.isApproal) {
        self.twoPage+=1;
        NSDictionary *dic =@{@"page":[NSNumber numberWithInteger:self.twoPage],@"token": TOKEN,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
        //[self.videolist removeAllObjects];
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageApprovaledVideoWithParameter:dic success:^(id object) {
                // NSLog(@"object  = %@",object);
                for (WKVideoModel *model  in object) {
                    [weakself.videolist addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.videoTableview reloadData];
                    [weakself.videoTableview.mj_footer endRefreshing];
                });
            } failed:^(id object) {
                // NSLog(@"nserroer= %@",object);
            }];
            
        });

    }
    else{
        self.onePage+=1;
        NSDictionary *dic =@{@"page":[NSNumber numberWithBool:self.onePage],@"token": TOKEN,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
       
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageNotApprovalVideoWithParameter:dic success:^(id object) {
          
                for (WKVideoModel *model  in object) {
                    [weakself.videolist addObject:model];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.videoTableview reloadData];
                    [weakself.videoTableview.mj_footer endRefreshing];
                });
            } failed:^(id object) {
                
            }];
            
        });
        

    }
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
