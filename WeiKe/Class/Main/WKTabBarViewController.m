//
//  WKTabBarViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/11.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTabBarViewController.h"
#import "WKHomeViewController.h"
#import "WKAcademyViewController.h"
@interface WKTabBarViewController ()

@end

@implementation WKTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBar.tintColor=[WKColor colorWithHexString:GREEN_COLOR];
    //self.tabBarItem.badgeColor=[UIColor yellowColor];
//    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:self];
//    [self.view addSubview:nav.view];
//    WKAcademyViewController *acade=[[WKAcademyViewController alloc]init];
//    WKHomeViewController *home=[[WKHomeViewController alloc]init];
//    self.viewControllers=@[home,acade];
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
