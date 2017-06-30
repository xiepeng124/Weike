//
//  WKMeViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKMeViewController.h"
#import "WKMyMenu.h"
#import "WKMeTableViewCell.h"
#import "WKTeacherMenu.h"
#import "WKMyteacherViewController.h"
#import "WKBackstageCollectionViewController.h"
#import "WKMyJobViewController.h"
#import "WKViewingrecordViewController.h"
#import "WKTeachImforEditViewController.h"
#import "WKStuImforEditViewController.h"
#import "WKPasswordViewController.h"
#import "WKMeHandler.h"
#import "WKMessageViewController.h"
#import "WKMessageHandler.h"
@interface WKMeViewController ()<UITableViewDelegate,UITableViewDataSource,UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *MineTableView;
@property (weak, nonatomic) IBOutlet UIImageView *MeImage;
@property (weak, nonatomic) IBOutlet UILabel *classLabel;
@property (weak, nonatomic) IBOutlet UILabel *myName;
@property (strong,nonatomic) WKMyMenu *menulist;
@property (weak, nonatomic) IBOutlet UIButton *messageButton;
@property (strong,nonatomic) WKTeacherMenu *teacherlist;
@end

@implementation WKMeViewController
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([USERTYPE intValue]==2) {
          return [self.menulist.Datalist[section] count];
    }
    return [self.teacherlist.Datalist[section] count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
    WKMeTableViewCell *cell = (WKMeTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"Mycell" forIndexPath:indexPath];
    if ([USERTYPE intValue]==2) {
        cell.DataImage.image =[UIImage imageNamed:self.menulist.Imagelist[indexPath.section][indexPath.row]];
        cell.DataTitle.text = self.menulist.Datalist[indexPath.section][indexPath.row];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        return cell;

    }
    cell.DataImage.image =[UIImage imageNamed:self.teacherlist.Imagelist[indexPath.section][indexPath.row]];
    cell.DataTitle.text = self.teacherlist.Datalist[indexPath.section][indexPath.row];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;

   }
-(void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
    view.tintColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if ([USERTYPE intValue]==2){
    return self.menulist.Datalist.count;
    }
    else{
        return self.teacherlist.Datalist.count;

    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([USERTYPE intValue]==2) {
        if (indexPath.section==0) {
            switch (indexPath.row) {
                case 0:
                {
                    WKMyJobViewController *job = [[WKMyJobViewController alloc]init];
                    job.hidesBottomBarWhenPushed = YES;
                    [self.navigationController pushViewController:job animated:YES];
                }
                    break;
                case 1:
                {
                    WKMyteacherViewController *mytecher = [[WKMyteacherViewController alloc]init];
                    mytecher.navigationItem.title = @"我的老师";
                    mytecher.hidesBottomBarWhenPushed =YES;
                    [self.navigationController pushViewController:mytecher animated:YES];
                    break;
                }
                case 2:
                {
                    WKViewingrecordViewController *record = [[WKViewingrecordViewController alloc]init];
                    record.navigationItem.title = @"观看记录";
                    record.hidesBottomBarWhenPushed =YES;
                    [self.navigationController pushViewController:record animated:YES];
                    break;
                }

                    
                default:
                    break;
            }
        }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                   WKStuImforEditViewController  *stuImfor = [[WKStuImforEditViewController alloc]init];
                    stuImfor.hidesBottomBarWhenPushed = YES;
                   stuImfor.navigationItem.title = @"个人资料";
                    stuImfor.isDetail = NO;
                    [self.navigationController pushViewController:stuImfor animated:YES];
                }
                    break;
                case 1:
                {
                    WKPasswordViewController *tpass = [[WKPasswordViewController alloc]init];
                    tpass.hidesBottomBarWhenPushed = YES;
                    tpass.navigationItem.title = @"密码修改";
                    [self.navigationController pushViewController:tpass animated:YES];
                }
                    break;
                default:
                    break;
            }
        }
        
    }
    else{
        if (indexPath.section == 0) {
            WKViewingrecordViewController *record = [[WKViewingrecordViewController alloc]init];
            record.navigationItem.title = @"观看记录";
            record.hidesBottomBarWhenPushed =YES;
            [self.navigationController pushViewController:record animated:YES];
          
        }
        if (indexPath.section == 1) {
            switch (indexPath.row) {
                case 0:
                {
                    WKTeachImforEditViewController *teachimfor = [[WKTeachImforEditViewController alloc]init];
                   teachimfor.hidesBottomBarWhenPushed = YES;
                   teachimfor.navigationItem.title = @"个人资料";
                    teachimfor.isDetail = NO;
                    [self.navigationController pushViewController:teachimfor animated:YES];
                    break;
                }
                case 1:
                {
                    WKPasswordViewController *tpass = [[WKPasswordViewController alloc]init];
                    tpass.hidesBottomBarWhenPushed = YES;
                    tpass.navigationItem.title = @"密码修改";
                    [self.navigationController pushViewController:tpass animated:YES];
                    break;
                }

                    
                default:
                    break;
            }

        }
        if (indexPath.section ==2) {
            switch (indexPath.row) {
                case 0:
                {
                    NSLog(@"11111111111");
                    WKBackstageCollectionViewController *back = [[WKBackstageCollectionViewController alloc]init];
                    back.hidesBottomBarWhenPushed = YES;
                    back.navigationItem.title = @"后台管理";
                    [self.navigationController pushViewController:back animated:YES];
                    break;
                }

                    
            default:
                    break;
            }
        }

    }
       [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
-(void)inittableview{
    self.MineTableView.dataSource =self;
    self.MineTableView.delegate = self;
    self.MineTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.MineTableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    [self.MineTableView registerNib:[UINib nibWithNibName:@"WKMeTableViewCell" bundle:nil] forCellReuseIdentifier:@"Mycell"];
    self.myName.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.myName.textColor = [WKColor colorWithHexString:@"333333"];
    self.classLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    self.classLabel.textColor = [WKColor colorWithHexString:@"2d7fc0"];
    self.MeImage.layer.cornerRadius = 50;
    self.MeImage.layer.borderColor = [WKColor colorWithHexString:GREEN_COLOR].CGColor;
    self.MeImage.layer.borderWidth = 2;
    self.MeImage.layer.masksToBounds = YES;
    self.navigationController.delegate =self;
    self.menulist = [[WKMyMenu alloc]init];
    self.teacherlist = [[WKTeacherMenu alloc]init];
    [self.messageButton addTarget:self action:@selector(goMesseageAction) forControlEvents:UIControlEventTouchUpInside];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self inittableview];
    if ([USERTYPE intValue]==2) {
        self.classLabel.hidden = NO;
    }
    else{
        self.classLabel.hidden = YES;
    }
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    NSDictionary *dic  =@{@"token":TOKEN};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [WKMeHandler executeGetMyDataWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([USERTYPE integerValue]==2) {
                    WKStudentData *model = object;
                    weakSelf.myName.text = model.studentName;
                    weakSelf.classLabel.text  = model.className;
                    [weakSelf.MeImage sd_setImageWithURL:[NSURL URLWithString:model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"xie"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
                    
                }
                else{
                    WKTeacherData *model = object;
                    weakSelf.myName.text = model.teacherName;
                    [weakSelf.MeImage sd_setImageWithURL:[NSURL URLWithString:model.imgFileUrl] placeholderImage:[UIImage imageNamed:@"xie"] options:SDWebImageLowPriority|SDWebImageRetryFailed];
                    
                }
                
            });
        } failed:^(id object) {
            
        }];
    });
    [self initDatacomment];
}

-(void)goMesseageAction{
    WKMessageViewController *message = [[WKMessageViewController alloc]init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];

}
-(void)initDatacomment{
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    __weak typeof(self) weakSelf = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageStatusWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"notReadSize"]intValue]) {
                    [weakSelf.messageButton setBackgroundImage: [UIImage imageNamed:@"message_on"] forState:UIControlStateNormal];
                 
                }
                else{
                      [weakSelf.messageButton setBackgroundImage: [UIImage imageNamed:@"home_message"] forState:UIControlStateNormal];
                   
                }
            });
        } failed:^(id object) {
            
        }];
    });
}

- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    // 判断要显示的控制器是否是自己
    BOOL isShowHomePage = [viewController isKindOfClass:[self class]];
    
    [self.navigationController setNavigationBarHidden:isShowHomePage animated:NO];
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
