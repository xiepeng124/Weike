//
//  WKBelongsRoleTableViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBelongsRoleTableViewController.h"
#import "WKBelongRoleTableViewCell.h"
@interface WKBelongsRoleTableViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) NSMutableArray *arrList;
@property (strong,nonatomic) UIButton *keepButton;
@property (assign,nonatomic)NSInteger remarkHeight;
@property (assign,nonatomic) NSInteger page;
@property (strong,nonatomic) MBProgressHUD *hud;
@property (strong,nonatomic) UITableView *tableView;
@property (strong,nonatomic) NSMutableArray *arrNumber;
@property (strong,nonatomic) UIButton *leftbutton;
@end

@implementation WKBelongsRoleTableViewController
#pragma mark - init
-(NSMutableArray*)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}
-(NSMutableArray*)arrNumber{
    if (!_arrNumber) {
        _arrNumber = [NSMutableArray array];
    }
    return _arrNumber;
}
-(void)initStyle{
    self.keepButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _keepButton.frame = CGRectMake(0, SCREEN_HEIGHT-50, SCREEN_WIDTH, 50);
    [self. keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.keepButton setTitle:@"提 交" forState: UIControlStateNormal];
    [self.keepButton addTarget:self action:@selector(keepBelongRoleAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_keepButton];
    _leftbutton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 20)];
    [_leftbutton setImage:[UIImage imageNamed:@"teacher_select_off"] forState:UIControlStateNormal];
     [_leftbutton setImage:[UIImage imageNamed:@"teacher_select_on"] forState:UIControlStateSelected];
    //[leftbutton setBackgroundColor:[UIColor blackColor]];
    _leftbutton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:9];
    [_leftbutton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
//    [leftbutton setImageEdgeInsets:UIEdgeInsetsMake(10, 0, -10, 0)];
   [_leftbutton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, -2)];
    [_leftbutton setTitle:@"全部选择" forState:UIControlStateNormal];
    [_leftbutton setTitle:@"取消全选" forState:UIControlStateSelected];
    [_leftbutton addTarget:self action:@selector(allRoleSelectedAction) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightitem=[[UIBarButtonItem alloc]initWithCustomView:_leftbutton];
    
    self.navigationItem.rightBarButtonItem=rightitem;
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode =  MBProgressHUDModeIndeterminate;
    [self.hud sizeToFit];
    [self.view addSubview:self.hud];

    

}
-(void)initData{
    self.page = 1;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"userId":[NSNumber numberWithInteger:_model.id]};
    [self.arrList removeAllObjects];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserRoleSetWithParameter:dic success:^(id object) {
            for (WKRolesModel *model in object) {
                [weakself.arrList addObject:model];
            }
            [weakself.tableView reloadData];
        } failed:^(id object) {
            
        }];
    });
}
#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-20, self.view.frame.size.height-50) style:UITableViewStylePlain];
//    self.tableView.frame = CGRectMake(10, 0, SCREEN_WIDTH-20, self.view.frame.size.height-50);
    self.tableView.separatorStyle =  UITableViewCellSeparatorStyleNone;
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.tableView.mj_footer.automaticallyChangeAlpha = YES;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.view addSubview:self.tableView];
   [self initStyle];
    [self initData];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    if (self.arrList.count) {
        return self.arrList.count;
    }
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WKBelongRoleTableViewCell *cell =[[WKBelongRoleTableViewCell alloc]init];
    cell= [[[NSBundle mainBundle]loadNibNamed:@"WKBelongRoleTableViewCell" owner:nil options:nil]lastObject];
    cell.selectedButton.tag = indexPath.section;
    if (self.arrList.count) {
        for (int i=0; i<self.arrNumber.count; i++) {
            if (indexPath.section == [self.arrNumber[i]  integerValue]) {
                cell.selectedButton.selected = YES;
            }
        }
        WKRolesModel *model = self.arrList[indexPath.section];
        cell.roleName.text =model.roleName;
        cell.priortyLabel.text = [NSString stringWithFormat:@"优先级：%lu", model.priority];
        cell.remarkLabel.text = [NSString stringWithFormat:@"备注：%@",  model.remark];
        self.remarkHeight = [WKBelongRoleTableViewCell heightForLabel:cell.remarkLabel.text];
        cell.remarkLabel.frame = CGRectMake(10, 46, SCREEN_WIDTH-40, self.remarkHeight);
        if (model.isSelect) {
            cell.selectedButton.selected = YES;
            if (![self.arrNumber containsObject:[NSNumber numberWithInteger:indexPath.section] ]) {
                [self.arrNumber addObject:[NSNumber numberWithInteger:indexPath.section]];
            }
        }
        [cell.selectedButton addTarget:self action:@selector(bindRoleAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }
      return cell;
}
#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView*)view;
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
        return self.remarkHeight+56;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#pragma mark - Action
-(void)bindRoleAction:(UIButton *)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        WKRolesModel *model = self.arrList[sender.tag];
        model.isSelect = YES;
        self.arrList[sender.tag] = model;
        [self.arrNumber addObject:[NSNumber numberWithInteger:sender.tag]];
    }
    else{
        WKRolesModel *model = self.arrList[sender.tag];
        model.isSelect = NO;
        self.arrList[sender.tag] = model;
        [self.arrNumber removeObject:[NSNumber numberWithInteger:sender.tag]];
    }
}
-(void)allRoleSelectedAction{
    self.leftbutton.selected = !self.leftbutton.selected;
    if (self.leftbutton.selected) {
        NSMutableArray *arr = [NSMutableArray array];
      for (WKRolesModel *model in _arrList) {
          model.isSelect = YES;
          [arr addObject:model];
        }
        self.arrList = [arr mutableCopy];
        for (int i=0; i<self.arrList.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            WKBelongRoleTableViewCell *cell = (WKBelongRoleTableViewCell*) [self.tableView cellForRowAtIndexPath:index];
    
            if (![self.arrNumber containsObject:[NSNumber numberWithInteger:i]]) {
                [self.arrNumber addObject:[NSNumber numberWithInteger:i]];
                cell.selectedButton.selected = YES;
            }
        }
        
    }
    else{
       
            NSMutableArray *arr = [NSMutableArray array];
            for (WKRolesModel *model in _arrList) {
                model.isSelect = NO;
                [arr addObject:model];
            }
            
            self.arrList = [arr mutableCopy];
        for (int i=0; i<self.arrList.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            WKBelongRoleTableViewCell *cell = (WKBelongRoleTableViewCell*) [self.tableView cellForRowAtIndexPath:index];
            cell.selectedButton.selected = NO;
            [self.arrNumber removeAllObjects];
    }

    }
}
-(void)keepBelongRoleAction{
    if (!self.arrNumber.count) {
        self.hud.label.text = @"请选择至少一个角色";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
     NSString *cellid ;
    for (int i=0; i<self.arrNumber.count; i++) {
        WKRolesModel *model = self.arrList[[self.arrNumber[i]integerValue]];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }
    }
    self.hud.label.text = @"正在提交";
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"ids":cellid,@"userId":[NSNumber numberWithInteger:_model.id],@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserRoleUpWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = [object objectForKey:@"msg"];
                [weakself.hud hideAnimated:YES afterDelay:1];
                if ([object objectForKey:@"flag"]) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
            });
        } failed:^(id object) {
            
        }];
    });
}
#pragma mark - MJRefresh
-(void)loadmore{
    self.page +=1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"userId":[NSNumber numberWithInteger:_model.id]};
 
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserRoleSetWithParameter:dic success:^(id object) {
            for (WKRolesModel *model in object) {
                [weakself.arrList addObject:model];
            }
            [weakself.tableView reloadData];
            [weakself.tableView.mj_footer endRefreshing];
        } failed:^(id object) {
            
        }];
    });

}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
