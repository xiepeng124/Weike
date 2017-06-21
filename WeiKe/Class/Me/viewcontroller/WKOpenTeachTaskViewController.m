//
//  WKOpenTeachTaskViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKOpenTeachTaskViewController.h"
#import <WebKit/WebKit.h>
@interface WKOpenTeachTaskViewController ()<WKNavigationDelegate>
@property (strong,nonatomic)UIProgressView *progressView;
@property (strong,nonatomic)WKWebView *webview;
@end

@implementation WKOpenTeachTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  _progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 0)];
    _progressView.progressTintColor = [UIColor blueColor];
    _progressView.trackTintColor = [UIColor clearColor];
  
    //self.progressView = progressView;

   _webview = [[WKWebView alloc]initWithFrame:self.view.bounds];
    _webview.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    NSURL *url = [NSURL URLWithString:self.taskUrl];

    if ([self.taskUrl containsString:@".txt"] ) {
      
        NSString *body =[NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
      if  (!body) {
          body =[NSString stringWithContentsOfURL:url encoding:0x80000632 error:nil];
      }
        if (!body) {
            //再使用GB18030解码
            NSLog(@"GBK18030");
            body = [NSString stringWithContentsOfURL:url encoding:0x80000631 error:nil];
    }
        if (body) {
            [_webview loadHTMLString:body baseURL:nil];
        }

    }
    else{
      NSURLRequest *req = [NSURLRequest requestWithURL:url];
    [_webview loadRequest:req];
}
    _webview.navigationDelegate =self;
        
    [self.view addSubview:_webview];
   // [self.view insertSubview:_webview belowSubview:_progressView];
      [self.view addSubview:_progressView];
    [_webview addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    // Do any additional setup after loading the view.
}
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if (object == self.webview && [keyPath isEqualToString:@"estimatedProgress"])
    {
        CGFloat newprogress = [[change objectForKey:NSKeyValueChangeNewKey] doubleValue];
        if (newprogress == 1)
        {
            self.progressView.hidden = YES;
            [self.progressView setProgress:0 animated:NO];
        }
        else
        {
            self.progressView.hidden = NO;
            [self.progressView setProgress:newprogress animated:YES];
        }
    }
}
-(void)dealloc{
    [self.webview removeObserver:self forKeyPath:@"estimatedProgress"];
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
