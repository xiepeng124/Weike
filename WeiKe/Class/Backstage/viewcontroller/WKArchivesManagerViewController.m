//
//  WKArchivesManagerViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/29.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKArchivesManagerViewController.h"
#import "WKHeadview.h"
#import "WKArchivesTeacherTableViewCell.h"
#import "WKArchivesStuTableViewCell.h"
#import "WKBackstage.h"
#import "WKTeachImforEditViewController.h"
#import "WKStuImforEditViewController.h"
#import "WKArchivesTeacherAddViewController.h"
#import "WKArchivesStuAddViewController.h"
@interface WKArchivesManagerViewController ()<UITextFieldDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) WKHeadview *archivesHeadView;
@property(strong,nonatomic)UIButton *stuButton;
@property (strong ,nonatomic) UITableView *archTableView;
@property (strong,nonatomic) MBProgressHUD *hud;
@property (assign ,nonatomic) BOOL isTeacher;
@property (strong ,nonatomic) NSMutableArray *arrList;
@property (strong ,nonatomic) NSMutableArray *arrNumber;
@property (assign ,nonatomic) NSInteger page;
@end

@implementation WKArchivesManagerViewController
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
    NSArray *arrlist = [[NSBundle mainBundle]loadNibNamed:@"Headview" owner:nil options:nil];
    self.archivesHeadView = [[WKHeadview alloc]init];
   
    self.archivesHeadView  = [arrlist lastObject];
    self.archivesHeadView.frame = CGRectMake(0, 64, SCREEN_WIDTH, 44);
    [self.archivesHeadView.localButton setHidden:NO];
    self.archivesHeadView.roleLable.hidden = YES;
    [self.archivesHeadView.localButton setTitle:@"教师" forState:  UIControlStateNormal];
    self.archivesHeadView.localButton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:17];
    [self.archivesHeadView.localButton addTarget:self action:@selector(getTeachArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
    self.stuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.stuButton.frame = CGRectMake(150, 0, 70, 44);
    self.stuButton.titleLabel.font = [UIFont fontWithName:FONT_BOLD size:17];
    [self.stuButton setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    [ self.stuButton  setTitleColor:[WKColor colorWithHexString:GREEN_COLOR] forState:UIControlStateSelected];
    [self.stuButton addTarget:self action:@selector(getStuArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.stuButton setTitle:@"学生" forState:  UIControlStateNormal];
    [self.archivesHeadView addSubview:self.stuButton];
    self.archivesHeadView.localButton.selected = YES;
    self.stuButton.selected = NO;
    self.archivesHeadView.onvideoImage .image = [UIImage imageNamed:@"file_add"];
    self.archivesHeadView.addLable.text = @"添加档案";
     UITapGestureRecognizer *addTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(addArchivesAction)];
    [self.archivesHeadView.addView addGestureRecognizer:addTap];
    UITapGestureRecognizer *deleteTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreArchivesDeleteAction)];
    
    [self.archivesHeadView.deleteView addGestureRecognizer:deleteTap];
    [self.view addSubview:self.archivesHeadView];
    [self.archivesHeadView.backButton addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];

}
-(void)initTabeView{
    self.archTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 108, SCREEN_WIDTH-20, SCREEN_HEIGHT-108) style:UITableViewStylePlain];
    _archTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _archTableView.showsVerticalScrollIndicator = NO;
   _archTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _archTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    _archTableView.delegate =self;
    _archTableView.dataSource = self;
    _archTableView.mj_header=[MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadfresh)];
    _archTableView.mj_header.automaticallyChangeAlpha=YES;
    
    _archTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadmore)];
    _archTableView.mj_footer.automaticallyChangeAlpha=YES;
    [self.view addSubview:_archTableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = self.view.center;
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.hud sizeToFit];
    [self.view addSubview:self.hud];

}
-(void)initData{
    self.page = 1;
    [self.arrList removeAllObjects];
    __weak typeof(self) weakself = self;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    if (_isTeacher) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKTeacherData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                      [weakself.arrNumber removeAllObjects];
                    [weakself.archTableView reloadData];
                  
                });
            } failed:^(id object) {
                
            }];
        });
    }
    else{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageArchivesStuWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                for (WKStudentData *model in object) {
                    [weakself.arrList addObject:model];
                }
                 [weakself.arrNumber removeAllObjects];
                [weakself.archTableView reloadData];
                
            });
        } failed:^(id object) {
            
        }];
    });
}
}
 #pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.hidesBackButton = YES;
    self.search.placeholder =@"搜索教师/学生";
    self.search.delegate = self;
    self.isTeacher = YES;
    [self initStyle];
    [self initTabeView];
    [self initData];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (_isTeacher) {
        WKArchivesTeacherTableViewCell *cell = [[WKArchivesTeacherTableViewCell alloc]init];
        cell = [[[NSBundle mainBundle]loadNibNamed:@"WKArchivesTeacherTableViewCell" owner:nil options:nil]lastObject];
        cell.selectedButton.tag = indexPath.section;
        cell.editButton.tag = indexPath.section;
        cell.detailButton.tag = indexPath.section;
        cell.deleteButton.tag = indexPath.section;
        if ([self.arrNumber containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
            cell.selectedButton.selected = YES;
        }
        [cell.selectedButton addTarget:self action:@selector(selectedUserArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.deleteButton addTarget:self action:@selector(deleteArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
        [cell.detailButton addTarget:self action:@selector(detailArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
          [cell.editButton addTarget:self action:@selector(editArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
        if (self.arrList.count) {
            WKTeacherData *model =  self.arrList[indexPath.section];
            cell.teaName.text = model.teacherName;
            switch (model.gender) {
                case 1:
                    cell.sexLabel.text = [NSString stringWithFormat:@"性别：男"];
                    break;
                case 2:
                    cell.sexLabel.text = [NSString stringWithFormat:@"性别：女"];
                    break;

                default:
                    break;
            }
            cell.roleLabel.text = [NSString stringWithFormat:@"职务：%@",model.posStr];
            cell.acount.text = [NSString stringWithFormat:@"帐号(手机号)：%@",model.moblePhone];
            return cell;
        }
        return cell;

    }
    WKArchivesStuTableViewCell *cell = [[WKArchivesStuTableViewCell alloc]init];
      cell = [[[NSBundle mainBundle]loadNibNamed:@"WKArchivesStuTableViewCell" owner:nil options:nil]lastObject];
    cell.selectedButton.tag = indexPath.section;
    cell.editButton.tag = indexPath.section;
    cell.detailButton.tag = indexPath.section;
    cell.deleteButton.tag = indexPath.section;
    if ([self.arrNumber containsObject:[NSNumber numberWithInteger:indexPath.section]]) {
        cell.selectedButton.selected = YES;
    }
    [cell.selectedButton addTarget:self action:@selector(selectedUserArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
       [cell.deleteButton addTarget:self action:@selector(deleteArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
           [cell.detailButton addTarget:self action:@selector(detailArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editButton addTarget:self action:@selector(editArchivesAction:) forControlEvents:UIControlEventTouchUpInside];
    if (self.arrList.count) {
        WKStudentData *model =  self.arrList[indexPath.section];
        cell.stuName.text = model.studentName;
        switch (model.gender) {
            case 1:
                cell.sexLabel.text = [NSString stringWithFormat:@"性别：男"];
                break;
            case 2:
                cell.sexLabel.text = [NSString stringWithFormat:@"性别：女"];
                break;
                
            default:
                break;
        }
      
     
        cell.classLabel.text = [NSString stringWithFormat:@"班级：%@", model.className];
        cell.gradeLabel.text = [NSString stringWithFormat:@"年级：%@",  model.gradeName];
        return cell;
    }
    return cell;

   //    for (int i=0; i<self.arrNumber.count; i++) {
//        if (indexPath.section == [self.arrNumber[i] integerValue]) {
//            cell.selectedButton.selected = YES;
//        }
//    return nil;

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
    if (self.isTeacher) {
        return 146;
    }
    return 121;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
 #pragma mark - Action
//教师档案列表
-(void)getTeachArchivesAction:(UIButton*)sender{
    self.isTeacher = YES;
    if (sender.selected) {
        
    }
    else{
        [self.arrNumber removeAllObjects];
        sender.selected = YES;
        self.stuButton.selected = NO;
        [self initData];
    }
}
//学生档案列表
-(void)getStuArchivesAction:(UIButton*)sender{
    self.isTeacher = NO;
    if (sender.selected) {
        
    }
    else{
         [self.arrNumber removeAllObjects];
        sender.selected = YES;
        self.archivesHeadView.localButton.selected = NO;
        [self initData];
    }

}
//选择
-(void)selectedUserArchivesAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    if (sender.selected) {
        [self.arrNumber addObject:[NSNumber numberWithInteger:sender.tag]];
    }
    else{
        [self.arrNumber removeObject:[NSNumber numberWithInteger:sender.tag]];

    }
}
//单个删除
-(void)deleteArchivesAction:(UIButton*)sender{
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定删除此档案" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self deleteOneArchives:sender.tag];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];

}
-(void)deleteOneArchives:(NSInteger)tag{
    if (self.isTeacher) {
        WKTeacherData *model = self.arrList[tag];
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"ids":[NSNumber numberWithInteger:model.id]};
        __weak typeof(self) weakself = self;
        self.hud.label.text = @"正在删除";
        self.hud.mode = MBProgressHUDModeIndeterminate;
        [self.hud showAnimated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachDeleteWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud .label.text = [object objectForKey:@"msg"];
                    weakself.hud.mode =MBProgressHUDModeText;
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    if ([[object objectForKey:@"flag"]integerValue]) {
                        [weakself initData];
                    }
                });
            } failed:^(id object) {
                
            }];
        });
    }
    else{
        WKStudentData *model = self.arrList[tag];
        NSDictionary *dic = @{@"schoolId":SCOOLID,@"ids":[NSNumber numberWithInteger:model.id]};
        __weak typeof(self) weakself = self;
        self.hud.label.text = @"正在删除";
        self.hud.mode = MBProgressHUDModeIndeterminate;
        [self.hud showAnimated:YES];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuDeleteWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud .label.text = [object objectForKey:@"msg"];
                    weakself.hud.mode =MBProgressHUDModeText;
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    if ([[object objectForKey:@"flag"]integerValue]) {
                        [weakself initData];
                    }
                });
            } failed:^(id object) {
                
            }];
        });

    }
    
}
//批量删除
-(void)moreArchivesDeleteAction{
    if (self.arrNumber.count<2) {
        self.hud.label.text = @"请选中两个及以上档案";
        [self.hud showAnimated:YES];
        [self.hud hideAnimated:YES afterDelay:1];
        return;
    }
    NSDictionary *dic;
    if (self.isTeacher) {
        NSString *cellid ;
        for (int i=0; i<self.arrNumber.count; i++) {
            WKTeacherData *model = self.arrList[[self.arrNumber[i]integerValue]];
            if (i==0) {
                cellid = [NSString stringWithFormat:@"%lu",model.id];
            }
            else{
                cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
            }
        }
        dic = @{@"schoolId":SCOOLID,@"ids":cellid};

    }
    else{
         NSString *cellid ;
        for (int i=0; i<self.arrNumber.count; i++) {
            WKStudentData *model = self.arrList[[self.arrNumber[i]integerValue]];
            if (i==0) {
                cellid = [NSString stringWithFormat:@"%lu",model.id];
            }
            else{
                cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
            }
        }
        dic = @{@"schoolId":SCOOLID,@"ids":cellid};

    }
    UIAlertController *alertcontrller = [UIAlertController alertControllerWithTitle:@"你确定批量删除档案" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    UIAlertAction *sure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self moreArchivesDelete:dic];
    }];
    [alertcontrller addAction:cancel];
    [alertcontrller addAction:sure];
    [self presentViewController:alertcontrller animated:YES completion:^{
        
    }];

    
}
-(void)moreArchivesDelete:(NSDictionary*)dic{
    __weak typeof(self) weakself = self;
    self.hud.label.text = @"正在删除";
    self.hud.mode = MBProgressHUDModeIndeterminate;
    [self.hud showAnimated:YES];
    if (self.isTeacher) {
       
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachDeleteWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud .label.text = [object objectForKey:@"msg"];
                    weakself.hud.mode =MBProgressHUDModeText;
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    if ([[object objectForKey:@"flag"]integerValue]) {
                        [weakself initData];
                    }
                });
            } failed:^(id object) {
                
            }];
        });
    }
    else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuDeleteWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    weakself.hud .label.text = [object objectForKey:@"msg"];
                    weakself.hud.mode =MBProgressHUDModeText;
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    if ([[object objectForKey:@"flag"]integerValue]) {
                        [weakself initData];
                    }
                });
            } failed:^(id object) {
                
            }];
        });
        
    }

    
}
//添加档案
-(void)addArchivesAction{
    if (self.isTeacher) {
        WKArchivesTeacherAddViewController *teaAdd = [[WKArchivesTeacherAddViewController alloc]init];
        teaAdd.isAdd = YES;
        [self.navigationController pushViewController:teaAdd animated:YES];
    }
    else{
        WKArchivesStuAddViewController *stuAdd = [[WKArchivesStuAddViewController alloc]init];
        stuAdd.isAdd = YES;
        [self.navigationController pushViewController:stuAdd animated:YES];
    }
}
//详情
-(void)detailArchivesAction:(UIButton*)sender{
    if (self.isTeacher) {
        WKTeachImforEditViewController *teach = [[WKTeachImforEditViewController alloc]init];
        WKTeacherData *model = self.arrList[sender.tag];
        teach.myId = model.id;
        teach.isDetail = YES;
        [self.navigationController pushViewController:teach animated:YES];
        
    }
    else{
        WKStuImforEditViewController *stu = [[WKStuImforEditViewController alloc]init];
        WKStudentData *model = self.arrList[sender.tag];
        stu.model = model;
        stu.isDetail = YES;
        [self.navigationController pushViewController:stu animated:YES];
    }
    
}
-(void)editArchivesAction:(UIButton*)sender{
    if (self.isTeacher) {
        WKArchivesTeacherAddViewController *teaAdd = [[WKArchivesTeacherAddViewController alloc]init];
        teaAdd.isAdd = NO;
        teaAdd.model = self.arrList[sender.tag];
        [self.navigationController pushViewController:teaAdd animated:YES];
    }
}
//返回
-(void)backAction{
    [self.navigationController popViewControllerAnimated:YES];
}
 #pragma mark - MJRefresh
-(void)loadfresh{
    self.page = 1;
    [self.arrList removeAllObjects];
    __weak typeof(self) weakself = self;
    NSDictionary *dic = @{@"page":@1,@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    if (_isTeacher) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKTeacherData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                      [weakself.arrNumber removeAllObjects];
                    [weakself.archTableView reloadData];
                  
                    [weakself.archTableView.mj_header endRefreshing];
                });
            } failed:^(id object) {
                
            }];
        });
    }
    else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKStudentData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                     [weakself.arrNumber removeAllObjects];
                    [weakself.archTableView reloadData];
                   
                     [weakself.archTableView.mj_header endRefreshing];
                });
            } failed:^(id object) {
                
            }];
        });
    }
}
-(void)loadmore{
    self.page +=1;
    __weak typeof(self) weakself = self;
    NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"searchMsg":self.search.text};
    if (_isTeacher) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesTeachWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKTeacherData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                    [weakself.archTableView reloadData];
                    [weakself.archTableView.mj_footer endRefreshing];
                });
            } failed:^(id object) {
                
            }];
        });
    }
    else{
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageArchivesStuWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    for (WKStudentData *model in object) {
                        [weakself.arrList addObject:model];
                    }
                    [weakself.archTableView reloadData];
                      [weakself.archTableView.mj_footer endRefreshing];
                });
            } failed:^(id object) {
                
            }];
        });
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
