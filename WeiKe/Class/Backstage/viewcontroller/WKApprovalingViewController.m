//
//  WKApprovalingViewController.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/25.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKApprovalingViewController.h"

@interface WKApprovalingViewController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *passLabel;
@property (weak, nonatomic) IBOutlet UILabel *approvalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *isPass;
@property (weak, nonatomic) IBOutlet UITextView *approvalTextView;
@property (weak, nonatomic) IBOutlet UIButton *SureButton;

@end

@implementation WKApprovalingViewController
-(void)initStyle{
    self.passLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.approvalLabel.textColor = [WKColor colorWithHexString:DARK_COLOR];
    self.isPass.tintColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.approvalTextView.textColor = [WKColor colorWithHexString:@"999999"];
    self.approvalTextView.delegate = self;
    [self.SureButton setTitleColor:[WKColor colorWithHexString:WHITE_COLOR] forState:UIControlStateNormal];
    self.SureButton.backgroundColor = [WKColor colorWithHexString:GREEN_COLOR];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initStyle];
       // Do any additional setup after loading the view from its nib.
}
- (void)textViewDidBeginEditing:(UITextView *)textView{
    if([textView.text isEqualToString:@"请输入审批意见"]){
        textView.text=@"";
        textView.textColor=[WKColor colorWithHexString:@"333333"];
    }
    else if (textView.text.length){
        textView.textColor=[WKColor colorWithHexString:@"333333"];
        
    }
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if(!textView.text.length ){
        textView.text = @"请输入审批意见";
        textView.textColor = [WKColor colorWithHexString:@"999999"];
    }
}
- (IBAction)sureAction:(id)sender {
    NSDictionary *dic;
    if (self.isMore ==0) {
        dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":[NSNumber numberWithInteger:self.videoModel.id],@"approvalStatus":[NSNumber numberWithInteger:self.isPass.selectedSegmentIndex+1],@"auditOpinion":self.approvalTextView.text};
    }
    else{
        NSString *cellid =@"0";
        for (int i=0; i<self.videoarr.count; i++) {
            WKVideoModel *model = self.videoarr[i];
            if (i==0) {
                cellid = [NSString stringWithFormat:@"%lu",model.id];
            }
            else{
                cellid =[NSString stringWithFormat:@"%@,%lu",cellid,model.id];
            }
            
        }

         dic = @{@"loginUserId":LOGINUSERID,@"schoolId":SCOOLID,@"ids":cellid,@"approvalStatus":[NSNumber numberWithInteger:self.isPass.selectedSegmentIndex+1],@"auditOpinion":self.approvalTextView.text};
    }
    __weak typeof(self) weakself = self;

    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [WKBackstage executeGetBackstageApprovalingVideoWithParameter:dic success:^(id object) {
            // NSLog(@"object  = %@",object);
                       dispatch_async(dispatch_get_main_queue(), ^{
                           if ([[object objectForKey:@"flag"] intValue]) {
                               [weakself.navigationController popViewControllerAnimated:YES];
                           }
              
            });
        } failed:^(id object) {
            // NSLog(@"nserroer= %@",object);
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
