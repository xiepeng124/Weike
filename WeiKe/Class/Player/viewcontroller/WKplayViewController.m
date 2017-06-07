//
//  WKplayViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/10.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKplayViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <MediaPlayer/MediaPlayer.h>
#import "ZFPlayer.h"
#import <ZFDownload/ZFDownloadManager.h>
#import "UINavigationController+ZFFullscreenPopGesture.h"
#import "WKPlayTitleTableViewCell.h"
#import "WKPlayerTableViewCell.h"
#import "WKPlaycommentTableViewCell.h"
#import "WKReplyTableViewCell.h"
@interface WKplayViewController ()<ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UIView *playerFatherView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (weak, nonatomic) IBOutlet UITableView *playerTable;
@property (strong,nonatomic) UITableView *replyTableView;
@end

@implementation WKplayViewController
-(void)initTableview
{
    self.playerTable.delegate = self;
    self.playerTable.dataSource = self;
    [self.playerTable registerNib:[UINib nibWithNibName:@"WKPlayTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.playerTable registerClass:[WKPlayerTableViewCell class] forCellReuseIdentifier:@"VideoCell"];
     [self.playerTable registerNib:[UINib nibWithNibName:@"WKPlaycommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.zf_prefersNavigationBarHidden = YES;
    [self initTableview];
    [self.playerView autoPlayTheVideo];
    // Do any additional setup after loading the view.
}
- (void)dealloc {
    NSLog(@"%@释放了",self.class);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放
    if ( self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
    self.tabBarController.tabBar.hidden = YES;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    // push出下一级页面时候暂停
    if (self.playerView && !self.playerView.isPauseByUser)
    {
        self.isPlaying = YES;
        [self.playerView pause];
//        self.playerView.playerPushedOrPresented = YES;
    }
    self.tabBarController.tabBar.hidden = NO;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 2) {
        return 10;
    }
    return 1;
    
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.playerTable) {
          return 3;
    }
    return 3;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.playerTable) {
        if (indexPath.section == 0) {
            return 20;
        }
        if (indexPath.section ==1) {
            return 122;
        }
        return 300;

    }
    return 100;
    }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView ==self.playerTable) {
        if (section == 0) {
            return 0;
        }
        return 20;

    }
    return 0;
    }
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (tableView == self.playerTable) {
        return 10;

    }
    return 0;
  }

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.playerTable) {
        if (indexPath.section == 0) {
            WKPlayTitleTableViewCell *cell = (WKPlayTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            return cell;
        }
        if (indexPath.section ==1) {
            WKPlayerTableViewCell *cell = (WKPlayerTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"VideoCell" forIndexPath:indexPath];
            
            UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
            layout.itemSize = CGSizeMake(128, 102);
            layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
            layout.minimumLineSpacing = 10;
            layout.sectionInset = UIEdgeInsetsMake(0, 10, 0, 10);
            //layout.minimumInteritemSpacing =10;
            UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 102) collectionViewLayout:layout];
            collectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
            collectionView.delegate = self;
            collectionView.dataSource = self;
            collectionView.scrollsToTop = NO;
            collectionView.showsVerticalScrollIndicator = NO;
            collectionView.showsHorizontalScrollIndicator = NO;
            [collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Videocell2"];
            [cell addSubview:collectionView];
            return cell;
            
        }
        WKPlaycommentTableViewCell *cell = (WKPlaycommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
//        self.replyTableView  = [[UITableView alloc]initWithFrame:CGRectMake(10, 120, SCREEN_WIDTH-20, 100) style:UITableViewStylePlain];
        cell.replyTableView.delegate = self;
        cell.replyTableView.dataSource = self;
        [cell.replyTableView  registerNib:[UINib nibWithNibName:@"WKReplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"myReplyCell"];
        return cell;

    }
    NSLog(@"replucell");
    WKReplyTableViewCell *cell = (WKReplyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"myReplyCell" forIndexPath:indexPath];
    
    return cell;
    }
//-(void)initCollectionview{
//    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
//    layout.itemSize = CGSizeMake(128, 102);
//    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
//    layout.minimumLineSpacing = 10;
//    layout.minimumInteritemSpacing =10;
//    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 102) collectionViewLayout:layout];
//    //collectionView.backgroundColor = [UIColor redColor];
//    //    collectionView.delegate = self;
//    //    collectionView.dataSource = self;
//    collectionView.scrollsToTop = NO;
//    collectionView.showsVerticalScrollIndicator = NO;
//    collectionView.showsHorizontalScrollIndicator = NO;
//    [collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Videocell2"];
//    
//}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if (section == 0) {
        return nil;
    }
    if (section == 1) {
        return @"视频目录(5)";
    }
    return @"学生评论(20)";
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSLog(@"----");
    return 10;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"....");
    WKCollectionViewCell *cell = (WKCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Videocell2" forIndexPath:indexPath];
    //cell.videoImage.image = [UIImage imageNamed:@"water"];
    return cell;
}

// 返回值要必须为NO
- (BOOL)shouldAutorotate {
    return NO;
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    // 这里设置横竖屏不同颜色的statusbar
    // if (ZFPlayerShared.isLandscape) {
    //    return UIStatusBarStyleDefault;
    // }
    return UIStatusBarStyleLightContent;
}

//- (BOOL)prefersStatusBarHidden {
//    return ZFPlayerShared.isStatusBarHidden;
//}

#pragma mark - ZFPlayerDelegate

- (void)zf_playerBackAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)zf_playerDownload:(NSString *)url {
    // 此处是截取的下载地址，可以自己根据服务器的视频名称来赋值
    NSString *name = [url lastPathComponent];
    [[ZFDownloadManager sharedDownloadManager] downFileUrl:url filename:name fileimage:nil];
    // 设置最多同时下载个数（默认是3）
    [ZFDownloadManager sharedDownloadManager].maxCount = 4;
}

- (void)zf_playerControlViewWillShow:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    //    self.backBtn.hidden = YES;
    [UIView animateWithDuration:0.25 animations:^{
        self.backButton.alpha = 0;
    }];
}

- (void)zf_playerControlViewWillHidden:(UIView *)controlView isFullscreen:(BOOL)fullscreen {
    //    self.backBtn.hidden = fullscreen;
    [UIView animateWithDuration:0.25 animations:^{
        self.backButton.alpha = !fullscreen;
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        _playerModel.title            = @"这里设置视频标题";
        _playerModel.videoURL         = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456665467509qingshu.mp4"];
        _playerModel.placeholderImage = [UIImage imageNamed:@"water"];
        _playerModel.fatherView       = self.playerFatherView;
        //        _playerModel.resolutionDic = @{@"高清" : self.videoURL.absoluteString,
        //                                       @"标清" : self.videoURL.absoluteString};
    }
    return _playerModel;
}

- (ZFPlayerView *)playerView {
    if (!_playerView) {
        _playerView = [[ZFPlayerView alloc] init];
        
        /*****************************************************************************************
         *   // 指定控制层(可自定义)
         *   // ZFPlayerControlView *controlView = [[ZFPlayerControlView alloc] init];
         *   // 设置控制层和播放模型
         *   // 控制层传nil，默认使用ZFPlayerControlView(如自定义可传自定义的控制层)
         *   // 等效于 [_playerView playerModel:self.playerModel];
         ******************************************************************************************/
        ZFPlayerControlView *defaultControlView = [[ZFPlayerControlView alloc] init];
        [_playerView playerControlView:defaultControlView playerModel:self.playerModel];
        
        // 设置代理
        _playerView.delegate = self;
        
        //（可选设置）可以设置视频的填充模式，内部设置默认（ZFPlayerLayerGravityResizeAspect：等比例填充，直到一个维度到达区域边界）
        // _playerView.playerLayerGravity = ZFPlayerLayerGravityResize;
        
        // 打开下载功能（默认没有这个功能）
        _playerView.hasDownload    = YES;
        
        // 打开预览图
        self.playerView.hasPreviewView = YES;
        
    }
    return _playerView;
}
#pragma mark - Action

- (IBAction)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backtopview:(id)sender {
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
