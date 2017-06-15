
//
//  WKCarouselFigureViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKCarouselFigureViewController.h"
#import "WKSearcherViewController.h"
@interface WKCarouselFigureViewController ()

@end

@implementation WKCarouselFigureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *rightButton1 = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(selectRightAction:)];
    rightButton1.image=[UIImage imageNamed:@"home_search"];
    UIBarButtonItem *rightButton2 = [[UIBarButtonItem alloc]initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:@selector(receiveMessageAction:)];
    rightButton2.image=[UIImage imageNamed:@"home_message"];
   
    UIBarButtonItem *leftButton = [[UIBarButtonItem alloc] initWithTitle:nil style:UIBarButtonItemStylePlain target:self action:nil];
    leftButton.image = [UIImage imageNamed:@"logo"];
    
    self.navigationController.navigationBar.barTintColor = [WKColor colorWithHexString:WHITE_COLOR];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]   initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace   target:nil action:nil];
    negativeSpacer.width=-10;
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(self.view.center.x-60, 0, 60, 40)];
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    label.font = [UIFont fontWithName:FONT_BOLD size:17];
    label.textColor = [WKColor colorWithHexString:@"72c456"];
    label.text = @"高中";
    label.textAlignment = NSTextAlignmentCenter;
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(40, 0, 20, 40)];
    [button setImage:[UIImage imageNamed:@"home_arrows_down"] forState:UIControlStateNormal];
    [self.navigationItem.titleView addSubview:label];
    [self.navigationItem.titleView addSubview:button];
     self.navigationItem.rightBarButtonItems=@[negativeSpacer,rightButton2, rightButton1];
    self.navigationItem.leftBarButtonItems = @[negativeSpacer,leftButton];
    //self.navigationItem.rightBarButtonItems = @[negativeSpacer,rightButton2];
    self.automaticallyAdjustsScrollViewInsets=NO;
   
    
    // Do any additional setup after loading the view.
}
-(void)receiveMessageAction:(id)sender{
    
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
