//
//  WKMyJobViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/4.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMyJobViewController.h"
#import "WKMyJobheader.h"
#import "WKMyJobTableViewCell.h"
#import "WKMeHandler.h"
#import "WKUploadMyJobViewController.h"
#import "MWPhotoBrowser.h"
#import "WKOpenTeachTaskViewController.h"
@interface WKMyJobViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate,MWPhotoBrowserDelegate>
@property (nonatomic,strong) UITableView *jobTableView;
@property (nonatomic,strong) WKMyJobheader *myJobheader;
@property (nonatomic,assign) BOOL isHand;
@property (nonatomic,assign) NSInteger page;
@property (nonatomic,assign)BOOL isMore;
@property (nonatomic,strong) NSMutableArray *arrlist;
@property (nonatomic,strong) NSMutableArray *arrImage;

@end

@implementation WKMyJobViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray*)arrImage{
    if (!_arrImage) {
        _arrImage = [NSMutableArray array];
    }
    return _arrImage;
}
-(void)initStyle{
    self.myJobheader = [[WKMyJobheader alloc]init];
    self.myJobheader = [[[NSBundle mainBundle]loadNibNamed:@"MyJobheader" owner:nil options:nil]lastObject];
    self.myJobheader.frame = CGRectMake(0, 64, SCREEN_WIDTH, 40);
    self.myJobheader.notHand.selected = YES;
    self.myJobheader.unHand.selected = NO;
    [self.myJobheader.notHand addTarget:self action:@selector(getNotHandinJob:) forControlEvents:UIControlEventTouchUpInside];
    [self.myJobheader.unHand addTarget:self action:@selector(getUnHandinJob:) forControlEvents:UIControlEventTouchUpInside];
    [self.myJobheader.backButton addTarget:self action:@selector(goBackAction) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:self.myJobheader];
}
-(void)initTableView{
    self.jobTableView = [[UITableView alloc]initWithFrame:CGRectMake(10, 104, SCREEN_WIDTH-20, SCREEN_HEIGHT-104) style:UITableViewStylePlain];
    self.jobTableView.delegate = self;
    self.jobTableView.dataSource = self;
    self.jobTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.jobTableView.showsVerticalScrollIndicator = NO;
    self.jobTableView.showsHorizontalScrollIndicator = NO;
      self.jobTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.jobTableView registerNib:[UINib nibWithNibName:@"WKMyJobTableViewCell" bundle:nil]
            forCellReuseIdentifier:@"mycell"];
    self.jobTableView.mj_footer=[MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMore)];
    self.jobTableView.mj_footer.automaticallyChangeAlpha=YES;
    [self.view addSubview:self.jobTableView];

}
-(void)initData{
    self.page = 1;
        [self.arrlist removeAllObjects];
 
    NSDictionary *dic = @{@"isHanded":[NSNumber numberWithBool:self.isHand],@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"searchMsg":self.search.text};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyJobSearchWithParameter:dic success:^(id object) {
            for (WKMyJobModel *model in object) {
                [weakself.arrlist addObject:model];
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [weakself.jobTableView reloadData];
            });
        } failed:^(id object) {
            
        }];

    });

}
- (void)viewDidLoad {
    [super viewDidLoad];
      self.search.placeholder = @"搜索相关作业";
    self.search.delegate = self;
    self.page = 1;
    self.isHand = NO;
    self.isMore = NO;
    [self initStyle];
    [self  initTableView];
    [self initData];
    
    // Do any additional setup after loading the view.
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKMyJobTableViewCell *cell = [[WKMyJobTableViewCell alloc]init];
    cell = [[[NSBundle mainBundle]loadNibNamed:@"WKMyJobTableViewCell" owner:nil options:nil]lastObject];
    //WKMyJobTableViewCell *cell = (WKMyJobTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    WKMyJobModel *model = self.arrlist[indexPath.section];
    cell.sendbutton.tag = indexPath.section;
    cell.downloadButton.tag = indexPath.section;
    if (self.arrlist.count==0) {
        return nil;
    }
    else{
        cell.jobName.text = model.taskName;
        cell.className.text = [NSString stringWithFormat:@"班级: %@", model.className];
        cell.stuYear.text = [NSString stringWithFormat:@"学年: %lu", model.schoolYear];
        cell.promulgator.text = [NSString stringWithFormat:@"发布者: %@", model.createrName];
        cell.remark.text = [NSString stringWithFormat:@"备注: %@", model.remark];
        if (self.isHand) {
            cell.endTime.hidden = YES;
            cell.oneImageView.hidden = NO;
            cell.twoImageView.hidden = NO;
            cell.threeImage.hidden  = NO;
            cell.score.hidden = NO;
             cell.score.text = [NSString stringWithFormat:@"评分: %lu",model.taskScore];
            switch (model.starCount) {
                case 1:
                    cell.oneImageView.image = [UIImage imageNamed:@"star_on"];
                     cell.twoImageView.image = [UIImage imageNamed:@"star_off"];
                     cell.threeImage.image = [UIImage imageNamed:@"star_off"];
                
                    break;
                case 2:
                {
                     cell.oneImageView.image = [UIImage imageNamed:@"star_on"];
                     cell.twoImageView.image = [UIImage imageNamed:@"star_on"];
                     cell.threeImage.image = [UIImage imageNamed:@"star_off"];
                }
                    break;
                case 3:
                {
                    cell.oneImageView.image = [UIImage imageNamed:@"star_on"];
                    cell.twoImageView.image = [UIImage imageNamed:@"star_on"];
                    cell.threeImage.image = [UIImage imageNamed:@"star_on"];
                }
                    break;
                    
                default:
                {
                    cell.oneImageView.image = [UIImage imageNamed:@"star_off"];
                    cell.twoImageView.image = [UIImage imageNamed:@"star_off"];
                    cell.threeImage.image = [UIImage imageNamed:@"star_off"];
                }

                    break;
            }
           
            [cell.sendbutton setTitle:@"查看附件" forState:UIControlStateNormal];
            [cell.downloadButton setTitle:@"作业查看" forState:UIControlStateNormal];
            [cell.downloadButton addTarget:self action:@selector(watchMytaskAction:) forControlEvents:UIControlEventTouchUpInside];
            //[cell.sendbutton addTarget:self action:@selector() forControlEvents:<#(UIControlEvents)#>]
            [cell.sendbutton addTarget:self action:@selector(watchTeacherJobAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;

        }
        else{
            cell.oneImageView.hidden = YES;
            cell.twoImageView.hidden = YES;
            cell.threeImage.hidden  = YES;
            cell.score.hidden = YES;
            
            cell.endTime.hidden = NO;
            cell.endTime.text = [NSString stringWithFormat:@"上交日期: %@",model.endTime];
            [cell.sendbutton setTitle:@"上交作业" forState:UIControlStateNormal];
            [cell.sendbutton addTarget:self action:@selector(uploadJobAction:) forControlEvents:UIControlEventTouchUpInside];
            [cell.downloadButton setTitle:@"查看附件" forState:UIControlStateNormal];
            [cell.downloadButton addTarget:self action:@selector(watchTeacherJobAction:) forControlEvents:UIControlEventTouchUpInside];
            return cell;
        }
   

    }
    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return self.arrlist.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 164;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;

    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
-(void )goBackAction{
    [self.navigationController popViewControllerAnimated:YES];
}
-(void)getNotHandinJob:(UIButton*)sender{
    self.isHand  = NO;
    if (sender.selected) {
        sender.selected = sender.selected;
        
    }
    else{
        sender.selected = !sender.selected;
        self.myJobheader.unHand.selected = NO;
        [self initData];
    }
}
-(void)getUnHandinJob:(UIButton*)sender{
    self.isHand = YES;
    if (sender.selected) {
        sender.selected = sender.selected;
    }
    else{
        sender.selected = !sender.selected;
        self.myJobheader.notHand.selected = NO;
        [self initData];
    }
}
-(void)uploadJobAction:(UIButton*)sender {
    WKUploadMyJobViewController *upload = [[WKUploadMyJobViewController alloc]init];
    upload.model = self.arrlist [sender.tag];
    [self.navigationController pushViewController:upload animated:YES];
    
}
-(void)loadMore{
  
    self.page+=1;
    NSDictionary *dic = @{@"isHanded":[NSNumber numberWithBool:self.isHand],@"page":[NSNumber numberWithInteger:self.page],@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"searchMsg":self.search.text};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyJobSearchWithParameter:dic success:^(id object) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                 
                            for (WKMyJobModel *model in object) {
                               [weakself.arrlist addObject:model];

                    }
                           [weakself.jobTableView reloadData];
                           [weakself.jobTableView.mj_footer endRefreshing];
                         });
        } failed:^(id object) {
            
        }];
        
    });

    
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (textField == self.search) {
        [self initData];
    }
    return YES;
}
-(void)watchMytaskAction:(UIButton*)sender{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser showNextPhotoAnimated:YES];
    WKMyJobModel *model = self.arrlist[sender.tag];
    NSDictionary *dic = @{@"schoolId":SCOOLID,@"stuTaskId":[NSNumber numberWithInteger:model.id]};
    __weak typeof(self) weakself = self;
    [self.arrImage removeAllObjects];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyJobWatchWithParameter:dic success:^(id object) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           NSArray  *arr = [object objectForKey:@"urlList"];
                           for (NSDictionary *dic in arr) {
                               NSLog(@"dic =%@",[dic objectForKey:@"url"]);
                              // MWPhoto *photo = [MWPhoto photoWithImage:[UIImage imageNamed:@"water"]];
                               MWPhoto *photo = [MWPhoto photoWithURL:[NSURL URLWithString:[dic objectForKey:@"url"]]];
                               //[browser setCurrentPhotoIndex:0];

                              // NSLog(@"photo .url= %@",photo.photoURL);
                           [weakself.arrImage addObject:photo];
                           }
                           [browser reloadData];
                    [weakself.navigationController pushViewController:browser animated:YES];
            });
        } failed:^(id object) {
            
        }];
    });

}
-(void)watchTeacherJobAction:(UIButton*)sender{
    NSLog(@"^^__^^");
    WKMyJobModel *model = self.arrlist[sender.tag];
    __weak typeof(self) weakself = self;
    WKOpenTeachTaskViewController *open = [[WKOpenTeachTaskViewController alloc]init];
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:model.taskId]};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMeHandler executeGetMyTeachTaskWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                NSString *string = [object objectForKey:@"taskUrl"];
                open.taskUrl = string;
                [weakself.navigationController pushViewController:open animated:YES];
            });
        } failed:^(id object) {
            
        }];
    });
}
- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.arrImage.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < self.arrImage.count) {
        NSLog(@"...%@",[self.arrImage objectAtIndex:index ]);
        return  [self.arrImage objectAtIndex:index];
    }
    return nil;
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
