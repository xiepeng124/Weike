//
//  ViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/5.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "ViewController.h"
#import "WKHttpTool.h"
@interface ViewController ()<SDCycleScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imag;
@property (weak, nonatomic) IBOutlet UIWebView *mywebview;
@property(strong,nonatomic)WKHttpTool *httptool;
@property(strong,nonatomic)UITableView *tableview;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.httptool=[[WKHttpTool alloc]init];
    //    [WKHttpTool getWithURLString:@"https://www.baidu.com" parameters:nil success:^(id responseObject) {
//        NSLog(@"id=%@",responseObject);
//    } failure:^(NSError *error) {
//        NSLog(@"error=%@",error);
//    }];
    [self.tableview.mj_header beginRefreshing];
    self.navigationItem.title=@"首页";
    //[self.navigationController setToolbarHidden:NO];
    SDCycleScrollView *cycleScroll=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH) delegate:self placeholderImage:[UIImage imageNamed:@"placeholer"]];
    cycleScroll.delegate=self;
    cycleScroll.backgroundColor=[UIColor redColor];
    UIImage *imag=[UIImage imageNamed:@"placeholer"];
    NSArray *arr=[NSArray arrayWithObjects:imag,imag,imag, nil];
    SDCycleScrollView *cycle2=[SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_WIDTH*0.56) imageNamesGroup:arr];
    
    cycle2.backgroundColor=[UIColor greenColor];
    cycleScroll.imageURLStringsGroup=nil;
    cycleScroll.autoScrollTimeInterval=2;
    //[self.view addSubview:cycleScroll];
    [self.view addSubview:cycle2];
    [self.httptool AFNetworkStatus];
    NSLog(@"%.2f",(float)(9/16));
    self.mywebview.frame=CGRectMake(0, 64, SCREEN_WIDTH, SCREEN_HEIGHT-64-49);
    NSURLRequest *request=[NSURLRequest requestWithURL:[NSURL URLWithString:@"https://www.baidu.com"]];
    [self.mywebview loadRequest:request];
    NSLog(@"%f..%f",SCREEN_WIDTH,SCREEN_HEIGHT);
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
