//
//  WKVideoADViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/17.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKVideoADViewController.h"
#import "WKUploadImage.h"
#import "WKBackstage.h"
@interface WKVideoADViewController ()<upImageDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *Imageurl;
@property (weak, nonatomic) IBOutlet UILabel *oneLabel;
@property (weak, nonatomic) IBOutlet UILabel *twoLabel;
@property (weak, nonatomic) IBOutlet UIButton *editButton;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (strong ,nonatomic) WKUploadImage *uploadImage;
@property (strong,nonatomic)NSString *imagead;
@end

@implementation WKVideoADViewController
-(void)initStyle{
    self.oneLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.oneLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    self.twoLabel.textColor = [WKColor colorWithHexString:@"666666"];
    self.twoLabel.font = [UIFont fontWithName:FONT_REGULAR size:12];
    NSString *sting = [self.videoDic objectForKey:@"imgUrl"];
    [self.Imageurl sd_setImageWithURL:[NSURL URLWithString:sting] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageLowPriority|SDWebImageRetryFailed ];
    self.Imageurl.layer.cornerRadius = 3;
    self.Imageurl.layer.masksToBounds = YES;
    [self.editButton setTitleColor:[WKColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [self.editButton addTarget:self action:@selector(selectedImageAction) forControlEvents:UIControlEventTouchUpInside];
    self.editButton.layer.cornerRadius = 3;
    [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateSelected];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:@"e5e5e5"];
   
    self.keepButton.layer.cornerRadius = 3;
    self.keepButton.userInteractionEnabled = NO;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    [self initStyle];
    self.uploadImage = [WKUploadImage shareManager];
    self.uploadImage.url =VIEDO_AD_UP;
    //NSLog(@".....%@",self.videoDic);
   // NSLog(@"%@_____",[self.videoDic objectForKey:@"id"]);
    NSDictionary *dic = @{@"id":[self.videoDic objectForKey:@"id"]};
    self.uploadImage.diction = dic;
    // Do any additional setup after loading the view.
}
-(void)selectedImageAction{
    [self.uploadImage selectUserpicSourceWithViewController:self];
    self.uploadImage.delegate = self;
}
-(void)selctedImage:(NSDictionary *)Imgestring{
    self.keepButton.userInteractionEnabled = YES;
    self.keepButton.selected = YES;
     self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    [self.Imageurl sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"bannerUrl"] ] placeholderImage:[UIImage imageNamed:@"water"] options:SDWebImageRetryFailed|SDWebImageLowPriority];
    self.imagead = [Imgestring objectForKey:@"bannerUrl"];
}
- (IBAction)keepImageAction:(id)sender {
    NSDictionary *dic = @{@"id":[self.videoDic objectForKey:@"id"],@"bannerUrl":self.imagead};
  dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
      [WKBackstage executeGetBackstageVideoADCreatelWithParameter:dic success:^(id object) {
          dispatch_async(dispatch_get_main_queue(), ^{
              if ([[object objectForKey:@"flag"]intValue]) {
                  NSLog(@"保存成功");
              }
              [self.navigationController popViewControllerAnimated:YES];
          });
                } failed:^(id object) {
          
      }];

  });
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
