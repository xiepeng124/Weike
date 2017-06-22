
//
//  WKCarouselFigureViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCarouselFigureViewController.h"
#import "WKSearcherViewController.h"
#import "WKMessageHandler.h"
#import "WKMessageViewController.h"
@interface WKCarouselFigureViewController ()
@property (strong ,nonatomic)UIBarButtonItem *rightButton2;
@end

@implementation WKCarouselFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton1.image=[UIImage imageNamed:@"home_search"];
    _rightButton2 = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(receiveMessageAction:)];
    _rightButton2.image=[UIImage imageNamed:@"home_message"];
   
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    leftButton.image = [UIImage imageNamed:@"logo"];
    
    self.navigationController.navigationBar.barTintColor = [WKColor colorWithHexString:WHITE_COLOR];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x-60, 0, 60, 40)];
   _label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    _label.font = [UIFont fontWithName:FONT_BOLD size:17];
    _label.textColor = [WKColor colorWithHexString:@"72c456"];
    _label.text = @"初中";
    _label.textAlignment = NSTextAlignmentCenter;
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame =CGRectMake(43, 16, 16, 10);
    [_button setBackgroundImage:[UIImage imageNamed:@"home_arrows_down"] forState:UIControlStateNormal];
       [_button setBackgroundImage:[UIImage imageNamed:@"up_on"] forState:UIControlStateSelected];
    //_button = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 20, 40)];
   // _button.buttonType = UIButtonTypeCustom;
    //[_button setImage:[UIImage imageNamed:@"home_arrows_down"] forState:UIControlStateNormal];
    [self.navigationItem.titleView addSubview:_label];
    [self.navigationItem.titleView addSubview:_button];
     self.navigationItem.rightBarButtonItems=@[negativeSpacer,_rightButton2, rightButton1];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftButton];
    //self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightButton2];
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    
    // Do any additional setup after loading the view.
}
-(void)viewWillAppear:(BOOL)animated{
    [self initDatacomment];
}
-(void)initDatacomment{
    NSDictionary *dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKMessageHandler executeGetMessageStatusWithParameter:dic success:^(id object) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"notReadSize"]intValue]) {
                    _rightButton2.image = [UIImage imageNamed:@"message_on"];
                }
                else{
                    _rightButton2.image=[UIImage imageNamed:@"home_message"];
                }
            });
        } failed:^(id object) {
            
        }];
    });
}

-(void)receiveMessageAction:(id)sender{
    WKMessageViewController *message = [[WKMessageViewController alloc]init];
    message.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:message animated:YES];
}
-(void)selectRightAction:(id)sender{
    WKSearcherViewController *searcher=[[WKSearcherViewController alloc]init];
[self presentViewController:searcher animated:YES completion:nil];
   // [self.navigationController pushViewController:searcher animated:YES];
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
