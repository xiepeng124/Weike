//
//  WKIndicatorSetViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKIndicatorSetViewController.h"
#import "WKBackstage.h"
@interface WKIndicatorSetViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *uploadLabel;
@property (weak, nonatomic) IBOutlet UITextField *uploadNumber;
@property (weak, nonatomic) IBOutlet UILabel *playLabel;
@property (weak, nonatomic) IBOutlet UITextField *playNumber;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (strong, nonatomic) WKIndicatorModel *model;

@property (weak, nonatomic) IBOutlet UIView *lineBiew;

@end

@implementation WKIndicatorSetViewController
-(void)initStyle{
    self.uploadLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.playLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.uploadNumber.textColor = [WKColor colorWithHexString:@"333333"];
    self.playNumber.textColor = [WKColor colorWithHexString:@"333333"];
    self.lineBiew.backgroundColor = [WKColor colorWithHexString:BACK_COLOR];
    self.uploadNumber.delegate = self;
    self.playNumber.delegate = self;
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.uploadNumber];
     [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge) name:UITextFieldTextDidChangeNotification object:self.playNumber];
    self.keepButton.layer.cornerRadius = 3;
}
-(void)initData{
    __weak typeof(self) weakself = self;
    NSDictionary *dic =@{@"schoolId":SCOOLID};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageIndicatorVideoWithParameter:dic success:^(id object) {
            // NSLog(@"object  = %@",object);
            weakself. model = object;
            dispatch_async(dispatch_get_main_queue(), ^{
                weakself.uploadNumber.text =  [NSString stringWithFormat:@"%lu",weakself.model.videoCount];
                weakself.playNumber.text = [NSString stringWithFormat:@"%lu",weakself.model.playTimes];
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });
    

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    self.view.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated{
    [self initData];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    
    return [self validateNumber:string];
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789"];
    int i = 0;
    while (i < number.length) {
        NSString * string = [number substringWithRange:NSMakeRange(i, 1)];
        NSRange range = [string rangeOfCharacterFromSet:tmpSet];
        if (range.length == 0) {
            res = NO;
            break;
        }
        i++;
    }
    return res;
}
-(void)textchangge{
if (!self.playNumber.text.length||!self.uploadNumber.text.length) {
    [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
    self.keepButton.userInteractionEnabled = NO;
}
else{
    [self.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
    [self.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.keepButton.userInteractionEnabled = YES ;
    
}
}
- (IBAction)keepAction:(id)sender {
    __weak typeof(self) weakself = self;
    NSDictionary *dic =@{@"schoolId":SCOOLID,@"loginUserId":LOGINUSERID,@"isHas":self.model.isHas,@"id":[NSNumber numberWithInteger:self.model.id],@"videoCount":self.uploadNumber.text,@"playTimes":self.playNumber.text};
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageIndicatorVideoKeepWithParameter:dic success:^(id object) {
      
           
            dispatch_async(dispatch_get_main_queue(), ^{
                if ([[object objectForKey:@"flag"]intValue]) {
                    [weakself.navigationController popViewControllerAnimated:YES];
                }
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
        }];
        
    });

}
-(void)dealloc{
    [[NSNotificationCenter defaultCenter]removeObserver:self];
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
