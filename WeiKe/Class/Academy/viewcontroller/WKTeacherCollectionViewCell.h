//
//  WKTeacherCollectionViewCell.h
//  WeiKe
//
//  Created by 华驰科技 on 2017/4/24.
//  Copyright © 2017年 谢鹏. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKTeacherCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIImageView *teacherImage;
@property (weak, nonatomic) IBOutlet UILabel *teachername;
@property (weak, nonatomic) IBOutlet UILabel *grade;
@property (weak, nonatomic) IBOutlet UIImageView *subjectImage;

@end
