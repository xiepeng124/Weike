//
//  WKJobScore.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/1.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKJobScore : UIView
@property (weak, nonatomic) IBOutlet UILabel *basicLabel;
@property (weak, nonatomic) IBOutlet UILabel *JobNamelabel;
@property (weak, nonatomic) IBOutlet UILabel *JoinLabel;
@property (weak, nonatomic) IBOutlet UILabel *FileLabel;
@property (weak, nonatomic) IBOutlet UILabel *beginLabel;
@property (weak, nonatomic) IBOutlet UILabel *endLabel;
@property (weak, nonatomic) IBOutlet UILabel *remark;
@property (weak, nonatomic) IBOutlet UILabel *sendJobLabel;
@property (weak, nonatomic) IBOutlet UILabel *JoinStuLabel;
@property (weak, nonatomic) IBOutlet UILabel *notSendLabel;
@property (weak, nonatomic) IBOutlet UITextField *jobName;
@property (weak, nonatomic) IBOutlet UITextField *joinClass;
@property (weak, nonatomic) IBOutlet UIButton *downloadButton;
@property (weak, nonatomic) IBOutlet UITextField *beginTime;
@property (weak, nonatomic) IBOutlet UITextField *endTime;
@property (weak, nonatomic) IBOutlet UITextView *remarkText;
@property (weak, nonatomic) IBOutlet UITextField *joinStu;
@property (weak, nonatomic) IBOutlet UITextField *notSendStu;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIView *line7;
@property (weak, nonatomic) IBOutlet UIView *line8;
@end
