//
//  WKJobImageTableViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/2.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKJobImageTableViewCell.h"

@implementation WKJobImageTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    // Initialization code
}
-(void)drawRect:(CGRect)rect{
//    _JobimageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH-20, (SCREEN_WIDTH-20)/16*9 )];
//    _JobimageView.image = [UIImage imageNamed:@"water"];
   // [self addSubview:self.JobimageView];

     [self.contentView addSubview:_JobimageView];
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
