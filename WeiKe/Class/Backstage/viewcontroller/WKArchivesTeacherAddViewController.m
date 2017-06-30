//
//  WKArchivesTeacherAddViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/30.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKArchivesTeacherAddViewController.h"
#import "WKTeacherImformation.h"
#import "WKCheackModel.h"
#import "WKUploadImage.h"
@interface WKArchivesTeacherAddViewController ()<UITextFieldDelegate,upImageDelegate>
@property (nonatomic,strong) WKTeacherImformation *teachImf;
@property(nonatomic,strong)UITableView *mytableView;
@property (nonatomic,strong) MBProgressHUD *hud;
@property (nonatomic,strong) WKUploadImage *uploadImage;
@end

@implementation WKArchivesTeacherAddViewController
#pragma mark - init
-(void)initStyle{
    self.teachImf = [[WKTeacherImformation alloc]init];
    self.teachImf = [[[NSBundle mainBundle]loadNibNamed:@"TeacherImformationHeaderView" owner:nil options:nil]lastObject];
    self.teachImf.frame = CGRectMake(0, 0, SCREEN_WIDTH, 595);
    self.teachImf.cardIdText.delegate =self;
    self.teachImf.phoneNumText.delegate = self;
    self.teachImf.emailText.delegate =self;
    self.teachImf.cardIdText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.teachImf.phoneNumText.keyboardType = UIKeyboardTypePhonePad;
    self.teachImf.emailText.keyboardType = UIKeyboardTypeEmailAddress;
    self.teachImf.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView = [[UITableView alloc]initWithFrame:self.view.frame style:UITableViewStylePlain];
    self.mytableView.backgroundColor = [WKColor colorWithHexString:LIGHT_COLOR];
    self.mytableView.tableHeaderView = self.teachImf;
    self.mytableView.showsVerticalScrollIndicator = NO;
    self.mytableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectZero];
    [self.view addSubview:self.mytableView];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.nametext];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.cardIdText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.emailText];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textchangge:) name:UITextFieldTextDidChangeNotification object:self.teachImf.phoneNumText];
    [self.teachImf.keepButton addTarget:self action:@selector(keepMydataAction) forControlEvents:UIControlEventTouchUpInside ];
    self.hud = [[MBProgressHUD alloc]init];
    self.hud.center = CGPointMake(SCREEN_WIDTH/2, SCREEN_HEIGHT/2);
    self.hud.label.font = [UIFont fontWithName:FONT_BOLD size:14];
    self.hud.mode = MBProgressHUDModeIndeterminate;
    self.hud.label.text = @"正在保存";
    [self.view addSubview:self.hud];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(switchImageAction)];
        self.teachImf.headImageView.userInteractionEnabled = YES;
        [self.teachImf.headImageView addGestureRecognizer:ges];
        
    

}
#pragma mark - view did load
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
    // Do any additional setup after loading the view.
}
#pragma mark - 通知
-(void)textchangge:(NSNotification*)notifi{
    if (!self.teachImf.nametext.text.length||!self.teachImf.phoneNumText.text.length) {
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"e5e5e5"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:@"666666"] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = NO;
    }
    else{
        [self.teachImf.keepButton setBackgroundColor:[WKColor colorWithHexString:@"72c456"]];
        [self.teachImf.keepButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
        self.teachImf.keepButton.userInteractionEnabled = YES ;
        
    }
    
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // NSLog(@"string = %@",string);
    
    if (range.length==1&&string.length==0) {
        return YES;
    }
    
    if (textField== self.teachImf.cardIdText) {
        if (self.teachImf.cardIdText.text.length<=18) {
            return [self validateNumber:string];
        }
        
        
        return NO ;
        
    }
    if (textField == self.teachImf.phoneNumText) {
        if (self.teachImf.phoneNumText.text.length<=11) {
            return [self validateNumber:string];
        }
        return NO;
        
    }
    
    return YES;
}

- (BOOL)validateNumber:(NSString*)number {
    BOOL res = YES;
    NSCharacterSet* tmpSet = [NSCharacterSet characterSetWithCharactersInString:@"0123456789xX"];
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
-(void)switchImageAction{
    [self.uploadImage selectUserpicSourceWithViewController:self];
    self.uploadImage.delegate = self;
}
-(void)selctedImage:(NSDictionary*)Imgestring{
    [self.teachImf.headImageView sd_setImageWithURL:[NSURL URLWithString:[Imgestring objectForKey:@"imgFileUrl"] ] placeholderImage:nil options:SDWebImageRetryFailed|SDWebImageLowPriority];
    //self.imageS = [Imgestring objectForKey:@"imgFileUrl"];
    
}

-(void)sendImagesource:(NSString *)sourceName{
    
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
