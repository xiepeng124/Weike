//
//  WKWatchShareTaskViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKWatchShareTaskViewController.h"
#import "WKJobImageTableViewCell.h"
#import "WKMessageHandler.h"
#import "MWPhotoBrowser.h"
@interface WKWatchShareTaskViewController ()<UITableViewDataSource,UITableViewDelegate,MWPhotoBrowserDelegate>
@property (strong,nonatomic)UITableView *myTableView;
@property (strong,nonatomic)NSMutableArray *arrList;
@property (strong ,nonatomic)UIBarButtonItem *rightButton;
@property (nonatomic,strong) NSMutableArray *arrImage;;
@end

@implementation WKWatchShareTaskViewController
#pragma mark - init (初始化)
-(NSMutableArray*)arrImage{
    if (!_arrImage) {
        _arrImage = [NSMutableArray array];
    }
    return _arrImage;
}
-(NSMutableArray *)arrList{
    if (!_arrList) {
        _arrList = [NSMutableArray array];
    }
    return _arrList;
}

-(void)initStyle{
    _rightButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
  
    _rightButton.tintColor = [WKColor colorWithHexString:DARK_COLOR];
    [_rightButton setTitleTextAttributes:@{NSFontAttributeName:[UIFont fontWithName:FONT_REGULAR size:12]} forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = _rightButton;
  
    self.navigationItem.title = [NSString stringWithFormat:@"%@的作业", self.stuName];
 
}
-(void)initTabelView{
    self.myTableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [_myTableView  registerClass:[WKJobImageTableViewCell class] forCellReuseIdentifier:@"taskCell"];
    _myTableView.showsVerticalScrollIndicator = NO;
    _myTableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    _myTableView.delegate =self;
    _myTableView.dataSource = self;
    _myTableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self.view addSubview:_myTableView];
}
-(void)initData{
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"stid":[NSNumber numberWithInteger:self.stid ],@"msgId":[NSNumber numberWithInteger:self.msgId]};
    NSLog(@"stid =%lu,msgid = %lu",self.stid,self.msgId);
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSLog(@"111111");
        [WKMessageHandler executeGetMessageTaskShareWithParameter:dic success:^(id object) {
            NSLog(@"2222");
            NSLog(@"object = %@",object);
            dispatch_async(dispatch_get_main_queue(), ^{
                NSArray *arr = [object objectForKey:@"stuTaskList"];
                for (NSDictionary *mydic in arr) {
                    NSString *url = [mydic objectForKey:@"url"];
                    [weakself.arrList addObject:url];
                }
                NSLog(@" %@___",[object objectForKey:@"taskScore"]);
                NSNumber *number = [object objectForKey:@"taskScore"];
                [weakself.myTableView reloadData];
                weakself.rightButton.title = [NSString stringWithFormat:@"得分:%@分",number];
            });
            
        } failed:^(id object) {
            NSLog(@"%%%@",object);
        }];
    });
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageTaskShareWithParameter:dic success:^(id object) {
            
        } failed:^(id object) {
            
        }];
    });
}
#pragma mark - 界面加载
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    [self initTabelView];
    [self initData];
    // Do any additional setup after loading the view.
}
#pragma mark - UITableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WKJobImageTableViewCell *cell =  (WKJobImageTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"taskCell" forIndexPath:indexPath ];
    UIImageView* JobimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/16*9 )];
    //JobimageView.image = [UIImage imageNamed:@"water"];
    if (self.arrList.count) {
        [ JobimageView sd_setImageWithURL:[NSURL URLWithString:self.arrList[indexPath.section]] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority ];
        [cell.contentView addSubview:JobimageView];
        return cell;
    }
   

    return cell;
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (self.arrList.count) {
         return self.arrList.count+1;
    }
    return 0;
}
#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    [browser setCurrentPhotoIndex:indexPath.section];
    browser.displayActionButton = NO;
    browser.alwaysShowControls = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.displayNavArrows = NO;
    browser.startOnGrid = NO;
    browser.enableGrid = YES;
    [browser showNextPhotoAnimated:YES];
    [self.arrImage removeAllObjects];
    for (int i=0; i<self.arrList.count; i++) {
    
        MWPhoto *photo =[MWPhoto photoWithURL:[NSURL URLWithString:self.arrList[i]]];
        
        [self.arrImage addObject:photo];
    }
    [browser reloadData];
    [self.navigationController pushViewController:browser animated:YES];
    [self.myTableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 10;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return (SCREEN_WIDTH-20)/16*9;
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section {
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    
    header.contentView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
}
#pragma mark - MWPhotoBrowserDelegate(图片查看代理)
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

#pragma mark - Action(点击事件)
-(void)selectRightAction:(UIBarButtonItem*)button{
    
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
