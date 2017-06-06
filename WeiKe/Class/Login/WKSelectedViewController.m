//
//  WKSelectedViewController.m
//  WeiKe
//
//  Created by 谢鹏 on 2017/4/7.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKSelectedViewController.h"

@interface WKSelectedViewController ()
@property (weak, nonatomic) IBOutlet UIButton *teacher;
@property (weak, nonatomic) IBOutlet UIButton *student;
@property(strong,nonatomic)WKSingleTon *singleton;
@end

@implementation WKSelectedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor yellowColor]];
    self.teacher.layer.cornerRadius =50;
    self.student.layer.cornerRadius = 50;
    self.teacher.layer.masksToBounds = YES;
    self.student.layer.masksToBounds = YES;
    NSLog(@"%f",SCREEN_WIDTH);
    self.singleton=[WKSingleTon shareWKSingleTon];
//    WKSingleTon *wksingle=[WKSingleTon shareWKSingleTon];
//    wksingle.isTeacher=YES;
//    UIButton *butteacher=[UIButton buttonWithType:UIButtonTypeCustom];
//    
//    [self.view addSubview:butteacher];
//
//    
//    [butteacher mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(50);
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//        make.top.mas_equalTo(200);
//
//           }];
//    [butteacher setTitle:@"教师版 " forState:UIControlStateNormal];
//    [butteacher setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    butteacher.backgroundColor=[UIColor redColor];
//    
//    UIButton *butstudent=[UIButton buttonWithType:UIButtonTypeCustom];
//    [self.view addSubview:butstudent];
//   [butstudent mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.height.mas_equalTo(50);
//        make.left.mas_equalTo(50);
//        make.right.mas_equalTo(-50);
//        make.bottom.mas_equalTo(-200);
//        
//    }];
//    [butstudent setTitle:@"学生版 " forState:UIControlStateNormal];
//    [butstudent setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
//    butstudent.backgroundColor=[UIColor redColor];
   //[self.view addSubview:butteacher];

    // Do any additional setup after loading the view.
}
- (IBAction)Clickteachers:(id)sender {
    self.singleton.isTeacher=YES;
}
- (IBAction)Clickstudents:(id)sender {
    self.singleton.isTeacher=NO;
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
