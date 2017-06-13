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
#import "WKPlayerSectionView.h"
#import "WKCommentSectionView.h"
#import "UUInputAccessoryView.h"
#import "WKPlayerHandler.h"
#import "WKReplyModel.h"
@interface WKplayViewController ()<ZFPlayerDelegate,UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIView *playerFatherView;
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (strong, nonatomic) ZFPlayerView *playerView;
/** 离开页面时候是否在播放 */

@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, strong) ZFPlayerModel *playerModel;
@property (weak, nonatomic) IBOutlet UITableView *playerTable;
@property (strong,nonatomic) UITableView *replyTableView;
@property (assign,nonatomic)CGFloat replyHeight;
@property (assign,nonatomic)CGFloat commentHeight;
@property (assign,nonatomic)CGFloat allReply;
@property (strong,nonatomic)WKPlayerSectionView *sectionView;
@property (strong,nonatomic)WKCommentSectionView  *commentSectionView;
@property (strong ,nonatomic) NSMutableArray *arrlist;
@property (strong ,nonatomic) NSMutableArray *arrComment;
@property (assign ,nonatomic)CGFloat titleH;
@property (strong,nonatomic) UICollectionView *collectionView;
@property (assign,nonatomic) NSInteger videoIndex;
@property (assign,nonatomic) NSInteger page;
@property (strong,nonatomic) WKVideoCommentModel *videoModel;
@property (strong,nonatomic)NSMutableArray *arrReply;
//@property (strong,nonatomic)UITableView *
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableviewBottom;

@end

@implementation WKplayViewController
-(NSMutableArray*)arrlist{
    if (!_arrlist) {
        _arrlist = [NSMutableArray array];
    }
    return _arrlist;
}
-(NSMutableArray*)arrComment{
    if (!_arrComment) {
        _arrComment = [NSMutableArray array];
    }
    return _arrComment;
}
-(NSMutableArray*)arrReply{
    if (!_arrReply) {
        _arrReply = [NSMutableArray array];
    }
    return _arrReply;
}

- (ZFPlayerModel *)playerModel {
    if (!_playerModel) {
        _playerModel                  = [[ZFPlayerModel alloc] init];
        //_playerModel.title            = @"这里设置视频标题";
        //_playerModel.videoURL         = [NSURL URLWithString:@"http://baobab.wdjcdn.com/1456665467509qingshu.mp4"];
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
       // ZFPlayerControlView *defaultControlView = [[ZFPlayerControlView alloc] init];
     //   [_playerView playerControlView:defaultControlView playerModel:self.playerModel];
        //NSLog(@"url.play = %@",self.playerModel.videoURL);
        
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

-(void)initTableview
{

    self.playerTable.delegate = self;
    self.playerTable.dataSource = self;
    [self.playerTable registerNib:[UINib nibWithNibName:@"WKPlayTitleTableViewCell" bundle:nil] forCellReuseIdentifier:@"TitleCell"];
    [self.playerTable registerClass:[WKPlayerTableViewCell class] forCellReuseIdentifier:@"VideoCell"];
     [self.playerTable registerNib:[UINib nibWithNibName:@"WKPlaycommentTableViewCell" bundle:nil] forCellReuseIdentifier:@"CommentCell"];
}
-(void)initVideodata{
    NSDictionary *dic = @{@"id":[NSNumber numberWithInteger:self.myId]};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKPlayerHandler executeGetVideoAndPlayWithParameter:dic success:^(id object) {
                       dispatch_async(dispatch_get_main_queue(), ^{
                           for (WKPlayVideoModel *model in object) {
                               [weakself.arrlist addObject:model];
                           }
                         
                           WKPlayVideoModel *model = weakself.arrlist[0];
                            weakself.playerModel.videoURL = [NSURL URLWithString:model.videoFilePath];
                           //NSLog(@" self.playerModel.videoURL = %@",self.playerModel.videoURL);
                     weakself.playerModel.title = model.title;
                          ZFPlayerControlView *defaultControlView = [[ZFPlayerControlView alloc] init];
                             [weakself.playerView playerControlView:defaultControlView playerModel:weakself.playerModel];
                    [weakself.playerView autoPlayTheVideo];
                           NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0, 2)];
                           [weakself.playerTable reloadSections:set withRowAnimation:UITableViewRowAnimationNone];
                           
                           [weakself.collectionView reloadData];
//                           if (!model.commentFlag) {
                                 [weakself initCommentData];
                           //}
                          
//                           for (int i=0; i<self.arrComment.count; i++) {
//                               NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:2];
//                               WKPlaycommentTableViewCell *cell = (WKPlaycommentTableViewCell*)[self.playerTable cellForRowAtIndexPath:index];
//                               [cell.replyTableView reloadData];
//                           }
                         
            });
        } failed:^(id object) {
            
        }];
    });
}
-(void)initCommentData{
   
        WKPlayVideoModel *model = self.arrlist[self.videoIndex];
        NSLog(@"_____");
        NSDictionary *dic = @{@"page":[NSNumber numberWithInteger:self.page ],@"schoolId":SCOOLID,@"themeId":[NSNumber numberWithInteger:model.id]};
        __weak typeof(self) weakself = self;
    [weakself.arrComment removeAllObjects];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [WKPlayerHandler executeGetVideoCommentWithParameter:dic success:^(id object) {
             dispatch_async(dispatch_get_main_queue(), ^{
                 for (WKVideoCommentModel *modeltwo in  object) {
                     [weakself.arrComment addObject:modeltwo];
                 }
                 //NSLog(@"%@ ...count",self.arrComment);
                 NSIndexSet *set = [NSIndexSet indexSetWithIndex:2];
                 [weakself.playerTable reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
                 
             });
            } failed:^(id object) {
                
            }];
        });


    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.zf_prefersNavigationBarHidden = YES;
   // self.videoModel = [[WKPlayVideoModel alloc]init];
         [self initVideodata];
    [self initTableview];
       self.videoIndex = 0;
    self.page = 1;
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
    [self.collectionView deselectItemAtIndexPath:index animated:YES];
    [self.collectionView selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
       // NSLog(@"2....");
   

       // Do any additional setup after loading the view.
}
- (void)dealloc {
    NSLog(@"%@释放了",self.class);
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter]removeObserver:self name:UIKeyboardWillShowNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"1....");
    [super viewWillAppear:animated];
    // pop回来时候是否自动播放

    if ( self.playerView && self.isPlaying) {
        self.isPlaying = NO;
        [self.playerView play];
    }
    self.tabBarController.tabBar.hidden = YES;
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    [self.navigationController setNavigationBarHidden:YES animated:NO];

}
-(void)viewDidAppear:(BOOL)animated{
    NSIndexPath *index = [NSIndexPath indexPathForItem:0 inSection:0];
   // [self.collectionView deselectItemAtIndexPath:index animated:YES];
    [self.collectionView selectItemAtIndexPath:index animated:YES scrollPosition:UICollectionViewScrollPositionLeft];
   // NSLog(@"3....");
    

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
    if (tableView == self.playerTable) {
        if (section == 2) {
            if (self.arrComment.count) {
                return self.arrComment.count;
            }
            return 0;
        }
        return 1;

    }
    if (self.arrReply.count) {
        return self.arrReply.count;
    }
    return 0;
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if (tableView == self.playerTable) {
//        if (self.arrlist.count) {
//            WKPlayVideoModel *model = self.arrlist[0];
//            if (!model.commentFlag) {
//                return 3;
//            }
        return 3;

       // }
       
          }
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (tableView == self.playerTable) {
        if (indexPath.section == 0) {
            return 43+self.titleH;
        }
        if (indexPath.section ==1) {
          //  NSLog(@"33333");
            return 122;
        }
    NSInteger number = self.allReply+75+self.commentHeight;
    //self.allReply = 0;
       return number;
  //return number;

    }
   // NSLog(@"5555");
    return self.replyHeight;
    }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (tableView ==self.playerTable) {
        if (section == 0) {
            return 0;
        }
        if (section == 1) {
            return 37;
        }
        return 77;

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
        WKPlayVideoModel *model;
        if (indexPath.section == 0) {
            WKPlayTitleTableViewCell *cell = (WKPlayTitleTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"TitleCell" forIndexPath:indexPath];
            if (self.arrlist.count) {
                model = self.arrlist[self.videoIndex];
                cell.titleLabel.text = model.title;
                self.titleH = [WKPlayTitleTableViewCell heightForLabel:cell.titleLabel.text];
                cell.titleLabel.frame = CGRectMake(10, 10, SCREEN_WIDTH-20, self.titleH);
                
                cell.videoName.text = model.teacherName;
                cell.videoLength.text = model.videoTimeLength;
                ;
                
                cell.subjectLable.text = [NSString stringWithFormat:@"%@·%@", model.gradeName,model.courseName];
                return cell;

            }
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
        self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 10, SCREEN_WIDTH, 102) collectionViewLayout:layout];
            _collectionView.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
            _collectionView.delegate = self;
            _collectionView.dataSource = self;
            _collectionView.scrollsToTop = NO;
            _collectionView.showsVerticalScrollIndicator = NO;
            _collectionView.showsHorizontalScrollIndicator = NO;
            [_collectionView registerNib:[UINib nibWithNibName:@"WKCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"Videocell2"];
            [cell addSubview:_collectionView];
            return cell;
            
        }
        model = self.arrlist[self.videoIndex];
                  WKPlaycommentTableViewCell *cell = (WKPlaycommentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"CommentCell" forIndexPath:indexPath];
        if (!model.commentFlag) {
            cell.hidden = NO;
        }
        else{
            cell.hidden = YES;
        }

            cell.replyTableView.delegate = self;
            cell.replyTableView.dataSource = self;
            cell.replyButton.tag = indexPath.row;
            [cell.replyTableView  registerNib:[UINib nibWithNibName:@"WKReplyTableViewCell" bundle:nil] forCellReuseIdentifier:@"myReplyCell"];
            [cell.replyButton addTarget:self action:@selector(replyAction:) forControlEvents:UIControlEventTouchUpInside];
            if (self.arrComment.count) {
                [self.arrReply removeAllObjects];
                WKVideoCommentModel *commentModel = self.arrComment[indexPath.row];
                self.videoModel = commentModel;
                NSArray *arr = [WKReplyModel mj_objectArrayWithKeyValuesArray:self.videoModel.children];
                for (WKReplyModel *models in arr) {
                    [self.arrReply addObject:models];
                }
                // NSLog(@"44444444");
                [cell.headPhoto sd_setImageWithURL:[NSURL URLWithString:commentModel.senderImgFileUrl] placeholderImage:[UIImage imageNamed:@"xie"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
                cell.stuName.text = commentModel.senderName;
                cell.commentTime.text = commentModel.sendTime;
                cell.commmentLabel.text  = commentModel.contentText;
                self.commentHeight = [WKPlaycommentTableViewCell heightForLabel:cell.commmentLabel.text];
                cell.replyTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
                cell.commntH.constant = self.commentHeight;
                //NSLog(@"11111");
                if (self.arrReply.count ==0) {
                                self.allReply = 0;
                            [cell.replyTableView reloadData];
                            cell.replyTableView.frame = CGRectMake(20 ,65+self.commentHeight, SCREEN_WIDTH-40, self.allReply);
                                return cell;
                            }
              else{
                for (int i=0; i<self.arrReply.count; i++) {
                    //                WKReplyTableViewCell *cell2 = (WKReplyTableViewCell*)[cell.replyTableView dequeueReusableCellWithIdentifier:@"myReplyCell" forIndexPath:indexPath];
                    
                    
                    WKReplyModel *replyModel = self.arrReply[i];
                    
                    self.replyHeight = [WKReplyTableViewCell heightForLabel: [NSString stringWithFormat:@"%@ :%@",replyModel.senderName,replyModel.contentText]];
                    //                cell2.replyLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-60, self.replyHeight);
                    if (i==0) {
                        self.allReply = self.replyHeight;
                    }
                    else{
                        self.allReply = self.allReply+self.replyHeight;
                        NSLog(@" self .allreply =%f  ",self.allReply);
                    }
                    
                }
                cell.replyTableView.frame = CGRectMake(20 ,65+self.commentHeight, SCREEN_WIDTH-40, self.allReply);
                
                [cell.replyTableView reloadData];
                return cell;
            }
            }
            //  }
            
            self.commentHeight = [WKPlaycommentTableViewCell heightForLabel:cell.commmentLabel.text];
            cell.commntH.constant = self.commentHeight;
            
            return cell;
            
        }
        //return nil;
        //NSLog(@"replucell");
        WKReplyTableViewCell *cell2 = (WKReplyTableViewCell*)[tableView dequeueReusableCellWithIdentifier:@"myReplyCell" forIndexPath:indexPath];
        
        // NSLog(@"----7654321");
        if (self.arrReply.count) {
            // NSLog(@"----111111");
           // NSLog(@"2222");
            WKReplyModel *replyModel = self.arrReply[indexPath.row];
            cell2.replyLabel.text =  [NSString stringWithFormat:@"%@ :%@",replyModel.senderName,replyModel.contentText];
            self.replyHeight = [WKReplyTableViewCell heightForLabel:cell2.replyLabel.text];
            cell2.replyLabel.frame = CGRectMake(10, 0, SCREEN_WIDTH-60, self.replyHeight);
            return cell2;
        }
        
        return nil;

  
    }
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (tableView == self.playerTable) {
        if (section == 1) {
        
        
            self.sectionView = [[WKPlayerSectionView alloc]init];
            self.sectionView = [[[NSBundle mainBundle]loadNibNamed:@"PlayerSectionHeader" owner:nil options:nil]lastObject];
            self.sectionView.frame = CGRectMake(0, 0, SCREEN_WIDTH, 37);
            self.sectionView.layer.borderColor = [WKColor colorWithHexString:BACK_COLOR].CGColor;
            self.sectionView.layer.borderWidth = 0.5;
            if (self.arrlist.count) {
                    WKPlayVideoModel *model = self.arrlist[0];
                self.sectionView.countLabel.text = [NSString stringWithFormat:@"(%@)",model.total];
                return self.sectionView;

            }
                        return self.sectionView;

        }
                       if (section == 2) {
                    self.commentSectionView = [[WKCommentSectionView alloc]init];
                    self.commentSectionView = [[[NSBundle mainBundle]loadNibNamed:@"CommentSectionView" owner:nil options:nil]lastObject];
                    self.commentSectionView.myComment.delegate = self;
                    self.commentSectionView.layer.borderColor = [WKColor colorWithHexString:BACK_COLOR].CGColor;
                    self.commentSectionView.layer.borderWidth = 0.5;
                           if (self.arrlist.count) {
                               WKPlayVideoModel *model = self.arrlist[0];
                               if (!model.commentFlag) {
                                   self.commentSectionView.hidden = NO;
                               }
                               else{
                                   self.commentSectionView.hidden = YES;
                               }
                           }

                    [self.commentSectionView.commentbutton addTarget:self action:@selector(commentSendAction) forControlEvents:UIControlEventTouchUpInside];
                    if (self.arrComment.count) {
                        WKVideoCommentModel *commentModel = _arrComment[0];
                        
                        self.commentSectionView.commentCount.text = [NSString stringWithFormat:@"(%@)",commentModel.total] ;
                        return self.commentSectionView;
                    }
                    
                    return self.commentSectionView;
                    
                    
                }


    
            }
    return nil;
  }
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
//    [self.playerTable reloadData];
//    NSIndexPath * dayOne = [NSIndexPath indexPathForRow:0 inSection:2];
//    [self.playerTable scrollToRowAtIndexPath:dayOne atScrollPosition:UITableViewScrollPositionTop animated:YES];
}
- (void)keyboardWillShow:(NSNotification *)notification{
       CGRect keyboardFrame = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat height = keyboardFrame.size.height;
    self.tableviewBottom .constant= height+10;
//    CGFloat textField_maxY = self.commentSectionView.myComment.frame.origin.y;
//    NSLog(@"1122");
//   // CGFloat space = - self.playerTable.contentOffset.y + textField_maxY;
//    CGFloat transformY = textField_maxY- height;
//    if (transformY < 30) {
//        CGRect frame = self.playerTable.frame;
//        frame.origin.y = transformY ;
//        
//        
//        self.playerTable.frame = frame;
//    }
}
- (void)keyboardWillHide:(NSNotification *)notification {
    //恢复到默认y为0的状态，有时候要考虑导航栏要+64
//    CGRect frame = self.playerTable.frame;
//    frame.origin.y = SCREEN_WIDTH/16*9+20;
//    self.playerTable.frame = frame;
    self.tableviewBottom.constant = 0;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    //NSLog(@"----");
    if (self.arrlist.count) {
        return self.arrlist.count;
    }
    return 1;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"....");
    WKCollectionViewCell *cell = (WKCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"Videocell2" forIndexPath:indexPath];
    if (_arrlist.count) {
        WKPlayVideoModel *model = _arrlist[indexPath.row];
       [ cell.videoImage sd_setImageWithURL:[NSURL URLWithString:model.videoImgUrl] placeholderImage:[UIImage imageNamed:@"xie"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
//        if (indexPath.row==0) {
//            cell.backView.hidden = NO;
//            cell.piayingImage.hidden = NO;
//        }
//        else{
           cell.backView.hidden = YES;
           cell.piayingImage.hidden = YES;
//
//        }
              cell.videoTitle.text = model.title;
        return cell;

    }
    return cell;
   }
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKCollectionViewCell *cell = (WKCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    WKPlayVideoModel *model = self.arrlist[indexPath.row];
    self.playerModel.videoURL = [NSURL URLWithString:model.videoFilePath];
    self.playerModel.title = model.title;
    self.videoIndex = indexPath.row;
    [self.playerView resetToPlayNewVideo:self.playerModel];
    NSIndexSet *indexSet=[[NSIndexSet alloc]initWithIndex:0];
    [self.playerTable reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
    [self initCommentData];
    
    cell.backView.hidden = NO;
    cell.piayingImage.hidden = NO;
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    WKCollectionViewCell *cell = (WKCollectionViewCell*)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backView.hidden = YES;
    cell.piayingImage.hidden = YES;
}
-(void)commentSendAction{
    WKPlayVideoModel *model = self.arrlist[self.videoIndex];
    //WKVideoCommentModel *modelTwo = self.arrComment[0];
    NSLog(@"%@...&&&",self.commentSectionView.myComment.text);
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"themeId":[NSNumber numberWithInteger:model.id],@"receiverId":[NSNumber numberWithInteger:model.receiverId],@"contentText":self.commentSectionView.myComment.text};
    __weak typeof(self) weakself = self;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKPlayerHandler executeGetVideoCommentSendWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself initCommentData];
                }

                
            });

            } failed:^(id object) {
            
        }];
           });
}
-(void)replyAction: (UIButton*)sender{
    UIKeyboardType type =  UIKeyboardTypeDefault;
    NSString *content = @"";
    
    [UUInputAccessoryView showKeyboardType:type
                                   content:content
                                     Block:^(NSString *contentStr)
     {
         WKVideoCommentModel *model=  self.arrComment[sender.tag];
         
         NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"pId":[NSNumber numberWithInteger:model.id],@"senderType":USERTYPE,@"contentText":contentStr};
         __weak typeof(self) weakself = self;
         dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
             [WKPlayerHandler executeGetVideoReplySendWithParameter:dic success:^(id object) {
                 dispatch_async(dispatch_get_main_queue(), ^{
                     if ([[object objectForKey:@"flag"]intValue]) {
                         [weakself initCommentData];
                     }
                 });
             } failed:^(id object) {
                 
             }];
         });
;
        }];


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
#pragma mark - Action

- (IBAction)backClick {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)backtopview:(id)sender {
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    //NSLog(@"class = %@",NSStringFromClass([touch.view class]));
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UICollectionView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    if (touch.view.frame.size.height == 102) {
        return NO;
    }    //    if ([NSStringFromClass([touch.view class])isEqualToString:@"CollectionCell"] ) {
    //        return NO;
    //    }
    return YES;
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
