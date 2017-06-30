//
//  WKEditUserTableViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/28.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKEditUserTableViewController.h"
#import "WKUserTeacherViewController.h"
#import "WKUserStudentViewController.h"
#import "WKUserPasswordSetViewController.h"
#import "WKBelongsRoleTableViewController.h"
@interface WKEditUserTableViewController ()
@property (nonatomic,strong) NSMutableArray *arrList;
@end

@implementation WKEditUserTableViewController
-(NSMutableArray*)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray arrayWithObjects:@"帐户信息",@"修改密码",@"所属角色", nil];
    }
    return _arrList;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.navigationItem.title = @"编辑帐户信息";
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (_queryType==1) {
        return self.arrList.count;
    }
    return self.arrList.count-1;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    static NSString *mycell = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
    }
    cell.textLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    cell.textLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    cell.textLabel.text = self.arrList[indexPath.section];
    cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
    cell.backgroundColor = [UIColor whiteColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 37;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 10;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView*)view;
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section==0) {
        if (_queryType==1) {
            WKUserTeacherViewController *teacher = [[WKUserTeacherViewController alloc]init];
            teacher.model = self.model;
            [self.navigationController pushViewController:teacher animated:YES];
        }
        else{
            WKUserStudentViewController *student = [[WKUserStudentViewController alloc]init];
            student.model = self.model;
               [self.navigationController pushViewController:student animated:YES];
        }
      
    }
    if (indexPath.section == 1) {
        WKUserPasswordSetViewController *pass = [[WKUserPasswordSetViewController alloc]init];
        pass.model = _model;
        [self.navigationController pushViewController:pass animated:YES];
    }
    if (indexPath.section == 2) {
        WKBelongsRoleTableViewController *role = [[WKBelongsRoleTableViewController alloc]init];
        role.model = _model;
        [self.navigationController pushViewController:role animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
