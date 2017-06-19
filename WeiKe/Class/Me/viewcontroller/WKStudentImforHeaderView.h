//
//  WKStudentImforHeaderView.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/18.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKStudentImforHeaderView : UIView
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

@property (weak, nonatomic) IBOutlet UILabel *StuGrade;
@property (weak, nonatomic) IBOutlet UILabel *StuGradeText;
@property (weak, nonatomic) IBOutlet UILabel *stuClass;
@property (weak, nonatomic) IBOutlet UILabel *stuClassText;

@property (weak, nonatomic) IBOutlet UILabel *stuNumber;
@property (weak, nonatomic) IBOutlet UILabel *stuNumberText;
@property (weak, nonatomic) IBOutlet UILabel *schoolRoll;
@property (weak, nonatomic) IBOutlet UILabel *schoolRollText;
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

@end
