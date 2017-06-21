//
//  WKRoleBindOnViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRoleBindOnViewController.h"

#import "WKRoleBindTableViewCell.h"
#import "WKBackstage.h"
#import "WKRoleBindAddViewController.h"
@interface WKRoleBindOnViewController ()<UITableViewDelegate,UITableViewDataSource,RolesBindDelegate>

@property(nonatomic,strong)UITableView *roleBindTableView;
@property(nonatomic,strong)NSMutableArray *arrlist;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)NSMutableArray *arrnumber;
@property (nonatomic,assign) NSInteger page;
@end

@implementation WKRoleBindOnViewController
-(NSMutableArray*)arrnumber{
    if (!_arrnumber) {
        _arrnumber  = [NSMutableArray array];
    }
    return _arrnumber;
}
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(void)initStyle{
    
    UIImageView *img1= [[UIImageView alloc]initWithFrame:CGRectMake(11, 0, 16, 16)];
    img1.image = [UIImage imageNamed:@"role_add-binding"];
    img1.contentMode =  UIViewContentModeScaleAspectFit;
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 38, 10)];
    label1 .text = @"添加绑定";
    label1 .font = [UIFont fontWithName:FONT_REGULAR size:9];
    label1.textColor = [WKColor colorWithHexString:@"666666"];
    UIButton *button1  = [UIButton buttonWithType:UIButtonTypeCustom];
    button1.frame = CGRectMake(0, 0, 40, 40);
    [button1 addSubview:img1];
    [button1 addSubview:label1];
    [button1 addTarget:self action:@selector(gobindUser:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithCustomView:button1];
    //rightButton1.image=[UIImage imageNamed:@"home_search"];
    UIImageView *img2= [[UIImageView alloc]initWithFrame:CGRectMake(11, 0, 16, 16)];
    img2.image = [UIImage imageNamed:@"role_remove-binding"];
    img2.contentMode =  UIViewContentModeScaleAspectFit;
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(0, 20, 38, 10)];
    label2 .text = @"批量解绑";
    label2.font = [UIFont fontWithName:FONT_REGULAR size:9];
    label2.textColor = [WKColor colorWithHexString:@"666666"];
    UIButton *button2  = [UIButton buttonWithType:UIButtonTypeCustom];
    button2.frame = CGRectMake(0, 0, 40, 40);
    [button2 addSubview:img2];
    [button2 addSubview:label2];
    [button2 addTarget:self action:@selector(moreBindUser:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc]initWithCustomView:button2];
    self.navigationItem.rightBarButtonItems = @[rightButton2,rightButton1];
    self.navigationItem.title =@"已绑定用户";
//    [[UINavigationBar appearance]setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
//                                                        [
//                                                        WKColor colorWithHexString:@"333333"], NSForegroundColorAttributeName,
//                                                        shadow, NSShadowAttributeName,
//                                                        [UIFont fontWithName:FONT_REGULAR size:17.0], NSFontAttributeName, nil,nil]];
      }
-(void)initTableView{
    self.roleBindTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 64, SCREEN_WIDTH-20, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    [self.roleBindTableView registerNib:[UINib nibWithNibName:@"WKRoleBindTableViewCell" bundle:nil] forCellReuseIdentifier:@"mybindcell"];
    self.roleBindTableView.delegate = self;
    self.roleBindTableView.dataSource = self;
    self.roleBindTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.roleBindTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
      self.roleBindTableView.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.roleBindTableView];
    self.roleBindTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.roleBindTableView.mj_footer.automaticallyChangeAlpha = YES;
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];

    
}
-(void)initdata{
    self.page = 1;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.model.id]};
    NSLog(@"id = %lu", self.model.id);
    __weak  typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleBindWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRoleBindUser *roles in object ) {
                [weakself.arrlist addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself.roleBindTableView reloadData];
                
                
                //[weakself.rolestableView reloadData];
            });
        } failed:^(id object) {
            
        }];
        
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    [self initTableView];
   // [self initdata];
    self.automaticallyAdjustsScrollViewInsets=NO;
     // bindview.addView.hidden = YES;

    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKRoleBindTableViewCell *cell = [[WKRoleBindTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKRoleBindTableViewCell" owner:nil options:nil]lastObject];

//    WKRoleBindTableViewCell *cell = (WKRoleBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"mybindcell" forIndexPath:indexPath];
    WKRoleBindUser *role = self.arrlist[indexPath.section];
   
    cell.roleName.text = role.name;
    for (int i= 0; i<self.arrnumber.count; i++) {
        if ([self.arrnumber[i]integerValue]==indexPath.section) {
            cell.selectButton.selected = YES;
        }
//        else{
//            cell.selectButton.selected = NO;
//
//        }
    }

    cell.phoneNumber.text = [NSString stringWithFormat:@"账号(手机号)：%@" ,role.moblePhone ];
    cell.cellid.text = [NSString stringWithFormat:@"身份证号：%@" ,role.idCode ];
       cell.emailid.text = [NSString stringWithFormat:@"邮箱号码：%@" ,role.email];
    cell.unBind.tag = indexPath.section;
    cell.selectButton.tag = indexPath.section;
    cell.delegate = self;
    return  cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 122;
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
-(void)unBindUser:(UIButton *)button{
    WKRoleBindUser *role = self.arrlist[button.tag];
    [self.hud showAnimated:YES];
    NSLog(@"role.id =%lu",role.rsId);
    __weak typeof(self) weakself = self;
    //[self.arrlist removeAllObjects];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:role.rsId]};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleDeleteBindWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"解绑成功";
                weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                //[weakself.hud hideAnimated:YES afterDelay:1];
               // [weakself.arrlist removeObjectAtIndex:button.tag];
               
                [weakself initdata];
                
            });
            
        } failed:^(id object) {
            NSLog(@"err= %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"解绑失败";
                weakself.hud.label.textColor = [UIColor redColor];
            });
            
        }];
    });
    [self.hud hideAnimated:YES afterDelay:1];
}
-(void)gobindUser:(id)sender{
    WKRoleBindAddViewController *bindadd = [[WKRoleBindAddViewController alloc]init];
    bindadd .rolemodel = self.model;
    [self.navigationController pushViewController:bindadd animated:YES];
}
-(void)changeBindOrUn:(UIButton *)button{
    if (button.selected) {
        [self.arrnumber addObject:[NSNumber numberWithInteger:button.tag]];
    }
    else{
        [self.arrnumber removeObject:[NSNumber numberWithInteger:button.tag]];
    }

}
-(void)moreBindUser:(UIButton*)button{
    if (!self.arrnumber.count) {
        [self.hud showAnimated:YES];
        self.hud.label.text = @"请选择需解绑用户";
        self.hud.label.textColor = [UIColor redColor];
        [self.hud hideAnimated:YES afterDelay:1];
        
    }
    else{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量解绑用户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
       [self unMoreBind];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];
    }
}
-(void)unMoreBind{
    NSString *cellid =@"0";
    for (int i=0; i<self.arrnumber.count; i++) {
        WKRoleBindUser *model = self.arrlist[[self.arrnumber[i]integerValue]];
        //        NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection: [self.arrnumber[i] integerValue] ];
        //        WKRoleTableViewCell *cell = [self.rolestableView cellForRowAtIndexPath:index];
        cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.rsId];
        NSLog(@"riid = %@",cellid);
    }
        __weak typeof(self) weakself = self;
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"ids":cellid};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleUnMoreBindWithParameter:dic success:^(id object) {
          //  NSLog(@"object .....=%@",object);
            
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"批量解绑成功";
                weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                //[weakself.hud hideAnimated:YES afterDelay:1];
                [weakself initdata];
                [weakself.arrnumber removeAllObjects];
            });
            
            
            
            
            
            
            
            
        } failed:^(id object) {
            NSLog(@"err= %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"批量解绑失败";
                weakself.hud.label.textColor = [UIColor redColor];
            });
            
        }];
    });
    [self.hud hideAnimated:YES afterDelay:1];
}
-(void)addBindAction:(id)sender{
    
}

-(void)deleteBindAction:(id)sender{
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self initdata];
}

-(void)loadmore{
    self.page += 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.model.id]};
    NSLog(@"id = %lu", self.model.id);
    __weak  typeof(self) weakself = self;
   
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleBindWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRoleBindUser *roles in object ) {
                [weakself.arrlist addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself.roleBindTableView reloadData];
                [weakself.roleBindTableView.mj_footer endRefreshing];
                
                //[weakself.rolestableView reloadData];
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
