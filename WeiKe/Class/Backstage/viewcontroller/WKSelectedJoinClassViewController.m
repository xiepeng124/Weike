//
//  WKSelectedJoinClassViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/27.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSelectedJoinClassViewController.h"

#import "WKJobClass.h"
#import "WKJobSelectClassTableViewCell.h"
#import "UIButton+WKIndexpath.h"
@interface WKSelectedJoinClassViewController ()<UITableViewDelegate,UITableViewDataSource,FoldSectionHeaderViewDelegate>
@property (strong ,nonatomic) NSString *classIds;
@property (strong,nonatomic) NSMutableArray *arrlist;
@property (strong ,nonatomic)UITableView *mytableView;
@property (strong,nonatomic)UILabel *allJobLabel;
@property (strong,nonatomic) WKJobClass *jobClass;
@property (assign,nonatomic) NSInteger section;
@property (assign,nonatomic)BOOL isSpread;
@property (assign,nonatomic)CGFloat height;
@property (strong ,nonatomic)NSMutableArray *arrsection;
@property (strong ,nonatomic)NSMutableArray *arrClass;
@property (strong ,nonatomic)NSMutableArray *arrGrade;
@property (assign ,nonatomic)NSInteger indexsection;
@property (strong ,nonatomic)UIButton *allButton;
@property (strong,nonatomic) NSMutableArray *arrbackClass;
@property (strong,nonatomic)NSMutableArray *arrbackgrade;
@property (strong ,nonatomic) MBProgressHUD *hud;
@end

@implementation WKSelectedJoinClassViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray*)arrsection{
    if (!_arrsection) {
        _arrsection = [NSMutableArray array];
    }
    return _arrsection;
}
-(NSMutableArray*)arrClass{
    if (!_arrClass) {
        _arrClass = [NSMutableArray array];
    }
    return _arrClass;
}
-(NSMutableArray*)arrGrade{
    if (!_arrGrade) {
        _arrGrade = [NSMutableArray array];
    }
    return _arrGrade;
}
-(NSMutableArray*)arrbackClass{
    if (!_arrbackClass) {
        _arrbackClass = [NSMutableArray array];
    }
    return _arrbackClass;
}
-(NSMutableArray*)arrbackgrade{
    if (!_arrbackgrade) {
        _arrbackgrade = [NSMutableArray array];
    }
    return _arrbackgrade;
}


-(void)initTableView{
    UIView *allJobView = [[UIView alloc]initWithFrame:CGRectMake(10,74 , SCREEN_WIDTH-20, 32)];
    allJobView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    allJobView.layer.cornerRadius = 3;
  _allButton= [UIButton buttonWithType:UIButtonTypeCustom];
    _allButton.frame = CGRectMake(10, 10, 17, 17);
    [_allButton setBackgroundImage:[UIImage imageNamed:@"role_off"] forState:UIControlStateNormal];
    [_allButton setBackgroundImage:[UIImage imageNamed:@"role_on"] forState:UIControlStateSelected];
    [_allButton addTarget:self action:@selector(selectedAllAction:) forControlEvents:UIControlEventTouchUpInside];
    _allJobLabel = [[UILabel alloc]initWithFrame:CGRectMake(32, 4, 200, 28)];
    _allJobLabel.font = [UIFont fontWithName:FONT_REGULAR size:16];
    _allJobLabel.textColor = [WKColor colorWithHexString:@"333333"];
    _allJobLabel.text = @"全部作业";
    allJobView.layer.cornerRadius = 3;
    allJobView.layer.masksToBounds = YES;
    [allJobView addSubview:_allButton];
    [allJobView addSubview:_allJobLabel];
    [self.view addSubview:allJobView];

    self.mytableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 116, SCREEN_WIDTH-20, SCREEN_HEIGHT-116) style:UITableViewStylePlain];
    self.mytableView.delegate = self;
    self.mytableView.dataSource = self;
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.layer.cornerRadius = 3;
    self.mytableView.layer.masksToBounds = YES;
    //[self.jobTableView registerNib:[UINib nibWithNibName:@"WKJobTableViewCell" bundle:nil] forCellReuseIdentifier:@"mycell"];
//    self.mytableView.tableHeaderView = allJobView;
    self.mytableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.view addSubview:self.mytableView];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];

}
-(void)initData{
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"classIds":self.classIds};
    __weak typeof(self) weakself = self;
    [self.arrlist removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageSelectedJobClassWithParameter:dic success:^(id object) {
            for (WKJobGradeModel *model in object) {
                weakself.allJobLabel.text = model.schoolName;
                [weakself.arrlist addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.mytableView reloadData];
            });
        } failed:^(id object) {
            
        }];
        
    });
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.classIds = @"";
    self.isSpread = NO;
    [self initTableView];
    [self initData];
      UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    [rightButton setTitle:@"完成"];
    self.navigationItem.rightBarButtonItem = rightButton;
//    [self.arrGrade addObserver:self forKeyPath:@"count" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld  context:nil];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        WKJobGradeModel *model = self.arrlist[section];
        
    for (int i= 0; i<self.arrsection.count; i++) {
        if (section==[self.arrsection[i]integerValue]) {
            return model.classMap.count;

        }
        
          }
    return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKJobSelectClassTableViewCell *cell = [[WKJobSelectClassTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKJobSelectClassTableViewCell" owner:nil options:nil]lastObject];
    WKJobGradeModel *grade = self.arrlist[indexPath.section];
    NSArray *arr = [WKJObClassModel mj_objectArrayWithKeyValuesArray:grade.classMap];
    WKJObClassModel *classmodel = arr[indexPath.row];
    cell.classlabel.text = classmodel.className;
    self.indexsection = indexPath.section;
    [cell.selectedButton addTarget:self action:@selector(selectedClassAction:) forControlEvents:UIControlEventTouchUpInside];
//    if (_allButton.selected) {
//        cell.selectedButton.selected = YES;
//
//    }
//    else{
//         cell.selectedButton.selected = NO;
//    }
    for (int i=0; i<self.arrClass.count; i++) {
        if (indexPath.row ==[self.arrClass[i][0]integerValue]&&indexPath.section == [self.arrClass[i][1]integerValue]) {
            cell.selectedButton.selected = YES;
            
            
        }
       
    }
    NSLog(@"indexpath  =%@",indexPath);
    cell.selectedButton.indexpath =indexPath;
    cell.selectedButton.tag= indexPath.row;
    
    return cell;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return self.arrlist.count;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    self.jobClass = [[WKJobClass alloc]initWithFrame:CGRectMake(0, 10, screenH, 37)];
     self.jobClass= [[[NSBundle mainBundle]loadNibNamed:@"ClassHeadView" owner:nil options:nil]lastObject];
    self.jobClass.backgroundColor = [UIColor whiteColor];
    WKJobGradeModel *model = self.arrlist[section];
    self.jobClass.gradeLabel.text = model.gradeName;
    self.jobClass.updownButton.tag = section;
    self.jobClass.selectButton.tag  =section;
//    if (_allButton.selected) {
//        self.jobClass.selectButton.selected = YES;
//    }
//    else{
//        self.jobClass.selectButton.selected = NO;
//
//    }
    for (int i = 0; i<self.arrsection.count; i++) {
        if ([self.arrsection[i]integerValue]==section) {
            self.jobClass.updownButton.selected = YES;
            self.isSpread =YES;
        }
    }
    for (int i = 0; i<self.arrGrade.count; i++) {
        if ([self.arrGrade[i]integerValue]==section) {
            self.jobClass.selectButton.selected = YES;
            self.isSpread =YES;
        }
    }
   
    self.jobClass.delegate = self;
    return self.jobClass;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"333666");
//    if (self.isSpread&&self.section ==indexPath.section) {
        return 36;
//    }
//    return 0;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 37;
}

-(void)selectedClassAction:(UIButton*)sender{
    sender.selected = !sender.selected;
    NSArray *array = @[[NSNumber numberWithInteger:sender.tag],[NSNumber numberWithInteger:self.indexsection]];
    if (sender.selected) {
        [self.arrClass addObject:array];
    }
    else{
        [self.arrClass removeObject:array];
        
        self.jobClass.selectButton.selected = NO;
         self.allButton.selected = NO;
        [self.arrGrade removeObject:[NSNumber numberWithInteger:sender.indexpath.section]];
        //[self.mytableView reloadData];
    }
}
-(void)foldHeaderforbutton:(UIButton *)sender{
    self.section = sender.tag;

    if (sender.selected) {
        //self.isSpread = YES;
        [self.arrsection addObject:[NSNumber numberWithInteger:sender.tag]];
        
    }
    else{
        
         [self.arrsection removeObject:[NSNumber numberWithInteger:sender.tag]];
    }
   // NSLog(@"log.tag = %lu",sender.tag);
  // [self.mytableView reloadData];
    NSIndexSet *set = [[NSIndexSet alloc]initWithIndex:sender.tag];
    [self.mytableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}
-(void)foldHeaderselectedbutton:(UIButton *)sender{
    if (sender.selected) {
        WKJobGradeModel *model = self.arrlist[sender.tag];
        for (int i =0; i<model.classMap.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:sender.tag];
            WKJobSelectClassTableViewCell *cell = (WKJobSelectClassTableViewCell*)[self.mytableView cellForRowAtIndexPath:index];
            if ( !cell.selectedButton.selected) {
                cell.selectedButton.selected = YES;
                NSArray *arr =  @[[NSNumber numberWithInteger:i],[NSNumber numberWithInteger:sender.tag]];
                [self.arrClass addObject:arr];
            }
        }
        [self.arrGrade addObject:[NSNumber numberWithInteger:sender.tag]];
        }
    else {
        WKJobGradeModel *model = self.arrlist[sender.tag];
        for (int i =0; i<model.classMap.count; i++) {
            NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:sender.tag];
            WKJobSelectClassTableViewCell *cell =(WKJobSelectClassTableViewCell*)[self.mytableView cellForRowAtIndexPath:index];
         
            
                cell.selectedButton.selected = NO;
                NSArray *arr =  @[[NSNumber numberWithInteger:i],[NSNumber numberWithInteger:sender.tag]];
                [self.arrClass removeObject:arr];
  
        }
         self.allButton.selected = NO;
        [self.arrGrade removeObject:[NSNumber numberWithInteger:sender.tag]];

    }
//    if (self.arrGrade.count<self.arrlist.count) {
//       
//    }
//    else{
//        
//    }

}
-(void)selectedAllAction:(UIButton*)sender{
    _allButton.selected  =!_allButton.selected;
    if (sender.selected) {
        [self.arrGrade removeAllObjects];
        [self.arrClass removeAllObjects];
        for (int i = 0; i<self.arrlist.count; i++) {
            [self.arrGrade addObject:[NSNumber numberWithInteger:i]];
            WKJobGradeModel *model = self.arrlist[i];
            for (int j =0; j<model.classMap.count; j++) {
                //            NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
                //            WKJobSelectClassTableViewCell *cell =[self.mytableView cellForRowAtIndexPath:index];
                //            if ( !cell.selectedButton.selected) {
                //                cell.selectedButton.selected = YES;
                NSArray *arr =  @[[NSNumber numberWithInteger:j],[NSNumber numberWithInteger:i]];
                [self.arrClass addObject:arr];
                
                //            }
                
            }
            
        }

    }
    else{
        [self.arrGrade removeAllObjects];
        [self.arrClass removeAllObjects];


    }
   [self.mytableView reloadData];
}
-(void)selectRightAction:(id)sender{
//    for (int i=0; i<self.arrClass.count; i++) {
//        NSIndexPath *index = [NSIndexPath indexPathForRow:[self.arrClass[i][0]integerValue] inSection: [self.arrClass[i][1]integerValue]];
//         WKJobSelectClassTableViewCell *cell =(WKJobSelectClassTableViewCell*)[self.mytableView cellForRowAtIndexPath:index];
//         WKJobGradeModel *model = self.arrlist[ [self.arrClass[i][1]integerValue]];
//       NSArray *arr = [WKJObClassModel mj_objectArrayWithKeyValuesArray:model.classMap];
//        WKJObClassModel *model2 = arr[[self.arrClass[i][0]integerValue]];
//        [self.arrbackgrade addObject:model2];
//        cell.classlabel.text = model2.className;
//        NSString *sting = cell.classlabel.text ;
//     [self.arrbackClass addObject:sting];
//
//        NSLog(@"class-grade = %@",model2.gradeId_classId);
//        }
    
           for (int i = 0; i<self.arrlist.count; i++) {
            //        [self.arrGrade addObject:[NSNumber numberWithInteger:i]];
            WKJobGradeModel *model = self.arrlist[i];
            for (int j =0; j<model.classMap.count; j++) {
                NSIndexPath *index = [NSIndexPath indexPathForRow:j inSection:i];
                WKJobSelectClassTableViewCell *cell =[self.mytableView cellForRowAtIndexPath:index];
                if ( cell.selectedButton.selected) {
                    WKJObClassModel *model2= [WKJObClassModel mj_objectWithKeyValues: model.classMap[j]];
                    NSLog(@"class-grade = %@",model2.gradeId_classId);
                    [self.arrbackgrade addObject:model2];
                    NSString *sting = cell.classlabel.text ;
                    [self.arrbackClass addObject:sting];
                }
                
            }
            
        }
    if (self.isShare) {
        NSString *gradeAndclass;
        for (int j=0; j<self.arrbackgrade.count; j++) {
            WKJObClassModel *model = self.arrbackgrade[j];
            if (j==0) {
               gradeAndclass = model.gradeId_classId;
            }
            else{
                gradeAndclass = [NSString stringWithFormat:@"%@,%@",gradeAndclass,model.gradeId_classId];
            }
        }

        NSDictionary *dic = @{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"taskId":[NSNumber numberWithInteger:self.taskId],@"stuTaskId":[NSNumber numberWithInteger:self.stuModel.stuTaskId],@"graClsIds":gradeAndclass};
        __weak typeof(self) weakself = self;
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKBackstage executeGetBackstageJobShareWithParameter:dic success:^(id object) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    if ([[object objectForKey:@"flag"]intValue]) {
                        [weakself.hud showAnimated:YES];
                        weakself.hud.label.text = @"分享成功" ;
                        weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                          [weakself.navigationController popViewControllerAnimated:YES];

                        });
                                          }
                });

            } failed:^(id object) {
                
            }];
                  });
    }
    else{
        [self.navigationController popViewControllerAnimated:YES];
        [self.delegate snedCLassNSstring:self.arrbackClass Grade:self.arrbackgrade];


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
