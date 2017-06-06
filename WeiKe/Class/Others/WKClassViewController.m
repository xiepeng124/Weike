//
//  WKClassViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/21.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKClassViewController.h"

@interface WKClassViewController ()<UIGestureRecognizerDelegate>

@end

@implementation WKClassViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationController.navigationBar.barTintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.navigationItem.titleView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    self.search = [[UITextField alloc]initWithFrame:CGRectMake(10, 0, SCREEN_WIDTH-75, 30)];
    //self.search.placeholder = @"搜索学科／课程";
    self.search.clearButtonMode=UITextFieldViewModeWhileEditing;
//    self.search.font = [UIFont fontWithName:FONT_REGULAR size:17];
    [self.search setValue:[UIColor redColor] forKeyPath:@"_placeholderLabel.textColor"];
    [self.search setValue:[UIFont fontWithName:FONT_REGULAR size:17] forKeyPath:@"_placeholderLabel.font"];
    //self.search.textColor = [WKColor colorWithHexString:@"c6f0b8"];
    self.cancelButton = [[UIButton alloc]initWithFrame:CGRectMake(SCREEN_WIDTH-55, 0, 35, 30)];
    self.cancelButton.titleLabel.font = [UIFont fontWithName:FONT_REGULAR size:17];
    self.cancelButton.titleLabel.textColor = [WKColor colorWithHexString:WHITE_COLOR];
    [self.cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    self.automaticallyAdjustsScrollViewInsets=NO;
    [self.navigationItem.titleView addSubview:self.search];
    [self.navigationItem.titleView addSubview:self.cancelButton];
    [self ClickOnTheBlankspace];
    self.search.returnKeyType = UIReturnKeySearch;
     [self.cancelButton addTarget:self action:@selector(cancelSearch) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.hidesBackButton  = YES;
  
    [self.view setBackgroundColor:[WKColor colorWithHexString:LIGHT_COLOR]];

    // Do any additional setup after loading the view.
}
-(void)ClickOnTheBlankspace{
    UITapGestureRecognizer *singletap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(Hidekeyboard:)];
   singletap.delegate =self;
    [self.view addGestureRecognizer:singletap];
    
}
-(void)Hidekeyboard:(UITapGestureRecognizer*)gesture{
  [self.view endEditing:YES];
    [self.search endEditing: YES];
}
#pragma mark - 屏蔽手势事件
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    //Tip:我们可以通过打印touch.view来看看具体点击的view是具体是什么名称,像点击UITableViewCell时响应的View则是UITableViewCellContentView.
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        //返回为NO则屏蔽手势事件
        return NO;
    }
    return YES;
}
-(void)cancelSearch{
    [self.view endEditing:YES];
    [self.search resignFirstResponder];
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
