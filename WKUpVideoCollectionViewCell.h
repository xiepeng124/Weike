//
//  WKUpVideoCollectionViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/23.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKUpVideoCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *videoCover;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;

@property (weak, nonatomic) IBOutlet UIButton *editCover;
@property (nonatomic, copy) void(^ACMediaClickDelete2Button)();
@end
