//
//  WKSearcherViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearcherViewController.h"
#import "WKSearchResultViewController.h"
#import "WKSearchRecordTableViewCell.h"
@interface WKSearcherViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property(strong,nonatomic)UITableView *searchtable;
@property(strong,nonatomic)WKSearchResultViewController *result;
@property(strong,nonatomic)UISearchController *searchcontroller;
@property(strong,nonatomic)NSArray *hot;
@property(strong,nonatomic)NSArray *record;
@property (strong,nonatomic) NSMutableArray *searTXT;

@end

@implementation WKSearcherViewController
-(NSMutableArray*)searTXT{
    if (!_searTXT) {
        _searTXT = [NSMutableArray array];
    }
    return _searTXT;
}
-(NSArray*)record{
    if (!_record) {
        _record=[NSArray arrayWithObjects:@"孤独皇后",@"歌手",@"三生三世十里桃花", nil];
    }
    return _record;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (self.searTXT.count) {
        return self.searTXT.count;
    }
    
        return 0;
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
        WKSearchRecordTableViewCell *cell= (WKSearchRecordTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"recordCell" forIndexPath:indexPath];
    cell.deleteButton.tag = indexPath.row;
    [cell.deleteButton addTarget:self action:@selector(deleteRecordACtion:) forControlEvents:UIControlEventTouchUpInside];
    if (self.searTXT.count) {
        cell.recordLabel.text = self.searTXT[indexPath.row];
        return cell;
    }
    
          return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 35;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 35;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *sectionview = [[UIView alloc]init];
    sectionview.backgroundColor  = [WKColor colorWithHexString:WHITE_COLOR];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 15, 15, 15)];
    imageview.contentMode =UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"time"];
    [sectionview addSubview:imageview];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(29, 5, 100, 35)];
    label.textColor = [WKColor colorWithHexString:DARK_COLOR];
    label.font = [UIFont fontWithName:FONT_REGULAR size:15];
    label.text = @"搜索记录";
    [sectionview addSubview:label];
    return sectionview;
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *sectionview = [[UIView alloc]init];
    sectionview.backgroundColor  = [WKColor colorWithHexString:WHITE_COLOR];
    UIImageView *imageview = [[UIImageView alloc]initWithFrame:CGRectMake(10, 10, 15, 15)];
    imageview.contentMode =UIViewContentModeScaleAspectFit;
    imageview.image = [UIImage imageNamed:@"role__delete"];
    if (self.searTXT.count) {
         [sectionview addSubview:imageview];
    }
   
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
       [button setTitleColor:[WKColor colorWithHexString:@"999999"] forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:15];
    if (self.searTXT.count) {
        button.frame = CGRectMake(25, 0, 100, 35);

        [button setTitle:@"清除搜索记录" forState:UIControlStateNormal];

    }
   else {
       button.frame = CGRectMake(6, 0, 100, 35);

       [button setTitle:@"暂无搜索记录" forState:UIControlStateNormal];

    }
       button.titleLabel.textAlignment = NSTextAlignmentLeft ;
    [button addTarget:self action:@selector(deleteAllrecordAction) forControlEvents:UIControlEventTouchUpInside];
    [sectionview addSubview:button];
    return sectionview;

}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    //searchController.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    
    // NSArray --> NSMutableArray
    self.searTXT = [myArray mutableCopy];
    
    BOOL isEqualTo1,isEqualTo2;
    isEqualTo1 = NO,isEqualTo2 = NO;
    
    if (_searTXT.count > 0) {
        isEqualTo2 = YES;
        //判断搜索内容是否存在，存在的话放到数组最后一位，不存在的话添加。
        for (NSString * str in myArray) {
            if ([searchBar.text isEqualToString:str]) {
                //获取指定对象的索引
                NSUInteger index = [myArray indexOfObject:searchBar.text];
                [_searTXT removeObjectAtIndex:index];
                [_searTXT insertObject:searchBar.text atIndex:0];
                isEqualTo1 = YES;
                break;
            }
        }
    }
    
    if (!isEqualTo1 || !isEqualTo2) {
        [_searTXT insertObject:searchBar.text atIndex:0];
    }
    if (_searTXT.count>10) {
        [_searTXT removeLastObject];
    }
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:_searTXT forKey:@"myArray"];
    [self.searchtable reloadData];
    self.result.searchtext = searchBar.text;
    [self.result initData];
}
-(void)deleteRecordACtion:(UIButton*)sender{
    [self.searTXT  removeObjectAtIndex:sender.tag];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.searTXT forKey:@"myArray"];
    [self.searchtable reloadData];
}
-(void)deleteAllrecordAction{
    [self.searTXT removeAllObjects];
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:nil forKey:@"myArray"];
    [self.searchtable reloadData];
}
-(void)initStyle{
    self.searchtable=[[UITableView alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64) style:UITableViewStylePlain];
    self.searchtable.delegate=self;
    self.searchtable.dataSource=self;
    self.searchtable.showsVerticalScrollIndicator = NO;
    self.searchtable.showsHorizontalScrollIndicator = NO;
    [self.searchtable registerNib:[UINib nibWithNibName:@"WKSearchRecordTableViewCell" bundle:nil] forCellReuseIdentifier:@"recordCell"];
    self.searchtable.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.searchtable.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:self.searchtable];
    
    self.result=[[WKSearchResultViewController alloc]init];
    self.searchcontroller=[[UISearchController alloc]initWithSearchResultsController:self.result];
    //设置与界面有关的样式
 //[self.searchcontroller.searchBar sizeToFit];   //大小调整
    self.searchcontroller.searchBar.placeholder = @"搜索课程/老师";
    self.searchcontroller.searchBar.frame = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    UIImage  *image = [self GetImageWithColor:[WKColor colorWithHexString:GREEN_COLOR] andHeight:64];
   // UIImage  *imageTwo = [self GetImageWithColor:[WKColor colorWithHexString:LIGHT_COLOR] andHeight:40];

    [self.searchcontroller.searchBar setBackgroundImage:image];
    self.searchcontroller.searchBar.backgroundColor= [WKColor colorWithHexString:GREEN_COLOR];
   // [self.searchcontroller.searchBar setSearchFieldBackgroundImage:imageTwo forState:UIControlStateNormal];
    //self.searchcontroller.searchBar.tintColor =[WKColor colorWithHexString:GREEN_COLOR];
    //self.searchcontroller.searchBar.alpha = 0.5;
    UITextField *searchField = [self.searchcontroller.searchBar valueForKey:@"_searchField"];
    searchField.textColor = [WKColor colorWithHexString:@"333333"];
   // searchField.borderStyle = UITextBorderStyleRoundedRect;
    searchField.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    searchField.font = [UIFont fontWithName:FONT_REGULAR size:17];
    
   // [searchField setValue:[WKColor colorWithHexString:<#(NSString *)#>] forKeyPath:@"_placeholderLabel.textColor"];
   // self.searchtable.tableHeaderView=self.searchcontroller.searchBar;
    
    //设置搜索控制器的结果更新代理对象
    self.searchcontroller.searchResultsUpdater=self;
    self.searchcontroller.hidesNavigationBarDuringPresentation = YES;
    //为了响应scope改变时候，对选中的scope进行处理 需要设置search代理
    self.searchcontroller.searchBar.delegate=self;
     self.definesPresentationContext=YES;
    [self.view addSubview:self.searchcontroller.searchBar];
    
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    //读取数组NSArray类型的数据
    NSArray *myArray = [[NSArray alloc] initWithArray:[userDefaultes arrayForKey:@"myArray"]];
    self.searTXT =[myArray mutableCopy];

      [self initStyle];
    //[self.view setBackgroundColor:[UIColor blueColor]];
    // Do any additional setup after loading the view.
}
- (UIImage*) GetImageWithColor:(UIColor*)color andHeight:(CGFloat)height
{
    CGRect r= CGRectMake(0.0f, 0.0f, SCREEN_WIDTH, height);
    UIGraphicsBeginImageContext(r.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, r);
    
    UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return img;
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
