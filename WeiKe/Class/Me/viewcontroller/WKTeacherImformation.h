//
//  WKTeacherImformation.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/16.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKTeacherImformation : UIView
@property (weak, nonatomic) IBOutlet UILabel *basicTitle;
@property (weak, nonatomic) IBOutlet UILabel *imagelabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UITextField *nametext;
@property (weak, nonatomic) IBOutlet UILabel *sexLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sexSegment;
@property (weak, nonatomic) IBOutlet UILabel *cardIdLabel;
@property (weak, nonatomic) IBOutlet UITextField *cardIdText;
@property (weak, nonatomic) IBOutlet UILabel *phoneLabel;
@property (weak, nonatomic) IBOutlet UILabel *loginLabel;
@property (weak, nonatomic) IBOutlet UITextField *phoneNumText;
@property (weak, nonatomic) IBOutlet UILabel *emailLabel;
@property (weak, nonatomic) IBOutlet UITextField *emailText;
@property (weak, nonatomic) IBOutlet UILabel *teachTitle;
@property (weak, nonatomic) IBOutlet UILabel *teachGrade;
@property (weak, nonatomic) IBOutlet UILabel *teachGradeText;
@property (weak, nonatomic) IBOutlet UILabel *teachClass;
@property (weak, nonatomic) IBOutlet UITextView *teachClassText;
@property (weak, nonatomic) IBOutlet UILabel *job;
@property (weak, nonatomic) IBOutlet UILabel *jobText;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *subjectText;
@property (weak, nonatomic) IBOutlet UIView *line1;
@property (weak, nonatomic) IBOutlet UIView *line2;
@property (weak, nonatomic) IBOutlet UIView *line3;
@property (weak, nonatomic) IBOutlet UIView *line4;
@property (weak, nonatomic) IBOutlet UIView *line5;
@property (weak, nonatomic) IBOutlet UIView *line6;
@property (weak, nonatomic) IBOutlet UIView *line7;
@property (weak, nonatomic) IBOutlet UIView *line8;
@property (weak, nonatomic) IBOutlet UIView *line9;
@property (weak, nonatomic) IBOutlet UIView *lastline;
@property (weak, nonatomic) IBOutlet UIButton *keepButton;
@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@end
