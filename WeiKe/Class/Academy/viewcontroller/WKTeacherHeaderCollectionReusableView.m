//
//  WKTeacherHeaderCollectionReusableView.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKTeacherHeaderCollectionReusableView.h"

@implementation WKTeacherHeaderCollectionReusableView

- (void)awakeFromNib {
    [super awakeFromNib];
    self.garde.font = [UIFont fontWithName:FONT_BOLD size:17];
    self.garde.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    self.course.font = [UIFont fontWithName:FONT_BOLD size:17];
    self.course.textColor = [WKColor colorWithHexString:GREEN_COLOR];
    UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(ChangeBottom)];
    self.course.userInteractionEnabled = YES;
    [self.course addGestureRecognizer:ges];
    [self.selectedbutton setImage:[UIImage imageNamed:@"teacher_select_off"] forState:UIControlStateNormal];
    [self.selectedbutton setImage:[UIImage imageNamed:@"teacher_select_on"] forState:UIControlStateSelected];
  [self.selectedbutton addTarget:self action:@selector(ChangeSelectedImage) forControlEvents:UIControlEventTouchUpInside];
    self.myteacher.font = [UIFont fontWithName:FONT_REGULAR size:15];
    self.myteacher.textColor = [WKColor colorWithHexString:@"666666"];
    self.backgroundColor = [WKColor colorWithHexString:WHITE_COLOR];
    [self.bottomButton setImage:[UIImage imageNamed:@"pull-down"] forState:UIControlStateNormal];
    [self.bottomButton setImage:[UIImage imageNamed:@"arrows_up"] forState:UIControlStateSelected];
    [self.bottomButton addTarget:self action:@selector(ChangeBottom) forControlEvents:UIControlEventTouchUpInside];
//    self.foot = [[WKTeScreenFootCollectionReusableView alloc]init];
//    self.foot.delegate =self;
//    
    //self.layer.cornerRadius = 3;
    // Initialization code
}
-(void)ChangeSelectedImage{
    self.selectedbutton.selected = !self.selectedbutton.selected;
    [self.delegate ChanggeMyteacher:self.selectedbutton];
}
-(void)ChangeBottom{
    self.bottomButton.selected = !self.bottomButton.selected;
    [self.delegate ChangeBottom:self.bottomButton];
}
@end
