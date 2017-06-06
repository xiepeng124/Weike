//
//  WKBaseViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKBaseViewController.h"

@interface WKBaseViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WKBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[WKColor colorWithHexString:WHITE_COLOR]];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:
                                                             nil style:UIBarButtonItemStylePlain target:nil action:nil];
    self.navigationItem.backBarButtonItem = item;
    [self ClickOnTheBlankspace];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
    singletap.delegate =self;
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
    [self.view endEditing:YES];
    //[self.search endEditing: YES];
}
#pragma mark - 屏蔽手势事件
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
//    if ([NSStringFromClass([touch.view class])isEqualToString:@"CollectionCell"] ) {
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
