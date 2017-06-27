//
//  WKRolesViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/8.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKRolesViewController.h"
#import "WKRoleTableViewCell.h"
#import "WKHeadview.h"
#import "WKBackstage.h"
#import "WKRolesModel.h"
#import "WKRoleBindOnViewController.h"
#import "WKRoleView.h"
#import "WKAuthorizeViewController.h"
@interface WKRolesViewController ()<UITableViewDelegate,UITableViewDataSource,RolesDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate>
@property(strong,nonatomic)UITableView *rolestableView;
@property(strong,nonatomic)WKHeadview *headView;
@property(strong,nonatomic)WKRoleView *roleHeadView;
@property(assign,nonatomic)CGFloat heightcontent;
@property (strong,nonatomic)NSMutableArray *arrcontent;
@property(strong,nonatomic)MBProgressHUD *hud;
@property (strong,nonatomic) NSMutableArray *arrnumber;
@property (assign ,nonatomic)NSInteger page;
@end

@implementation WKRolesViewController

-(NSMutableArray*)arrcontent{
    if (!_arrcontent) {
        _arrcontent = [NSMutableArray array];
    }
    return _arrcontent;
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
    [self.roleHeadView.localButton setHidden:YES];
//    self.roleHeadView.roleLable.font = [UIFont fontWithName:FONT_BOLD size:17];
//    self.roleHeadView.addLable.font = [UIFont fontWithName:FONT_REGULAR size:9];
//    self.
//    roleHeadView.deleteLable.font =[UIFont fontWithName:FONT_REGULAR size:9];
//    self.roleHeadView.roleLable.textColor = [WKColor colorWithHexString:GREEN_COLOR];
//    self.roleHeadView.addLable.textColor = [WKColor colorWithHexString:@"666666"];
//    self.roleHeadView.deleteLable.textColor = [WKColor colorWithHexString:@"666666"];
    [self.roleHeadView .backButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteTapGesture:)];
    tap.numberOfTapsRequired = 1 ;
    [self.roleHeadView.deleteView addGestureRecognizer:tap];
    [self.roleHeadView.addView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.roleHeadView];
    self.rolestableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 114, SCREEN_WIDTH-20, SCREEN_HEIGHT-114) style:UITableViewStylePlain];
    self.rolestableView.delegate = self;
    self.rolestableView.dataSource = self;
    self.rolestableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
      self.rolestableView.showsVerticalScrollIndicator = NO;
    [self.rolestableView registerNib:[UINib nibWithNibName:@"WKRoleTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
    self.rolestableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
     self.rolestableView.mj_footer.automaticallyChangeAlpha=YES;
    //self.rolestableView.sectionIndexBackgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self.view addSubview:self.rolestableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
}

-(void)initdata{
    self.page = 1;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"search":self.search.text};
    __weak typeof(self) weakself = self;
    [self.arrcontent removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageAllorSearchWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRolesModel *roles in object ) {
                [weakself.arrcontent addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                    [weakself.rolestableView reloadData];

               
                //[weakself.rolestableView reloadData];
            });
        } failed:^(id object) {
            
        }];

    });
    }
- (void)viewDidLoad {
    [super viewDidLoad];
    self.search.placeholder = @"搜索相关角色";
    self.navigationItem.hidesBackButton = YES;
    self.search.delegate = self;
    self.search.returnKeyType = UIReturnKeySearch;
    [self.cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    [self ClickOnTheBlankspace];
    //[self initdata];
    
//    self.navigationController.navigationBar.barTintColor = [WKColor colorWithHexString:WHITE_COLOR];
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self initdata];
}
#pragma mark - Uitableviewdatasourse
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (!self.arrcontent.count ) {
        return 1;
    }
    return self.arrcontent.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.arrcontent.count) {
        WKRoleTableViewCell *cell = [[WKRoleTableViewCell alloc]init];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WKRoleTableViewCell" owner:nil options:nil]lastObject];
//        if (self.integer == indexPath.section) {
//            cell.selectButton.selected =YES;
//        }
        for (int i= 0; i<self.arrnumber.count; i++) {
            if ([self.arrnumber[i]integerValue]==indexPath.section) {
                cell.selectButton.selected = YES;
            }
            
        }
        cell.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
        cell.delegate = self;
        //cell.contentView.translatesAutoresizingMaskIntoConstraints = NO;
        WKRolesModel *role =self.arrcontent[indexPath.section];
        cell.contentLabel.text =role.remark;
        cell.deleteButton.tag = indexPath.section;
        cell.editButton.tag = indexPath.section;
        cell.selectButton.tag = indexPath.section;
        cell.bindButton.tag = indexPath.section;
        cell.authorizeButton.tag = indexPath.section;
       // NSLog(@"cell_tag =%lu",cell.deleteButton.tag);
        self.heightcontent = [WKRoleTableViewCell heightForLabel:
                              cell.contentLabel.text];
        cell.roleName.text =role.roleName;
        cell.levelLabel.text = [NSString stringWithFormat:@"%lu",role.priority];
        cell.contentLabel.translatesAutoresizingMaskIntoConstraints = YES;
        cell.contentLabel.frame = CGRectMake(10, 44, SCREEN_WIDTH-40, self.heightcontent);
        //NSLog(@"..%f",cell.contentLabel.frame.size.height);
        [cell.authorizeButton addTarget:self action:@selector(authorizeAction:) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }
    static NSString *cellid = @"NUllcell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellid];
    }
    cell.textLabel.text = @"未找到匹配角色!";
    cell.textLabel.textColor = [UIColor redColor];
    cell.textLabel.font = [UIFont fontWithName:FONT_BOLD size:17];
    return cell;
    
}
#pragma mark - Uitableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return 0;
    }
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//     NSLog(@"..%f...",self.heightcontent);
    return 99+self.heightcontent;
}
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    //NSLog(@"111");
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
#pragma mark - Rolestableviewdelegate
-(void)ChangeRoles:(UIButton *)button{
   //NSLog(@"t...%lu",button.tag) ;
    WKRolesModel *role = self.arrcontent[button.tag];
    [self.hud showAnimated:YES];
    NSLog(@"role.id =%lu",role.id);
    __weak typeof(self) weakself = self;
   
        NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:role.id]};
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageDeleteWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"删除成功";
                    weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                    //[weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself.arrcontent removeObjectAtIndex:button.tag];
                    [weakself.rolestableView reloadData];

                    });
                
            } failed:^(id object) {
                NSLog(@"err= %@",object);
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"删除失败";
                    weakself.hud.label.textColor = [UIColor redColor];
                });
                
            }];
        });
        [self.hud hideAnimated:YES afterDelay:1];
    

 
    }
-(void)ChangeRolesImformation:(UIButton *)button{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WKRolesEditViewController *edit = [main instantiateViewControllerWithIdentifier:@"RolesEditView"];
    edit.number = 2;
    edit.roleModel = self.arrcontent[button.tag];
    [self.navigationController pushViewController:edit animated:YES];

}
-(void)changeBatchDelete:(UIButton *)button {
    if (button.selected) {
       [self.arrnumber addObject:[NSNumber numberWithInteger:button.tag]];
    }
    else{
        [self.arrnumber removeObject:[NSNumber numberWithInteger:button.tag]];
    }
}

#pragma mark - Action
-(void)authorizeAction:(UIButton*)sender{
    
    WKAuthorizeViewController *auth = [[WKAuthorizeViewController alloc]init];
    auth.model = self.arrcontent[sender.tag];
    [self.navigationController pushViewController:auth animated:YES];
}
-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
    
}
-(void)cancelSearch{
    [self.view endEditing:YES];
    [self.search resignFirstResponder];
}
-(void)tapGesture:(UITapGestureRecognizer*)tap{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WKRolesEditViewController *edit = [main instantiateViewControllerWithIdentifier:@"RolesEditView"];
    edit.number = 1;
//    WKRolesEditViewController *edit = [[WKRolesEditViewController alloc]init];
    [self.navigationController pushViewController:edit animated:YES];
  }

-(void)deleteTapGesture:(UITapGestureRecognizer *)tap{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量删除角色" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteaction];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];
}
-(void)deleteaction{
    NSString *cellid =@"0";
    for (int i=0; i<self.arrnumber.count; i++) {
        WKRolesModel *model = self.arrcontent[[self.arrnumber[i]integerValue]];
        cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
    }

    __weak typeof(self) weakself = self;
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"ids":cellid};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageDeleteMoreWithParameter:dic success:^(id object) {
           
            
            
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud.label.text = @"删除成功";
                    weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                    
                  [weakself initdata];
                [weakself.arrnumber removeAllObjects];
                });
              
            
        } failed:^(id object) {
            NSLog(@"err= %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"删除失败";
                weakself.hud.label.textColor = [UIColor redColor];
            });
            
        }];
    });
    [self.hud hideAnimated:YES afterDelay:1];
}
-(void)BindUser:(UIButton *)button{
    WKRoleBindOnViewController *roleon = [[WKRoleBindOnViewController alloc]init];
     roleon.model = self.arrcontent[button.tag];

    [self.navigationController pushViewController:roleon animated:YES];
   
}
-(void)loadmore{
    self.page +=1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"search":self.search.text};
    __weak typeof(self) weakself = self;
    //[self.arrcontent removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageAllorSearchWithParameter:dic success:^(id object) {
            if (object == nil) {
                //NSLog(@"13333");
            }
            for (WKRolesModel *roles in object ) {
                [weakself.arrcontent addObject:roles];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [weakself.rolestableView reloadData];
                [weakself.rolestableView.mj_footer endRefreshing];
                
                //[weakself.rolestableView reloadData];
            });
        } failed:^(id object) {
            
        }];
        
    });

}
#pragma mark - 屏蔽键盘
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    //    [self.navigationItem.titleView resignFirstResponder];
    //[self.search endEditing:YES];
    [textField resignFirstResponder];
    if (textField == self.search) {
        [self initdata];
    }
    NSLog(@"123");
    return YES;
    
}//Click on the blank space
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
    singletap.delegate =self;
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
    //    [self.view endEditing:YES];
    [self.search endEditing: YES];
}
#pragma mark - 屏蔽手势事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}

//-(void)comeback:(NSString *)string{
//    [self.arrcontent addObject:string];
//    [self.rolestableView reloadData];
//}

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
