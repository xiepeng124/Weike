//
//  WKCommentMeTableViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/6/20.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKCommentMeTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *commenttitle;
@property (weak, nonatomic) IBOutlet UILabel *commentCOntent;
@property (weak, nonatomic) IBOutlet UILabel *commentTime;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIImageView *videoImage;
@property (weak, nonatomic) IBOutlet UIView *commentbackView;
@property (weak, nonatomic) IBOutlet UILabel *commented;
+ (CGFloat)heightForLabel:(NSString *)text withIndex:(NSInteger) index;
+ (CGFloat)heightForTwoLabel:(NSString *)text;
@end
