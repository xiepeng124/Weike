//
//  WKUserManagerViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUserManagerViewController.h"
#import "WKHeadview.h"
#import "WKBackstage.h"
#import "WKUserManagerTableViewCell.h"
#import "WKEditUserTableViewController.h"
@interface WKUserManagerViewController ()<UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong,nonatomic) WKHeadview *myHeadView;
@property (strong,nonatomic)UIButton *teachButton;
@property (strong,nonatomic)UIButton *stuButton;
@property (strong,nonatomic)UIButton *stopButton;
@property (strong,nonatomic)UIButton *AllselectButton;
@property (strong,nonatomic) UITableView *mytableView;
@property (strong,nonatomic) NSMutableArray *arrList;
@property (strong,nonatomic) NSMutableArray *arrNumber;
@property (assign,nonatomic) NSInteger queryType;
@property (assign,nonatomic) NSInteger page;
@property (strong ,nonatomic) MBProgressHUD *hud;
@end

@implementation WKUserManagerViewController
#pragma mark - init (初始化)
-(NSMutableArray*)arrList{
    if (!_arrList) {
        _arrList =  [NSMutableArray array];
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
    self.myHeadView = [[WKHeadview alloc]init];
    self.myHeadView = [[[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil]lastObject];
    self.myHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.myHeadView.localButton setHidden:YES];
    self.myHeadView.roleLable.hidden = YES;
    self.teachButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.teachButton.frame = CGRectMake(44, 0, 56, 44);
    self.teachButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [self.teachButton setTitle:@"教师" forState: UIControlStateNormal];
    [self.teachButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    [self.teachButton setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected ];
    self.teachButton.selected =YES;
    [self.myHeadView addSubview:_teachButton];
    self.stuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stuButton.frame = CGRectMake(100, 0, 56, 44);
    [self.stuButton setTitle:@"学生" forState: UIControlStateNormal];
    self.stuButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [self.stuButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    [self.stuButton setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected ];
    [self.myHeadView addSubview:_stuButton];
     self.stopButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stopButton.frame = CGRectMake(156, 0, 72, 44);
    self.stopButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [self.stopButton setTitle:@"已禁用" forState: UIControlStateNormal];
    [self.stopButton setTitleColor:[WKColor colorWithHexString:DARK_COLOR] forState:UIControlStateNormal];
    [self.stopButton setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected ];
    [self.myHeadView addSubview:_stopButton];
    self.myHeadView.onvideoImage.hidden = YES;
    self.myHeadView.addLable.text =@"全部选择";
    self.AllselectButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.AllselectButton.frame = CGRectMake(0, 0, 40, 23);
    self.AllselectButton.contentVerticalAlignment = UIControlContentVerticalAlignmentBottom;
    [self.AllselectButton setImage:[UIImage imageNamed:@"teacher_select_off"] forState:UIControlStateNormal];
    [self.AllselectButton setImage:[UIImage imageNamed:@"teacher_select_on"] forState:UIControlStateSelected];
    [self.AllselectButton addTarget:self action:@selector(allSeletedUserAction) forControlEvents:UIControlEventTouchUpInside];
     UITapGestureRecognizer *oneTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(allSeletedUserAction)];
    [self.myHeadView.addView addGestureRecognizer:oneTap];
    [self.myHeadView.addView addSubview:self.AllselectButton];
    self.myHeadView.rightImage.image = [UIImage imageNamed:@"forbid"];
    UITapGestureRecognizer *twoTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreUserAction)];
    [self.myHeadView.deleteView addGestureRecognizer:twoTap];
    self.myHeadView.userInteractionEnabled = YES;
    self.myHeadView.deleteLable.text = @"批量禁用";
    [self.view addSubview:self.myHeadView];
    [self.teachButton addTarget:self action:@selector(searchTeacherUserAction) forControlEvents:UIControlEventTouchUpInside];
      [self.stuButton addTarget:self action:@selector(searchStudentUserAction) forControlEvents:UIControlEventTouchUpInside];
       [self.stopButton addTarget:self action:@selector(searchForbidUserAction) forControlEvents:UIControlEventTouchUpInside];
      [self.myHeadView.backButton addTarget:self action:@selector(backUserManagerAction) forControlEvents:UIControlEventTouchUpInside];
}
-(void)initTableView{
    self.mytableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 108, SCREEN_WIDTH-20, SCREEN_HEIGHT-108) style:UITableViewStylePlain];
    self.mytableView.showsVerticalScrollIndicator =NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    _mytableView.delegate =self;
    _mytableView.dataSource = self;
    _mytableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadfresh)];
    _mytableView.mj_header.automaticallyChangeAlpha=YES;

    _mytableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    _mytableView.mj_footer.automaticallyChangeAlpha=YES;

    [self.view addSubview:_mytableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.hud sizeToFit];
    [self.view addSubview:self.hud];

}
-(void)initData{
    self.page = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"searchMsg":self.search.text,@"queryType":[NSNumber numberWithInteger:self.queryType]};
    __weak typeof(self) weakself= self;
    [self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKBackstage executeGetBackstageUserListWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKUserListModel *model in object) {
                    [weakself.arrList addObject:model];
                    
                }
                [weakself.arrNumber removeAllObjects];
                [weakself.mytableView reloadData];

            });
        } failed:^(id object) {
            
        }];
    });
}
#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    self.page = 1;
    self.queryType =1;
    [self initStyle];
    [self initTableView];
    [self initData];
    self.navigationItem.hidesBackButton = YES;
    self.search.placeholder = @"搜索教师／学生";
    self.search.delegate = self;
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKUserManagerTableViewCell *cell = [[WKUserManagerTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKUserManagerTableViewCell" owner:nil options:nil]lastObject];
    cell.selectedButton.tag = indexPath.section;
    cell.forbidbutton.tag = indexPath.section;
    cell.editButton.tag = indexPath.section;
    [cell.selectedButton addTarget:self action:@selector(selectedUserAction:) forControlEvents:UIControlEventTouchUpInside];
    for (int i=0; i<self.arrNumber.count; i++) {
        if (indexPath.section == [self.arrNumber[i] integerValue]) {
            cell.selectedButton.selected = YES;
        }
    }
    if (self.arrList.count) {
        WKUserListModel *model = self.arrList[indexPath.section];
        if (self.queryType ==1) {
            cell.titleName.text = model.teacherName;
            cell.accountLabel.text = [NSString stringWithFormat:@"帐号(手机号)：%@", model.moblePhone];
            cell.secondLabel.text = [NSString stringWithFormat:@"身份证号：%@",     model.idCode];
            [cell.forbidbutton addTarget:self action:@selector(forbidUserAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.editButton setTitle:@"编辑" forState: UIControlStateNormal ];
            [cell.forbidbutton setHidden:NO];
             [cell.editButton addTarget:self action:@selector(editUserAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.secondH.constant= 25;
            return cell;
        }
      else  if (self.queryType==2) {
            cell.titleName.text = model.studentName;
            cell.accountLabel.text = [NSString stringWithFormat:@"帐号(身份证号)：%@", model.idCode];
            cell.secondLabel.text = [NSString stringWithFormat:@"手机号：%@",  model.moblePhone]   ;
            [cell.forbidbutton addTarget:self action:@selector(forbidUserAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.editButton setTitle:@"编辑" forState: UIControlStateNormal ];
            [cell.forbidbutton setHidden:NO];
            [cell.editButton addTarget:self action:@selector(editUserAction:) forControlEvents:UIControlEventTouchUpInside];
          cell.secondH.constant= 25;
            return cell;

        }
        else{
            if (model.teacherName.length) {
                cell.titleName.text = model.teacherName;
                cell.accountLabel.text = [NSString stringWithFormat:@"帐号(手机号/身份证号)：%@", model.moblePhone];

            }
         else{
                cell.titleName.text = model.studentName;
             cell.accountLabel.text = [NSString stringWithFormat:@"帐号(手机号/身份证号)：%@", model.idCode];

            }
         
        [cell.editButton setTitle:@"启用" forState: UIControlStateNormal ];
        [cell.forbidbutton setHidden:YES];
        [cell.editButton addTarget:self action:@selector(startUserAction:) forControlEvents:UIControlEventTouchUpInside];
            cell.secondH.constant= 0;
        return cell;
        }
    }
    return nil;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrList.count) {
        return self.arrList.count;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView*)view;
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.queryType == 3) {
        return 110;
    }
    return 135;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
#pragma mark - UITextFieldDelegate
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    [self initData];
    return YES;
}
#pragma mark - Action
// 返回上一级
-(void)backUserManagerAction{
    [self.navigationController popViewControllerAnimated:YES];
}
//教师列表
-(void)searchTeacherUserAction{
     self.myHeadView.rightImage.image = [UIImage imageNamed:@"forbid"];
     self.myHeadView.deleteLable.text = @"批量禁用";
    self.queryType = 1;
    if (self.teachButton.selected) {
        
    }
    else{
        self.teachButton.selected = YES;
        self.stuButton.selected = NO;
        self.stopButton.selected = NO;
        [self initData];
        self.AllselectButton.selected = NO;
    }
    
}
//学生列表
-(void)searchStudentUserAction{
     self.myHeadView.rightImage.image = [UIImage imageNamed:@"forbid"];
    self.myHeadView.deleteLable.text = @"批量禁用";
    self.queryType = 2;
    if (self.stuButton.selected) {
    }
    else{
        self.stuButton.selected = YES;
        self.teachButton.selected = NO;
        self.stopButton.selected = NO;
        [self initData];
         self.AllselectButton.selected = NO;
    }
}
//禁用列表
-(void)searchForbidUserAction{
     self.myHeadView.rightImage.image = [UIImage imageNamed:@"start-using"];
    self.queryType = 3;
      self.myHeadView.deleteLable.text = @"批量启用";
    if (self.stopButton.selected) {
    }
    else{
        self.stopButton.selected = YES;
        self.teachButton.selected = NO;
        self.stuButton.selected = NO;
        [self initData];
         self.AllselectButton.selected = NO;
    }
}
//全部选择
-(void)allSeletedUserAction{
    self.AllselectButton.selected = !self.AllselectButton.selected;
    if (self.AllselectButton.selected) {
        for (int i=0; i<self.arrList.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            WKUserManagerTableViewCell *cell = (WKUserManagerTableViewCell*)[self.mytableView cellForRowAtIndexPath:index];
            cell.selectedButton.selected = YES;
            if (! [self.arrNumber containsObject:[NSNumber numberWithInt:i]]) {
                [self.arrNumber addObject:[NSNumber numberWithInt:i]];
            }
        }
    }
    else{
        for (int i=0; i<self.arrList.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:0 inSection:i];
            WKUserManagerTableViewCell *cell = (WKUserManagerTableViewCell*)[self.mytableView cellForRowAtIndexPath:index];
            cell.selectedButton.selected = NO;
            
        }
        [self.arrNumber removeAllObjects];
    }
}
//禁用
-(void)forbidUserAction:(UIButton*)sender{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定禁用此用户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self forbidUser:sender.tag];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];

  }
-(void)forbidUser:(NSInteger)tag{
    WKUserListModel *model = self.arrList[tag];
    NSDictionary *dic = @{@"ids":[NSNumber numberWithInteger: model.id]};
    __weak typeof(self) weakself =self;
    self.hud.label.text =@"正在禁用";
    [self.hud showAnimated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserForbidWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]integerValue]) {
                    [weakself initData];
                }
                weakself.hud.label.text = [object objectForKey:@"msg"];
                
                [weakself.hud hideAnimated:YES afterDelay:1];
            });
        } failed:^(id object) {
            
        }];
        //[WKBackstage executeGetBackstage]
    });

}
//启用
-(void)startUserAction:(UIButton*)sender{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定启用此用户" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self startUser:sender.tag];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];
 

}
-(void)startUser:(NSInteger)tag{
    WKUserListModel *model = self.arrList[tag];
    NSDictionary *dic = @{@"ids":[NSNumber numberWithInteger: model.id]};
    __weak typeof(self) weakself =self;
    self.hud.label.text =@"正在启用";
    [self.hud showAnimated:YES];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserStartWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]integerValue]) {
                    [weakself initData];
                }
                weakself.hud.label.text = [object objectForKey:@"msg"];
                
                [weakself.hud hideAnimated:YES afterDelay:1];
            });
        } failed:^(id object) {
            
        }];
        //[WKBackstage executeGetBackstage]
    });

}
//批量禁用和启用
-(void)moreUserAction{
    if (self.arrNumber.count<2) {
        self.hud.label.text = @"请选中两个及以上用户";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    NSString *cellid ;
    for (int i=0; i<self.arrNumber.count; i++) {
        WKUserListModel *model = self.arrList[[self.arrNumber[i]integerValue]];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }
    }
    NSDictionary *dic = @{@"ids":cellid};
   

    if (self.queryType == 3) {
        UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量启用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self moreFobidUser:dic];
        }];
        [alertcontrller addAction:cancel];
        [alertcontrller addAction:sure];
        [self presentViewController:alertcontrller animated:YES completion:^{
            
        }];

       
    }
    else{
        UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量禁用" message:nil preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
            
        }];
        UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            [self moreFobidUser:dic];
        }];
        [alertcontrller addAction:cancel];
        [alertcontrller addAction:sure];
        [self presentViewController:alertcontrller animated:YES completion:^{
            
        }];

    }
}
-(void)moreFobidUser:(NSDictionary *)dic{
    self.hud.label.text =@"正在批量启用";
    [self.hud showAnimated:YES];
          __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserStartWithParameter:dic success:^(id object) {
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
-(void)moreStartUser:(NSDictionary*)dic{
    
    self.hud.label.text =@"正在批量禁用";
    [self.hud showAnimated:YES];
    __weak typeof(self) weakself =self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageUserForbidWithParameter:dic success:^(id object) {
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
//编辑用户
-(void)editUserAction:(UIButton*)sender{
    WKEditUserTableViewController *edit = [[WKEditUserTableViewController alloc]init];
    edit.model = self.arrList[sender.tag];
    edit.queryType = self.queryType;
    [self.navigationController pushViewController:edit animated:YES];
}
//选择用户
-(void)selectedUserAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.arrNumber addObject:[NSNumber numberWithInteger:sender.tag]];
    }
    else{
        [self.arrNumber removeObject:[NSNumber numberWithInteger:sender.tag]];
    }
}
#pragma mark - 加载更多
-(void)loadfresh{
    self.page = 1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"searchMsg":self.search.text,@"queryType":[NSNumber numberWithInteger:self.queryType]};
    __weak typeof(self) weakself= self;
    [self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKBackstage executeGetBackstageUserListWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKUserListModel *model in object) {
                    [weakself.arrList addObject:model];
                    
                }
                [weakself.arrNumber removeAllObjects];
                [weakself.mytableView reloadData];
                [weakself.mytableView.mj_header endRefreshing];
                
            });
        } failed:^(id object) {
            
        }];
    });

}
-(void)loadmore{
    self.page +=1;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"searchMsg":self.search.text,@"queryType":[NSNumber numberWithInteger:self.queryType]};
    __weak typeof(self) weakself= self;
    //[self.arrList removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKBackstage executeGetBackstageUserListWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKUserListModel *model in object) {
                    [weakself.arrList addObject:model];
                    
                }
               // [weakself.arrNumber removeAllObjects];
                [weakself.mytableView reloadData];
                [weakself.mytableView.mj_footer endRefreshing];
                
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
