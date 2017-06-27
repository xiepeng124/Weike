//
//  WKAuthorizeViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/26.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKAuthorizeViewController.h"
#import "WKBackstage.h"
#import "WKAuthorizeTableViewCell.h"
@interface WKAuthorizeViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong ,nonatomic) UITableView *myTabelView;
@property (strong,nonatomic) NSMutableArray *arrlist;
@property (strong,nonatomic) NSMutableArray *arrNumber;
@property (strong,nonatomic) MBProgressHUD *hud;
@end

@implementation WKAuthorizeViewController
#pragma mark - init(初始化)
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray*)arrNumber{
    if (!_arrNumber) {
        _arrNumber = [NSMutableArray array];
    }
    return _arrNumber;
}
-(void)initTableView{
    self.myTabelView = [[UITableView alloc]initWithFrame:CGRectMake(10, 10, SCREEN_WIDTH-20, SCREEN_HEIGHT-10) style:UITableViewStylePlain];
    self.myTabelView.dataSource = self;
    self.myTabelView.delegate = self;
    self.myTabelView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.myTabelView.showsVerticalScrollIndicator = NO;
    //self.myTabelView.scrollEnabled = NO;
    self.myTabelView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self.myTabelView registerNib:[UINib nibWithNibName:@"WKAuthorizeTableViewCell" bundle:nil] forCellReuseIdentifier:@"myCell"];
    [self.view addSubview:self.myTabelView];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeCustomView;
    [self.view addSubview:self.hud];

        //self.myTabelView
}
-(void)initData{
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.model.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleAuthorWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKRoleAuthorModel *model in object) {
                    [weakself.arrlist addObject:model];
                }
                [weakself.myTabelView reloadData];
            });
        } failed:^(id object) {
            
        }];

    });
    
}
#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initTableView];
    [self initData];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton.title = @"完成";
    rightButton.tintColor = [WKColor colorWithHexString:DARK_COLOR];
    [rightButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:16]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;

    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.arrlist.count) {
        return self.arrlist.count;
    }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKAuthorizeTableViewCell *cell = (WKAuthorizeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"myCell" forIndexPath:indexPath];
    cell.selectedButton.tag = indexPath.row;
    for (int i=0; i<self.arrNumber.count; i++) {
        if ([self.arrNumber[i] integerValue] ==indexPath.row) {
            cell.selectedButton.selected = YES;
        }
    }
    [cell.selectedButton addTarget:self action:@selector(selectedAuthorAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrlist.count) {
        WKRoleAuthorModel *model = self.arrlist[indexPath.row];
        cell.menuLabel.text = model.menuName;
        return cell;
    }
    return cell;
}
-(void)selectRightAction:(UIBarButtonItem*)item{
    NSString *cellid ;
    for (int i=0; i<self.arrNumber.count; i++) {
        WKVideoModel *model = self.arrlist[[self.arrNumber[i] integerValue]];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }
        
    }
    self.hud.label.text =@"正在保存";
     [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.model.id],@"loginUserId":LOGINUSERID,@"menuIds":cellid};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleAuthorKeepWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakSelf.hud.label.text = [object objectForKey:@"msg"];
                [weakSelf.hud hideAnimated:YES afterDelay:1];
                if ([[object objectForKey:@"flag"]integerValue]) {
                    [weakSelf.navigationController popViewControllerAnimated:YES];
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
-(void)selectedAuthorAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.arrNumber addObject:[NSNumber numberWithInteger:sender.tag]];
    }
    else{
        [self.arrNumber removeObject :[NSNumber numberWithInteger:sender.tag]];

    }
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
