//
//  WKRoleBindAddViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRoleBindAddViewController.h"
#import "WKBindOnView.h"
#import "WKRoleBindTableViewCell.h"
#import "WKBackstage.h"

@interface WKRoleBindAddViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource,RolesBindDelegate>
@property (nonatomic,strong) WKBindOnView * bindview;
@property(nonatomic,strong)UITableView *usertableView;
@property(nonatomic,strong)MBProgressHUD *hud;
@property(nonatomic,strong)NSMutableArray *arrlist;
@property(nonatomic,strong)NSMutableArray *arrnumber;
@property (nonatomic,assign) NSInteger page;
@end

@implementation WKRoleBindAddViewController
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
        NSArray *arrlist = [[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil];
          self. bindview = [arrlist lastObject];
        self. bindview.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
        self. bindview.deleteLable.text = @"批量绑定";
    self.bindview.rightImage.image = [UIImage imageNamed:@"role__binding"];
    [self.bindview.localButton setHidden:YES];
    [self.bindview.backButton addTarget:self action:@selector(gobackpop) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreBindUser:)];
    tap.numberOfTouchesRequired = 1;
    [self.bindview.deleteView addGestureRecognizer:tap];
     self.bindview.addView.hidden =YES;
    self.bindview.roleLable.text = @"添加绑定";
    
    [self.view addSubview:self. bindview];

    

}
-(void)initTableview{
    self.usertableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 108, SCREEN_WIDTH-20, SCREEN_HEIGHT-108) style:UITableViewStylePlain];
    [self.usertableView registerNib:[UINib nibWithNibName:@"WKRoleBindTableViewCell" bundle:nil] forCellReuseIdentifier:@"myUnbindcell"];
    self.usertableView.delegate = self;
    self.usertableView.dataSource = self;
    self.usertableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.usertableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.usertableView.showsVerticalScrollIndicator = NO;
    self.usertableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    self.usertableView.mj_footer.automaticallyChangeAlpha = YES;
    [self.view addSubview:self.usertableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
}
-(void)initdata{
    self.page = 1;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"search":self.search.text,@"roleId":[NSNumber numberWithInteger:self.rolemodel.id]};
    __weak typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleNoBindWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRoleBindUser *roles in object ) {
                [weakself.arrlist addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself.usertableView reloadData];
                
                
                //[weakself.rolestableView reloadData];
            });
        } failed:^(id object) {
            
        }];
        
    });

}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索用户";
    self.navigationItem.hidesBackButton = YES;
    self.search.delegate = self;
    self.search.returnKeyType = UIReturnKeySearch;
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self.cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    [self initStyle];
    [self initTableview];
    [self initdata];
    [ self ClickOnTheBlankspace];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1 ;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    NSLog(@"self .arr.count = %lu",self.arrlist.count);
    return self.arrlist.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKRoleBindTableViewCell *cell = [[WKRoleBindTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKRoleBindTableViewCell" owner:nil options:nil]lastObject];
//    WKRoleBindTableViewCell *cell = (WKRoleBindTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"myUnbindcell" forIndexPath:indexPath];
    WKRoleBindUser *role = self.arrlist[indexPath.section];
    for (int i= 0; i<self.arrnumber.count; i++) {
        if ([self.arrnumber[i]integerValue]==indexPath.section) {
            cell.selectButton.selected = YES;
        }
         }

    [cell.unBind setTitle:@"绑定" forState:UIControlStateNormal ];
    cell.roleName.text = role.teacherName;
    cell.unBind.tag = indexPath.section;
    cell.phoneNumber.text = [NSString stringWithFormat:@"账号(手机号)：%@" ,role.moblePhone ];
    cell.cellid.text = [NSString stringWithFormat:@"身份证号：%@" ,role.idCode ];
    cell.emailid.text = [NSString stringWithFormat:@"邮箱号码：%@" ,role.email];
   // cell.unBind.tag = indexPath.section;
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
    NSLog(@"role.id =%lu",role.id);
    __weak typeof(self) weakself = self;
    
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.rolemodel.id],@"loginUserId":LOGINUSERID,@"userIds":[NSString stringWithFormat:@"%lu",role.id]};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleAddBindWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"绑定成功";
                weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                //[weakself.hud hideAnimated:YES afterDelay:1];
                // [weakself.arrlist removeObjectAtIndex:button.tag];
                
                [weakself initdata];
                
            });
            
        } failed:^(id object) {
            NSLog(@"err= %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"绑定失败";
                weakself.hud.label.textColor = [UIColor redColor];
            });
            
        }];
    });
    [self.hud hideAnimated:YES afterDelay:1];

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
        self.hud.label.text = @"请选择需绑定用户";
        self.hud.label.textColor = [UIColor redColor];
        [self.hud hideAnimated:YES afterDelay:1];
        
    }
    else{
        UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量绑定绑用户" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
           [self moreBind];
        }];
        [alertcontrller addAction:cancel];
        [alertcontrller addAction:sure];
        [self presentViewController:alertcontrller animated:YES completion:^{
            
        }];
    }
}
-(void)moreBind{
    
        NSString *cellid =@"0";
        for (int i=0; i<self.arrnumber.count; i++) {
            WKRoleBindUser *model = self.arrlist[[self.arrnumber[i]integerValue]];
                       cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
           // NSLog(@"riid = %@",cellid);
        }

    [self.hud showAnimated:YES];
    NSLog(@"role.id =%@",cellid);
    __weak typeof(self) weakself = self;
    
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"roleId":[NSNumber numberWithInteger:self.rolemodel.id],@"loginUserId":LOGINUSERID,@"userIds":cellid};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleAddBindWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"批量绑定成功";
                weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                //[weakself.hud hideAnimated:YES afterDelay:1];
                // [weakself.arrlist removeObjectAtIndex:button.tag];
                [weakself.arrnumber removeAllObjects];
                [weakself initdata];
                
            });
            
        } failed:^(id object) {
            NSLog(@"err= %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"批量绑定失败";
                weakself.hud.label.textColor = [UIColor redColor];
            });
            
        }];
    });
    [self.hud hideAnimated:YES afterDelay:1];

}
-(void)gobackpop{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)cancelSearch{
    [self.view endEditing:YES];
    [self.search resignFirstResponder];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    [self.navigationItem.titleView resignFirstResponder];
    //[self.search endEditing:YES];
    [textField resignFirstResponder];
    if (textField == self.search) {
        [self initdata];
    }
    NSLog(@"123");
    return YES;
    
}
-(void)loadmore{
    self.page += 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"search":self.search.text,@"roleId":[NSNumber numberWithInteger:self.rolemodel.id]};
    __weak typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageRoleNoBindWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRoleBindUser *roles in object ) {
                [weakself.arrlist addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself.usertableView reloadData];
                [weakself.usertableView.mj_footer endRefreshing];
 
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
