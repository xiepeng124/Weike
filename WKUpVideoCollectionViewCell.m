//
//  WKUpVideoCollectionViewCell.m
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/23.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import "WKUpVideoCollectionViewCell.h"

@implementation WKUpVideoCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.videoCover.layer.cornerRadius = 3;
    self.videoCover.layer.masksToBounds = YES;
    self.editCover.layer.cornerRadius = 3;
    [_deleteButton addTarget:self action:@selector(clickDeleteButton) forControlEvents:UIControlEventTouchUpInside];

    // Initialization code
}
- (void)clickDeleteButton {
    !_ACMediaClickDelete2Button ?  : _ACMediaClickDelete2Button();
}

@end
