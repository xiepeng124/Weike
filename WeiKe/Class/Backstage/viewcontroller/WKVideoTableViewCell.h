//
//  WKVideoTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/5/12.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol VideoDelegate <NSObject>
-(void)selctedVideo:(UIButton*) button;
@end

@interface WKVideoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectedButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UILabel *promulgator;
@property (weak, nonatomic) IBOutlet UILabel *subject;
@property (weak, nonatomic) IBOutlet UILabel *stateLabel;
@property (weak, nonatomic) IBOutlet UIButton *adButton;
@property (weak, nonatomic) IBOutlet UIButton *promuButton;
@property (weak, nonatomic) id<VideoDelegate>delegate;
+ (CGFloat)widthForLabel:(NSString *)text;
@end
