//
//  WKSearcherViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSearcherViewController.h"
#import "WKSearchResultViewController.h"
@interface WKSearcherViewController ()<UITableViewDelegate,UITableViewDataSource,UISearchResultsUpdating,UISearchBarDelegate>
@property(strong,nonatomic)UITableView *searchtable;
@property(strong,nonatomic)WKSearchResultViewController *result;
@property(strong,nonatomic)UISearchController *searchcontroller;
@property(strong,nonatomic)NSArray *hot;
@property(strong,nonatomic)NSArray *record;
@property(strong,nonatomic)NSMutableArray *all;
@end

@implementation WKSearcherViewController
-(NSArray*)hot{
    if (!_hot) {
        _hot=[NSArray arrayWithObjects:@"人民的名义",@"欢乐喜剧人",@"白百何",@"微微一笑很倾城",@"火影忍者", nil];
    }
    return _hot;
}
-(NSArray*)record{
    if (!_record) {
        _record=[NSArray arrayWithObjects:@"孤独皇后",@"歌手",@"三生三世十里桃花", nil];
    }
    return _record;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
        return [self.all[section] count];
    }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *mycell = @"cellid";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:mycell];
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:mycell];
    }
    cell.textLabel.text=self.all[indexPath.section][indexPath.row];
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 20;
}
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section==0) {
        return @"热搜榜";
    }
    return @"历史记录";
}
- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
}
- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)initStyle{
    self.searchtable=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.searchtable.delegate=self;
    self.searchtable.dataSource=self;
    [self.view addSubview:self.searchtable];
    self.result=[[WKSearchResultViewController alloc]init];
    self.searchcontroller=[[UISearchController alloc]initWithSearchResultsController:self.result];
    //设置与界面有关的样式
    [self.searchcontroller.searchBar sizeToFit];   //大小调整
    self.searchtable.tableHeaderView=self.searchcontroller.searchBar;
    
    //设置搜索控制器的结果更新代理对象
    self.searchcontroller.searchResultsUpdater=self;
    
    //为了响应scope改变时候，对选中的scope进行处理 需要设置search代理
    self.searchcontroller.searchBar.delegate=self;
    
    self.definesPresentationContext=YES;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.all=[NSMutableArray arrayWithObjects:self.hot,self.record ,nil];
    [self initStyle];
    //[self.view setBackgroundColor:[UIColor blueColor]];
    // Do any additional setup after loading the view.
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
