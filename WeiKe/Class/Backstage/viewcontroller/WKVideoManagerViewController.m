//
//  WKVideoManagerViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/11.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoManagerViewController.h"
#import "WKRoleView.h"
#import "WKVideoDetailView.h"
#import "WKVideoTableViewCell.h"
#import "WKBackstage.h"
#import "WKUploadVideoViewController.h"
#import "WKSetVideoViewController.h"
#import "WKVideoADViewController.h"
#import "WKVideoMergeViewController.h"
#import "WKUploadOutLinkViewController.h"
#import "WKEditVideoViewController.h"
@interface WKVideoManagerViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,VideoDelegate>
@property(strong,nonatomic)WKRoleView *roleHeadView;
@property(strong,nonatomic)UIButton *outside;
@property(strong,nonatomic)WKVideoDetailView *detailView;
@property(strong,nonatomic)UITableView *videoTableview;
@property(assign,nonatomic)BOOL  isOutLink;
@property(strong,nonatomic)NSMutableArray *videolist;
@property(strong,nonatomic)MBProgressHUD *hud;
@property (strong,nonatomic) NSMutableArray *arrnumber;
@property (assign,nonatomic) BOOL iscomment;
//@property (assign,i)
@end

@implementation WKVideoManagerViewController
-(NSMutableArray*)arrnumber{
    if (!_arrnumber) {
        _arrnumber = [NSMutableArray array];
    }
    return _arrnumber;
}

-(NSMutableArray*)videolist{
    if (!_videolist) {
        _videolist = [NSMutableArray array];
        
    }
    return _videolist;
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
    [self.outside setTitle:@"外部视频" forState:  UIControlStateNormal];
    self.roleHeadView.localButton.selected = YES;
       self.outside.selected = NO;
    self.roleHeadView.onvideoImage .image = [UIImage imageNamed:@"upload_video"];
    self.roleHeadView.addLable.text = @"上传视频";
    [self.roleHeadView.localButton addTarget:self action:@selector(getLocationVideo:) forControlEvents:UIControlEventTouchUpInside];
    [self.outside addTarget:self action:@selector(getOutsideVideo:) forControlEvents:UIControlEventTouchUpInside];

    [self.roleHeadView addSubview:self.outside];
    [self.roleHeadView .backButton addTarget:self action:@selector(BackAction) forControlEvents:UIControlEventTouchUpInside];
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(uploadGesture:)];
    tapGesture.numberOfTapsRequired = 1;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(deleteTapGesture:)];
    tap.numberOfTapsRequired = 1 ;
    [self.roleHeadView.deleteView addGestureRecognizer:tap];
    [self.roleHeadView.addView addGestureRecognizer:tapGesture];
    [self.view addSubview:self.roleHeadView];
    UIView *lineview = [[UIView alloc]initWithFrame:CGRectMake(0, 108, SCREEN_WIDTH, 0.5)];
    lineview.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
    [self.view addSubview:lineview];
    NSArray *arrlist2 = [[NSBundle mainBundle]loadNibNamed:@"DetailView" owner:nil options:nil];
    self.detailView = [[WKVideoDetailView alloc]init];
   
    self.detailView = [arrlist2 lastObject];
    self.detailView.frame = CGRectMake(0, 108.5, SCREEN_WIDTH, 38.5);
    [self.detailView.videoMenu setTitleColor:[WKColor colorWithHexString:BACK_COLOR] forState:UIControlStateNormal];
     [self.detailView.videoMerge setTitleColor:[WKColor colorWithHexString:BACK_COLOR] forState:UIControlStateNormal];
    [self.detailView.videoMenu addTarget:self action:@selector(gosetVideo) forControlEvents:UIControlEventTouchUpInside];
    [ self.detailView.videoMerge addTarget:self action:@selector(goMergeVideo) forControlEvents:UIControlEventTouchUpInside ];
    [self.view addSubview:self.detailView];
 
}
-(void)initTableView{
    self.videoTableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 147, SCREEN_WIDTH, SCREEN_HEIGHT-147) style:UITableViewStylePlain];
    self.videoTableview.delegate = self;
    self.videoTableview.dataSource = self;
    self.videoTableview.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.videoTableview.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    self.videoTableview.showsVerticalScrollIndicator = NO;
    [self.view addSubview:self.videoTableview];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeText;
    [self.view addSubview:self.hud];
}
-(void)initdata{
    NSDictionary *dic =@{@"page":@1,@"token": TOKEN,@"schoolId":SCOOLID,@"searchMsg":self.search.text,@"isOutLink":[NSNumber numberWithBool:self.isOutLink]};
    [self.videolist removeAllObjects];
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoWithParameter:dic success:^(id object) {
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
    self.isOutLink = NO;
    self.iscomment = YES;
    [super viewDidLoad];
    self.search.placeholder = @"搜索本地视频";
    self.search.delegate = self;
    self.navigationItem.hidesBackButton = YES;
    [self initStyle];
    [self initTableView];
    [self initdata];
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKVideoTableViewCell *cell = [[WKVideoTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKVideoTableViewCell" owner:nil options:nil]lastObject];
    WKVideoModel *model = self.videolist[indexPath.section];
    cell.titleLabel.text = model.title;
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
   
    NSString *string1 = [model.gradeName substringToIndex:2];
    if (model.courseName.length==0) {
         cell.subject.text = [NSString stringWithFormat:@"%@·全体",string1];
    }
    else{
        NSString *string2 = [model.courseName substringToIndex:2];
          cell.subject.text = [NSString stringWithFormat:@"%@·%@",string1,string2];
    }

    //cell.subject.text = [NSString stringWithFormat:@"%@·%@",model.gradeName,model.courseName];
    cell.selectedButton.tag = indexPath.section;
    cell.promuButton.tag = indexPath.section;
    //cell.adButton.tag = indexPath.section;
    cell.delegate = self;
   
    switch ( model.approvalStatus.intValue) {
        case 1:
        {
            cell.stateLabel.text = @"待审核";
            [cell.adButton setTitle:@"撤销发布" forState:UIControlStateNormal];
            [cell.promuButton setTitle:@"删除" forState:UIControlStateNormal];
              [cell.promuButton addTarget:self action:@selector(deleteVideo:) forControlEvents:UIControlEventTouchUpInside ];
            [cell.adButton addTarget:self action:@selector(cancelIssueVideoad:) forControlEvents:UIControlEventTouchUpInside];
            
        }
            break;
        case 2:
        {
            cell.stateLabel.text = @"已发布";
            if (model.bannerUrl) {
                 [cell.adButton setTitle:@"撤销广告页" forState:UIControlStateNormal];
                [cell.adButton addTarget:self action:@selector(cancelVideoad:) forControlEvents:UIControlEventTouchUpInside ];
            }
            else{
            [cell.adButton setTitle:@"设置广告页" forState:UIControlStateNormal];
                [cell.adButton addTarget:self action:@selector(setVideoad:) forControlEvents:UIControlEventTouchUpInside ];
            }
            [cell.selectedButton setHidden:YES];
            [cell.promuButton setTitle:@"撤销发布" forState:UIControlStateNormal];
            [cell.promuButton addTarget:self action:@selector(cancelIssueVideoad:) forControlEvents:UIControlEventTouchUpInside ];

        }
            break;
        case 3:
            cell.stateLabel.text = @"审核不通过";
            [cell.adButton setTitle:@"编辑" forState:UIControlStateNormal];
            [cell.adButton addTarget:self action:@selector(editVideoAction:)  forControlEvents:UIControlEventTouchUpInside];
            [cell.promuButton setTitle:@"删除" forState:UIControlStateNormal];
              [cell.promuButton addTarget:self action:@selector(deleteVideo:) forControlEvents:UIControlEventTouchUpInside ];
            break;
        case 4:
            cell.stateLabel.text = @"待发布";
            [cell.adButton setTitle:@"编辑" forState:UIControlStateNormal];
            [cell.adButton addTarget:self action:@selector(editVideoAction:)  forControlEvents:UIControlEventTouchUpInside];

            [cell.promuButton setTitle:@"删除" forState:UIControlStateNormal];
            [cell.promuButton addTarget:self action:@selector(deleteVideo:) forControlEvents:UIControlEventTouchUpInside ];
            break;

        default:
            break;
    }
    cell.adButton.tag = indexPath.section;
   [cell.promuButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-10);
       make.bottom.mas_equalTo(-10);
       make.size.mas_equalTo(CGSizeMake([WKVideoTableViewCell widthForLabel:cell.promuButton.currentTitle ]+20, 25));
   }];
   [ cell.adButton mas_makeConstraints:^(MASConstraintMaker *make) {
       if ([cell.adButton.currentTitle isEqualToString:@"撤销广告页"]||[cell.adButton.currentTitle isEqualToString:@"设置广告页"]) {
           make.right.mas_equalTo(-(55+cell.promuButton.frame.size.width));

       }
       else{
        make.right.mas_equalTo(-(25+cell.promuButton.frame.size.width));
       }
        make.bottom.mas_equalTo(-10);
        make.size.mas_equalTo(CGSizeMake([WKVideoTableViewCell widthForLabel:cell.adButton.currentTitle ]+20, 25));
    }];
   // NSLog(@"cell.title = %@",cell.promuButton.currentTitle);
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.videolist.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60+(SCREEN_WIDTH-233)*0.56;
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

-(void)BackAction{
    [self.navigationController popViewControllerAnimated:YES];
    
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
-(void)getLocationVideo:(id)sender{
    self.iscomment = YES;
     self.roleHeadView.addLable.text = @"上传视频";
    if (self.roleHeadView.localButton.selected) {
        self.roleHeadView.localButton.selected = self.roleHeadView.localButton.selected;


    }
    else{
        self.roleHeadView.localButton .selected = !self.roleHeadView.localButton.selected;
        self.outside.selected  = !self.roleHeadView.localButton.selected;
        self.isOutLink = NO;
        [self initdata];
    }
    
}
-(void)getOutsideVideo:(id)sender{
    self.iscomment = NO;
    
      self.roleHeadView.addLable.text = @"引用外部";
    if (self.outside.selected) {
        self.outside.selected = self.outside.selected;
       
    }
    else{
        self.outside.selected  = !self.outside.selected;
        self.roleHeadView.localButton.selected =!self.outside.selected;
        self.isOutLink = YES;
        
        [self initdata];
    }
}
-(void)uploadGesture:(UITapGestureRecognizer*)tap{
    if (self.isOutLink) {
        UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        WKUploadOutLinkViewController *upload = [main instantiateViewControllerWithIdentifier:@"upLoadOutLink"];
        [self.navigationController pushViewController:upload animated:YES];

    }
    else{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WKUploadVideoViewController *edit = [main instantiateViewControllerWithIdentifier:@"upLoadVideo"];
    [self.navigationController pushViewController:edit animated:YES];
    }

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
        WKVideoModel *model = self.videolist[[self.arrnumber[i]integerValue]];
        if (i==0) {
            cellid = [NSString stringWithFormat:@"%lu",model.id];
        }
        else{
            cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
        }

      
    }
    
    __weak typeof(self) weakself = self;
    [self.hud showAnimated:YES];
    NSDictionary *dic = @{@"schoolId":SCOOLID, @"ids":cellid};
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageDeleteVideoWithParameter:dic success:^(id object) {
                    
            
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.hud.label.text = @"删除成功";
                weakself.hud.label.textColor = [WKColor colorWithHexString:GREEN_COLOR];
                //[weakself.hud hideAnimated:YES afterDelay:1];
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
-(void)gosetVideo{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    WKSetVideoViewController *set = [main instantiateViewControllerWithIdentifier:@"setVideo"];
    if (self.arrnumber.count ==0) {
        [self.hud showAnimated:YES];
      self.hud.label.text = @"请选择视频";
       self.hud.label.textColor = [UIColor redColor];
        [self.hud hideAnimated:YES afterDelay:1];
    }else{
    set.videoModel = self.videolist[[self.arrnumber[0]integerValue]];
     set.videoarr = [NSMutableArray array];
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
}
-(void)goMergeVideo{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    NSLog(@"789098");
    WKVideoMergeViewController *Merge = [main instantiateViewControllerWithIdentifier:@"videoMerge"];
    if (self.arrnumber.count ==0) {
          [self.hud showAnimated:YES];
        self.hud.label.text = @"请选择视频";
        self.hud.label.textColor = [UIColor redColor];
        [self.hud hideAnimated:YES afterDelay:1];
    }else{
        Merge.videoModel = self.videolist[[self.arrnumber[0]integerValue]];
        Merge.videoarr = [NSMutableArray array];
        for (int i=0; i<self.arrnumber.count; i++) {
            WKVideoModel *model = self.videolist[[self.arrnumber[i]integerValue]];
            [Merge.videoarr addObject:model];
        }
        Merge.isOutLink = self.isOutLink;
        Merge.isCommet = self.iscomment;
        [self.navigationController pushViewController:Merge animated:YES];

        [self.arrnumber removeAllObjects];
        for (int i=0; i<self.videolist.count; i++) {
            [self.videoTableview deselectRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0] animated:YES];
            
        }
        [self.videoTableview reloadData];
    }

 // [self.navigationController pushViewController:Merge animated:YES];
}
-(void)cancelVideoad:(UIButton*)sender{
    WKVideoModel *model = self.videolist[sender.tag];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:model.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoADCancelWithParameter:dic success:^(id object) {
           // NSLog(@"sender.tag=%@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"撤销广告页成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself initdata];
                }
                else{
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"撤销广告页失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                }
            });
            
        } failed:^(id object) {
            
        }];
        
    }) ;

}
-(void)setVideoad:(UIButton*)sender{
    WKVideoModel *model = self.videolist[sender.tag];
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:model.id]};
    __weak typeof(self) weakself = self;
 dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
     [WKBackstage executeGetBackstageVideoADWithParameter:dic success:^(id object) {
      NSLog(@"sender.tag=%@",object);
         dispatch_async(dispatch_get_main_queue(), ^{
             
             if ([[object objectForKey:@"flag"]intValue]) {
                 NSLog(@"22222");
                 UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                 WKVideoADViewController *video = [main instantiateViewControllerWithIdentifier:@"videoAD"];
                 video.videoDic = object ;
                 [weakself.navigationController pushViewController:video animated:YES];
             }
             else{
                 NSLog(@"3333");
                 [weakself.hud showAnimated:YES];
                 weakself.hud.label.text = @"广告页已超过5条";
                 [weakself.hud hideAnimated:YES afterDelay:1];
             }
         });
         
     } failed:^(id object) {
         
     }];

 }) ;
   
}
-(void)cancelIssueVideoad:(UIButton*)sender{
    
    WKVideoModel *model = self.videolist[sender.tag];
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"id":[NSNumber numberWithInteger:model.id],@"loginUserId":LOGINUSERID};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageVideoCancelWithParameter:dic success:^(id object) {
           // NSLog(@"sender.tag=%@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"撤销成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself initdata];
                }
                else{
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"撤销失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                }
            });
            
        } failed:^(id object) {
            
        }];
        
    }) ;

}
-(void)deleteVideo:(UIButton *)sender{
    WKVideoModel *model = self.videolist[sender.tag];
    NSDictionary *dic = @{@"schoolId":SCOOLID, @"ids":[NSNumber numberWithInteger:model.id]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageDeleteVideoWithParameter:dic success:^(id object) {
            //NSLog(@"sender.tag=%@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"删除成功";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                    [weakself initdata];
                }
                else{
                    [weakself.hud showAnimated:YES];
                    weakself.hud.label.text = @"删除失败";
                    [weakself.hud hideAnimated:YES afterDelay:1];
                }
            });
            
        } failed:^(id object) {
            
        }];
        
    }) ;

}
-(void)editVideoAction:(UIButton*)sender{
    UIStoryboard *main = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    WKEditVideoViewController *editContro = [main instantiateViewControllerWithIdentifier:@"editVideo"];
    [self.navigationController pushViewController:editContro animated:YES];
    editContro.videoModel = self.videolist[sender.tag];
    editContro.isOutLink = self.isOutLink;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField;{
    [textField resignFirstResponder];
    if (textField ==self.search) {
        [self initdata];
    }
    return YES;
}
-(void)viewWillAppear:(BOOL)animated{
    [self initdata];
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
